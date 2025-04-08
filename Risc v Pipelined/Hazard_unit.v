// Project: RISC-V CPU
// by: Omar Mohamed Araby

module Hazard_unit (Rs1E,Rs1D,Rs2E,Rs2D,RDe,Rdm,Rdw,wb_src,regwrite_M,regwrite_W,pc_sel,stallf,stallD,flushE,flushD,ForwardA,ForwardB);
    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;

    input [4:0] Rs1E,Rs1D; // Source register 1
    input [4:0] Rs2E,Rs2D; // Source register 2
    input [4:0] Rdm; // Destination register from memory stage
    input [4:0] Rdw; // Destination register from write-back stage
    input [4:0] RDe; // Destination register from execute stage
    input [1:0] wb_src; // Write-back source
    input regwrite_M, regwrite_W; // Register write enable
    input pc_sel; // PC select signal

    output reg stallf, stallD, flushE, flushD;
    output reg [1:0] ForwardA, ForwardB;

    // Forwarding logic for Rs1
    always @(*) begin
        if ((Rs1E == Rdm) && regwrite_M && (Rs1E != 0)) begin
            ForwardA = 2'b10;   
        end else if ((Rs1E == Rdw) && regwrite_W && (Rs1E != 0)) begin
            ForwardA = 2'b01;
        end else begin
            ForwardA = 2'b00;
        end
    end

    // Forwarding logic for Rs2
    always @(*) begin
        if ((Rs2E == Rdm) && regwrite_M && (Rs2E != 0)) begin
            ForwardB = 2'b10;
        end else if ((Rs2E == Rdw) && regwrite_W && (Rs2E != 0)) begin
            ForwardB = 2'b01;
        end else begin
            ForwardB = 2'b00;
        end
    end

    // Stall logic for load-use hazard
    always @(*) begin
        if ((wb_src == 2'b01) && (RDe != 0) && ((RDe == Rs1D) || (RDe == Rs2D))) begin
            stallf = 1;
            stallD = 1;
            flushE = 1;
        end else begin
            stallf = 0;
            stallD = 0;
            flushE = 0;
        end
    end

    // Flush logic for control hazards 
    always @(*) begin
        if (pc_sel) begin // Branch taken
            flushE = 1;
            flushD = 1;
        end else begin
            flushE = 0;
            flushD = 0;
        end
    end

endmodule