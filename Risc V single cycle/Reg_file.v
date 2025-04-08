// Project: RISC-V CPU
// by: Omar Mohammed Araby

module Reg_file (clk,rst,write_en, read_addr1, read_addr2, write_addr, write_data, data1, data2 );
    
    parameter SIZE = 32;
    input clk, rst, write_en; // Clock, reset, write enable
    input [4:0] read_addr1, read_addr2, write_addr; // Read address 1, read address 2, write address
    input [SIZE-1:0] write_data; // Write data
    output  [SIZE-1:0] data1, data2; // Read data 1, read data 2


    reg [SIZE-1:0] regfile [0:SIZE-1]; // Register file
 
    // Read operations
    assign data1 = (read_addr1 != 0) ? regfile[read_addr1] : 32'b0;
    assign data2 = (read_addr2 != 0) ? regfile[read_addr2] : 32'b0; 

    integer i;
    // Write operation
    always @(posedge clk) begin
        regfile[0] = 32'b0; // Register 0 is always 0
        if (rst) begin
            // Reset all registers to 0
            for (i = 0; i < 32; i = i + 1) begin
                if (i == 2) 
                    regfile[i] <= 32'h500;
                else
                regfile[i] <= 32'b0;
            end
        end else if (write_en && write_addr != 0) begin
            // Write data to the register file
            regfile[write_addr] <= write_data;
        end
    end

endmodule