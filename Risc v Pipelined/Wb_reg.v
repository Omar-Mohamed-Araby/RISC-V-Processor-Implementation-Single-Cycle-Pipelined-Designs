// Project: RISC-V CPU
// by: Omar Mohamed Araby

module Write_back_reg (RD,imm_extended,ALU_Result,pcplus4,mem_data,regwrite_en,wb_src,RD_out,imm_extended_out,
ALU_Result_out,pcplus4_out,mem_data_out,regwrite_en_out,wb_src_out,clk,rst);
    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;

    input [11:7] RD; // Destination register
    input [SIZE-1:0] imm_extended;
    input [SIZE-1:0] ALU_Result;
    input [SIZE-1:0] pcplus4;
    input [SIZE-1:0] mem_data;
    input regwrite_en;
    input [1:0] wb_src;
    input clk,rst;

    output reg [11:7] RD_out; // Destination register
    output reg [SIZE-1:0] imm_extended_out;
    output reg [SIZE-1:0] ALU_Result_out;
    output reg [SIZE-1:0] pcplus4_out; 
    output reg [SIZE-1:0] mem_data_out;
    output reg regwrite_en_out;
    output reg [1:0] wb_src_out;

    always @(posedge clk) begin
        if (rst) begin
            RD_out <= 0; // Destination register
            imm_extended_out <= 0;
            ALU_Result_out <= 0;
            pcplus4_out <= 0; 
            mem_data_out <= 0;
            regwrite_en_out <= 0;
            wb_src_out <= 0;
        end else begin
            RD_out <= RD; // Destination register
            imm_extended_out <= imm_extended;
            ALU_Result_out <= ALU_Result;
            pcplus4_out <= pcplus4; 
            mem_data_out <= mem_data;
            regwrite_en_out <= regwrite_en;
            wb_src_out <= wb_src;
        end
    end
    
endmodule