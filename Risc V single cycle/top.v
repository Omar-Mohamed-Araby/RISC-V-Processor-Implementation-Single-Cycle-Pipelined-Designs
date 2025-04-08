// Project: RISC-V CPU
// by: Omar Mohammed Araby

module top (clk,rst,out);
    // Input signals
    input clk, rst;


    // Output signals
    output [31:0] out;


    // Internal signals
    wire [31:0] pc_plus4, pc_in, pc_out;
    wire [31:0] instruction;
    wire [31:0] imm_extended;
    wire [31:0] data1, data2, alu_result,mem_data,operand_1,operand_2;
    wire [31:0] write_data;
    wire [3:0] alu_op;
    wire [2:0] imm_sel, B_J;
    wire [1:0] data_size, wb_src;
    wire alu_src, op1_src, memwrite_en, regwrite_en, extension_type, zero, pc_sel;

    // Output wire
    assign out = write_data;

    // Program Counter
    // PC + 4
    addr4 pc_adder (pc_out,pc_plus4);
    // pc_in Mux
    mux32 pc_in_mux (alu_result, pc_plus4 ,pc_sel, pc_in);
    // Program Counter
    PC_reg pc_reg (clk,rst,pc_in,pc_out);

    // Instruction Memory
    inst_mem instruction_memory ({2'b00,pc_out[31:2]},instruction);

    // Immediate Extension
    imm_extend imm_extender (instruction[31:7],imm_extended,imm_sel);

    // Register File
    Reg_file reg_file (clk,rst,regwrite_en,instruction[19:15],instruction[24:20],instruction[11:7],write_data,data1,data2);

    //operand1 Mux 
    mux32 operand_1_mux (pc_out,data1,op1_src,operand_1);
    
    //operand2 Mux
    mux32 operand_2_mux (imm_extended,data2,alu_src,operand_2);

    // ALU
    ALU alu (operand_1,operand_2,alu_op,alu_result,zero);

    // Data Memory
    data_memory data_mem (data2,{2'b00,alu_result[31:2]},mem_data,clk,data_size,extension_type,memwrite_en);

    // Control Unit
    control_unit control (instruction[6:0],instruction[14:12],instruction[31:25],imm_sel,B_J,memwrite_en,regwrite_en,alu_op,data_size, extension_type,wb_src,alu_src,op1_src);

    // Jump and Branch Unit
    jump_branch jump_branch_unit (data1,data2,B_J,pc_sel);


    // Write Back Mux
    mux2 wb_mux (wb_src,alu_result,mem_data,imm_extended,pc_plus4,write_data);

endmodule