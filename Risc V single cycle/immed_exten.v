// Project: RISC-V CPU
// by: Omar Mohammed Araby

module imm_extend(imm, extended_imm, imm_src);

    parameter SIZE = 32;

    // input port
    input [31:7] imm;                                                   // Input immediate value (25 bits)
    input [2:0] imm_src;                                                // Input source type (3 bits)

    // output port
    output reg [SIZE-1:0] extended_imm;                                 // Output extended immediate value (32 bits)
    always @(*) begin
        case (imm_src)
        // U-FORMAT-INSTRUCTIONS
            3'b000: extended_imm = {imm[31:12],12'b0};
        // J-FORMAT-INSTRUCTIONS
            3'b001: extended_imm = {{12{imm[31]}}, imm[19:12], imm[20], imm[30:21], 1'b0};   
        // S-FORMAT-INSTRUCTIONS
            3'b010: extended_imm = {{20{imm[31]}}, imm[31:25], imm[11:7]};
        // B-FORMAT-INSTRUCTIONS
            3'b011: extended_imm = {{20{imm[31]}}, imm[7], imm[30:25], imm[11:8], 1'b0};
        // I-FORMAT-SIGNED-INSTRUCTIONS & JALR instruction 
            3'b100: extended_imm = {{20{imm[31]}}, imm[31:20]};
        // I-FORMAT-SHIFT-INSTRUCTIONS
            3'b101: extended_imm = {{27{imm[31]}}, imm[24:20]};
        // I-FORMAT-UNSIGNED-INSTRUCTIONS
            3'b110: extended_imm = {20'b0, imm[31:20]};
        // Default case for invalid instruction format
            default: extended_imm = 32'hxxxxxxxx;
        endcase
end

endmodule