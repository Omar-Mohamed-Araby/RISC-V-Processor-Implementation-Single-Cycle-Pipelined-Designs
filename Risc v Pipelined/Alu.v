// Project: RISC-V CPU
// by: Omar Mohamed Araby

module ALU (operand_1, operand_2, ALU_op, ALU_Result, Zero);

    parameter SIZE = 32;

    input signed [SIZE-1:0] operand_1,operand_2;    // Operands
    input  [3:0] ALU_op;        // ALU operation selection
    output reg [SIZE-1:0] ALU_Result;   // ALU result
    output Zero;                // Zero flag

always @(*) begin
    case (ALU_op)
        4'b0000: ALU_Result = operand_1 + operand_2; // Add
        4'b0001: ALU_Result = operand_1 - operand_2; // Sub
        4'b0010: ALU_Result = operand_1 & operand_2; // AND
        4'b0011: ALU_Result = operand_1 | operand_2; // OR
        4'b0100: ALU_Result = operand_1 ^ operand_2; // XOR
        4'b0101: ALU_Result = operand_1 << operand_2; // SLL
        4'b0110: ALU_Result = operand_1 >> operand_2; // SRL
        4'b0111: ALU_Result = operand_1 >>> operand_2; // SRA
        4'b1000: ALU_Result = (operand_1 < operand_2) ? 32'b1 : 32'b0; // SLT
        4'b1001: ALU_Result = ($unsigned(operand_1) < $unsigned(operand_2)) ? 32'b1 : 32'b0; // SLTU
        default: ALU_Result = 32'b0; // Default case
    endcase
end

assign Zero = (ALU_Result == 32'b0) ? 1'b1 : 1'b0;

endmodule