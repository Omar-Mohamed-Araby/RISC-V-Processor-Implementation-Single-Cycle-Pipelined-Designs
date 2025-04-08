// Project: RISC-V CPU
// by: Omar Mohamed Araby

module Mem_reg (RD_E,data2,imm_extended,ALU_Result,memwrite_en,regwrite_en,wb_src,pcplus4,RD_M,data2_out,
imm_extended_out,ALU_Result_out,memwrite_en_out,regwrite_en_out,wb_src_out,pcplus4_out,data_size, extension_type,data_size_out, extension_type_out,clk,rst);
    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;

    input [11:7] RD_E; // Destination register
    input [SIZE-1:0] data2;
    input [SIZE-1:0] imm_extended;
    input [SIZE-1:0] ALU_Result;
    input memwrite_en,regwrite_en;
    input [1:0] wb_src;
    input [SIZE-1:0] pcplus4;
    input [1:0] data_size;
    input extension_type;
    input clk,rst;

    output reg [11:7] RD_M; // Destination register
    output reg [SIZE-1:0] data2_out;
    output reg [SIZE-1:0] imm_extended_out;
    output reg [SIZE-1:0] ALU_Result_out;
    output reg memwrite_en_out,regwrite_en_out;
    output reg [1:0] wb_src_out;
    output reg [1:0] data_size_out;
    output reg extension_type_out;
    output reg [SIZE-1:0] pcplus4_out; 

    always @(posedge clk) begin
        if (rst) begin
            RD_M <= 0; // Destination register
            data2_out <= 0;
            imm_extended_out <= 0;
            ALU_Result_out <= 0;
            memwrite_en_out <= 0;
            regwrite_en_out <= 0;
            wb_src_out <= 0;
            data_size_out <= 0;
            extension_type_out <= 0;
            pcplus4_out <= 0; 
        end else begin
            RD_M <= RD_E; // Destination register
            data2_out <= data2;
            imm_extended_out <= imm_extended;
            ALU_Result_out <= ALU_Result;
            memwrite_en_out <= memwrite_en;
            regwrite_en_out <= regwrite_en;
            wb_src_out <= wb_src;
            data_size_out <= data_size;
            extension_type_out <= extension_type;
            pcplus4_out <= pcplus4; 
        end
    end
    
endmodule