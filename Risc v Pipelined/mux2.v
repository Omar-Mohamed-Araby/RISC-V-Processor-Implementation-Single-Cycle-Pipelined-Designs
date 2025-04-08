// Project: RISC-V CPU
// by: Omar Mohamed Araby

module mux2 (
    input wire [1:0] sel,
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    output reg [31:0] out
);

always @(*) begin
    case (sel)
        2'b00: out = in0;
        2'b01: out = in1;
        2'b10: out = in2;
        2'b11: out = in3;
        default: out = 32'b0;
    endcase
end

endmodule