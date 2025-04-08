// Project: RISC-V CPU
// by: Omar Mohammed Araby

module data_memory(write_data,address,read_data,clk,data_size,extension_type,write_enable);

    // Size of the address and instruction (32 bits)
    parameter SIZE = 32;
    // Base address for the instruction memory
    parameter BASE_ADDRESS = 32'h00000000;
    // Size of the instruction memory (1792 MB)
    parameter mem_SIZE = 1024;

    // input port
    input [SIZE-1:0] write_data;                                        // Input data to be written to the data memory
    input [SIZE-1:0] address;                                           // Address for reading and writing data
    input [1:0] data_size;                                              // Data size (2 bits)
    input clk, write_enable, extension_type;                       // Clock, write enable, extension_type and reset signals

    // output port
    output reg [SIZE-1:0] read_data;                                        // Data read from the specified address

    // Memory array (8-bit wide)
    reg [31:0] data_memory [0:mem_SIZE-1];

    integer i;
    // Write data to memory
    always @(posedge clk) begin
        if (write_enable) begin
            case (data_size)
                2'b00: begin
                    case (address[1:0])
                        2'b00: data_memory[address-BASE_ADDRESS][7:0] <= write_data[7:0];   // Byte 0
                        2'b01: data_memory[address-BASE_ADDRESS][15:8] <= write_data[7:0];  // Byte 1
                        2'b10: data_memory[address-BASE_ADDRESS][23:16] <= write_data[7:0]; // Byte 2
                        2'b11: data_memory[address-BASE_ADDRESS][31:24] <= write_data[7:0]; // Byte 3
                    endcase
                end
                2'b01: begin
                    if (address[0] == 1'b0) // Check if lower half-word
                        data_memory[address-BASE_ADDRESS][15:0] <= write_data[15:0];
                    else // Upper half-word
                        data_memory[address-BASE_ADDRESS][31:16] <= write_data[15:0];
                end
                2'b10: data_memory[address-BASE_ADDRESS] <= write_data; // Word
                default: data_memory[address-BASE_ADDRESS] <= data_memory[address-BASE_ADDRESS];
            endcase
        end
    end

    // Read data from memory
    always @(*) begin
        case (data_size)
            2'b00: begin // Byte
                case (address[1:0])
                    2'b00: read_data = {{24{!extension_type & data_memory[address-BASE_ADDRESS][7]}}, data_memory[address-BASE_ADDRESS][7:0]};
                    2'b01: read_data = {{24{!extension_type & data_memory[address-BASE_ADDRESS][15]}}, data_memory[address-BASE_ADDRESS][15:8]};
                    2'b10: read_data = {{24{!extension_type & data_memory[address-BASE_ADDRESS][23]}}, data_memory[address-BASE_ADDRESS][23:16]};
                    2'b11: read_data = {{24{!extension_type & data_memory[address-BASE_ADDRESS][31]}}, data_memory[address-BASE_ADDRESS][31:24]};
                endcase
            end
            2'b01: begin // Halfword
                if (address[1] == 1'b0) // Lower half-word
                    read_data = {{16{!extension_type & data_memory[address-BASE_ADDRESS][15]}}, data_memory[address-BASE_ADDRESS][15:0]};
                else // Upper half-word
                    read_data = {{16{!extension_type & data_memory[address-BASE_ADDRESS][31]}}, data_memory[address-BASE_ADDRESS][31:16]};
            end
            2'b10: read_data = data_memory[address-BASE_ADDRESS]; // Word
            default: read_data = 32'b0; // Default case
        endcase
    end
endmodule