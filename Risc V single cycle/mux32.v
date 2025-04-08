// Project: RISC-V CPU
// by: Omar Mohammed Araby

module mux32 (
    input [31:0] a,    // First 32-bit input
    input [31:0] b,    // Second 32-bit input
    input sel,         // Select signal
    output [31:0] y    // 32-bit output
);

assign y = sel ? a : b;

endmodule