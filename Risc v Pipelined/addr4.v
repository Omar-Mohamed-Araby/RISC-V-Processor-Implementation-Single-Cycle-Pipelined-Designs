// Project: RISC-V CPU
// by: Omar Mohamed Araby

module addr4 (pc, pc_plus4);
    input [31:0] pc;
    output [31:0] pc_plus4;

    assign pc_plus4 = pc + 4;

endmodule