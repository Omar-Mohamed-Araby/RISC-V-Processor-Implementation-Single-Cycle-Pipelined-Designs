module Testbench (clk,rst);
    
    output reg clk, rst; // Declare clk and rst as reg types for simulation purposes
    top risc_v(clk,rst);
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end
    // Reset generation
    initial begin
        rst = 1; // Assert reset
        #10 rst = 0; // Deassert reset after 10 time units
    end
    // Simulation time
    initial begin
        #10000; // Run the simulation for 1000 time units
        $stop; // End the simulation
    end
endmodule