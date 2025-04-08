// Project: RISC-V CPU
// by: Omar Mohamed Araby

module jump_branch (data1,data2,B_J,pc_sel);
    input [31:0] data1,data2;
    input [2:0] B_J;
    output reg pc_sel;
    wire equ,less,lessu;

    assign equ = (data1 == data2);
    assign less = (data1 < data2);
    assign lessu = ($unsigned(data1) < $unsigned(data2));

    always @(*) begin
        case(B_J)
            3'b000: pc_sel = 0; // NO
            3'b111: pc_sel = 1; // Jump
            3'b001: pc_sel = equ ? 1 : 0;   // BEQ
            3'b010: pc_sel = !equ ? 1 : 0; // BNE
            3'b011: pc_sel = less ? 1 : 0; // BLT
            3'b100: pc_sel = !less || equ ? 1 : 0; // BGE
            3'b101: pc_sel = lessu ? 1 : 0; // BLTU
            3'b110: pc_sel = !lessu || equ ? 1 : 0; // BGEU
            default: pc_sel = 0;
        endcase
    end

 
endmodule