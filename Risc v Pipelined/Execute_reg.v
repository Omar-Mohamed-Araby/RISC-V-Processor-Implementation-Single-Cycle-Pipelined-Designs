// Project: RISC-V CPU
// by: Omar Mohamed Araby

module Execute_reg (
    data1, data2, RD_D, Rs1_D, Rs2_D, imm_extended, B_J, memwrite_en, regwrite_en, alu_op, data_size, extension_type, wb_src, alu_src, op1_src, pc, pcplus4,
    data1_out, data2_out, RD_E, Rs1_E, Rs2_E, imm_extended_out, B_J_out, memwrite_en_out, regwrite_en_out, alu_op_out, data_size_out, extension_type_out,
    wb_src_out, alu_src_out, op1_src_out, pc_out, pcplus4_out, clk, rst,flush);
    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;

    input [SIZE-1:0] data1;
    input [SIZE-1:0] data2;
    input [11:7] RD_D; // Destination register
    input [4:0] Rs1_D; // Source register 1
    input [4:0] Rs2_D; // Source register 2
    input [SIZE-1:0] imm_extended;
    input [2:0] B_J;
    input memwrite_en, regwrite_en;
    input [3:0] alu_op;
    input [1:0] data_size;
    input extension_type;
    input [1:0] wb_src;
    input alu_src, op1_src;
    input [SIZE-1:0] pc;
    input [SIZE-1:0] pcplus4;
    input clk, rst,flush;

    output reg [SIZE-1:0] data1_out;
    output reg [SIZE-1:0] data2_out;
    output reg [11:7] RD_E; // Destination register
    output reg [4:0] Rs1_E; // Source register 1
    output reg [4:0] Rs2_E; // Source register 2
    output reg [SIZE-1:0] imm_extended_out;
    output reg [2:0] B_J_out;
    output reg memwrite_en_out, regwrite_en_out;
    output reg [3:0] alu_op_out;
    output reg [1:0] data_size_out;
    output reg extension_type_out;
    output reg [1:0] wb_src_out;
    output reg alu_src_out, op1_src_out;
    output reg [SIZE-1:0] pc_out; 
    output reg [SIZE-1:0] pcplus4_out;

    always @(posedge clk) begin
        if (rst || flush) begin
            data1_out <= 0;
            data2_out <= 0;
            RD_E <= 0; // Destination register
            Rs1_E <= 0; // Source register 1
            Rs2_E <= 0; // Source register 2
            imm_extended_out <= 0;
            B_J_out <= 0;
            memwrite_en_out <= 0;
            regwrite_en_out <= 0;
            alu_op_out <= 0;
            data_size_out <= 0;
            extension_type_out <= 0;
            wb_src_out <= 0;
            alu_src_out <= 0;
            op1_src_out <= 0;
            pc_out <= 0; 
            pcplus4_out <= 0; 
        end else begin
            data1_out <= data1;
            data2_out <= data2;
            RD_E <= RD_D; // Destination register
            Rs1_E <= Rs1_D; // Source register 1
            Rs2_E <= Rs2_D; // Source register 2
            imm_extended_out <= imm_extended;
            B_J_out <= B_J;
            memwrite_en_out <= memwrite_en;
            regwrite_en_out <= regwrite_en;
            alu_op_out <= alu_op;
            data_size_out <= data_size;
            extension_type_out <= extension_type;
            wb_src_out <= wb_src;
            alu_src_out <= alu_src;
            op1_src_out <= op1_src; 
            pc_out <= pc; 
            pcplus4_out <= pcplus4; 
        end
    end
    
endmodule