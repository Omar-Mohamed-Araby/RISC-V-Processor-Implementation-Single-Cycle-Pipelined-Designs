// Project: RISC-V CPU
// by: Omar Mohamed Araby

module Decode_reg (instruction,pc,pcplus4,instruction_out,pc_out,pcplus4_out,clk,rst,stall,flush);
    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;

    input [SIZE-1:0] instruction;
    input [SIZE-1:0] pc;
    input [SIZE-1:0] pcplus4;
    input clk,rst,stall;
    input flush;
    output reg [SIZE-1:0] instruction_out;
    output reg [SIZE-1:0] pc_out;
    output reg [SIZE-1:0] pcplus4_out;

    always @(posedge clk) begin
        if (rst || flush) begin
            instruction_out <= 0;
            pc_out <= 0;
            pcplus4_out <= 0;
        end else if (!stall) begin
            instruction_out <= instruction;
            pc_out <= pc;
            pcplus4_out <= pcplus4;
        end
    end
    
endmodule