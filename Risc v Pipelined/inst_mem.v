// Project: RISC-V CPU
// by: Omar Mohamed Araby

module inst_mem (addr,instruction);

    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;
    // Base address for the instruction memory
    parameter BASE_ADDRESS = 32'h00000000;
    // Size of the instruction memory (256 words)
    parameter mem_SIZE = 256;
 
    input  [SIZE-1:0] addr;
    output reg [SIZE-1:0] instruction;

    // Instruction memory 
    reg [31:0] inst_memory [0:mem_SIZE-1];

    // Initialize memory with some instructions 
    initial begin
        $readmemh("instructions2.mem", inst_memory);
    end
// Assign the instruction output to the value stored at the specified address
always @(*) begin
 instruction = inst_memory[addr - BASE_ADDRESS];
end    


endmodule