// Project: RISC-V CPU
// by: Omar Mohamed Araby

module PC_reg (clk,rst,stall,pc_in,pc_out);

    // Base address for the first memory location
    parameter BASE_LOCATION = 32'h00000000;
    // Size of the instruction
    parameter SIZE = 32;
    
    input [SIZE-1:0] pc_in ;
    input clk, rst, stall ;
    output reg [SIZE-1:0] pc_out ;

    always @(posedge clk) begin
        if (rst) begin
            pc_out <= BASE_LOCATION;
        end
        else if (!stall)
            pc_out <= pc_in;
    end
endmodule