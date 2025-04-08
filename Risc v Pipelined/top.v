// Project: RISC-V CPU
// by: Omar Mohamed Araby

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


    wire stallf, stallD, flushE, flushD;
    wire [1:0] ForwardA, ForwardB;
    wire [31:0] instruction_D,Pc_D,pcplus4_D;


    wire [31:0] data1_E, data2_E; 
    wire [11:7] RD_E;
    wire [19:15] Rs1_E; 
    wire [24:20] Rs2_E; 
    wire [31:0] imm_extended_E; 
    wire [2:0] B_J_E; 
    wire memwrite_en_E, regwrite_en_E,extension_type_E, alu_src_E, op1_src_E;
    wire [3:0] alu_op_E;
    wire [1:0] data_size_E,wb_src_E; 
    wire [31:0] pc_E, pcplus4_E;

    wire [31:0] ForwardA_mux_out , ForwardB_mux_out ;


    wire [11:7] RD_M;
    wire [31:0] data2_M,imm_extended_M,alu_result_M;
    wire memwrite_en_M,regwrite_en_M;
    wire [1:0] wb_src_M;
    wire [31:0] pcplus4_M;
    wire [1:0] data_size_M;
    wire extension_type_M;


    wire [11:7] RD_W;
    wire [31:0] imm_extended_W,alu_result_W;
    wire [31:0] pcplus4_W,mem_data_W;
    wire regwrite_en_W;
    wire [1:0] wb_src_W;
    
    //output assignment
    assign out = write_data; // Output the write data

    // Program Counter
    // PC + 4
    addr4 pc_adder (pc_out,pc_plus4);

    // pc_in Mux
    mux32 pc_in_mux (alu_result, pc_plus4 ,pc_sel, pc_in);

    // Program Counter
    PC_reg pc_reg (clk,rst,stallf,pc_in,pc_out);

    // Instruction Memory
    inst_mem instruction_memory ({2'b00,pc_out[31:2]},instruction); 



    //decode_reg
    Decode_reg decode_reg (instruction,pc_out,pc_plus4,instruction_D,Pc_D,pcplus4_D,clk,rst,stallD,flushD);
    
    // Immediate Extension
    imm_extend imm_extender (instruction_D[31:7],imm_extended,imm_sel);

    // Register File
    Reg_file reg_file (clk,rst,regwrite_en_W,instruction_D[19:15],instruction_D[24:20],RD_W,write_data,data1,data2);

    // Control Unit
    control_unit control (instruction_D[6:0],instruction_D[14:12],instruction_D[31:25],imm_sel,B_J,memwrite_en,regwrite_en,alu_op,data_size, extension_type,wb_src,alu_src,op1_src);



    //execute_reg
    Execute_reg execute_reg (data1, data2, instruction_D[11:7], instruction_D[19:15], instruction_D[24:20], imm_extended, B_J, memwrite_en, 
    regwrite_en, alu_op, data_size, extension_type, wb_src,alu_src, op1_src, Pc_D, pcplus4_D,data1_E, data2_E, RD_E, Rs1_E, Rs2_E, imm_extended_E,
    B_J_E, memwrite_en_E, regwrite_en_E, alu_op_E, data_size_E, extension_type_E,wb_src_E, alu_src_E, op1_src_E, pc_E, pcplus4_E, clk, rst,flushE);

    // Forwarding Mux for data1
    mux2 ForwardA_mux  (ForwardA,data1_E, write_data,alu_result_M,32'b0,ForwardA_mux_out);

    // Forwarding Mux for data2
    mux2 ForwardB_mux  (ForwardB,data2_E,write_data,alu_result_M,32'b0,ForwardB_mux_out);

    //operand1 Mux 
    mux32 operand_1_mux (pc_E,ForwardA_mux_out,op1_src_E,operand_1);
    
    //operand2 Mux
    mux32 operand_2_mux (imm_extended_E,ForwardB_mux_out,alu_src_E,operand_2);

    // Jump and Branch Unit
    jump_branch jump_branch_unit (ForwardA_mux_out,ForwardB_mux_out,B_J_E,pc_sel);

    // ALU
    ALU alu (operand_1,operand_2,alu_op_E,alu_result,zero);



    // mem_reg
    Mem_reg mem_reg (RD_E,ForwardB_mux_out,imm_extended_E,alu_result,memwrite_en_E,regwrite_en_E,wb_src_E,pcplus4_E,RD_M,data2_M,imm_extended_M,alu_result_M,
    memwrite_en_M,regwrite_en_M,wb_src_M,pcplus4_M,data_size_E, extension_type_E,data_size_M, extension_type_M,clk,rst);

    // Data Memory
    data_memory data_mem (data2_M,{2'b00,alu_result_M[31:2]},mem_data,clk,data_size_M,extension_type_M,memwrite_en_M);



    //write_back_reg
    Write_back_reg write_back_reg (RD_M,imm_extended_M,alu_result_M,pcplus4_M,mem_data,regwrite_en_M,wb_src_M,RD_W,imm_extended_W,
alu_result_W,pcplus4_W,mem_data_W,regwrite_en_W,wb_src_W,clk,rst);

    // Write Back Mux
    mux2 wb_mux (wb_src_W,alu_result_W,mem_data_W,imm_extended_W,pcplus4_W,write_data);
     
    // Hazard Unit
    Hazard_unit hazard_unit (Rs1_E,instruction_D[19:15],Rs2_E,instruction_D[24:20],RD_E,RD_M,RD_W,wb_src_E,regwrite_en_M,regwrite_en_W,pc_sel,stallf,stallD,flushE,flushD,ForwardA,ForwardB);

endmodule