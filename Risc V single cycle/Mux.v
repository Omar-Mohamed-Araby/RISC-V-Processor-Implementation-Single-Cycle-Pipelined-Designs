// Project: RISC-V CPU
// by: Omar Mohammed Araby

module Mux (a,b,sel,c);
    input a,b,sel;
    output c;
    
assign c = sel ? a : b;

endmodule