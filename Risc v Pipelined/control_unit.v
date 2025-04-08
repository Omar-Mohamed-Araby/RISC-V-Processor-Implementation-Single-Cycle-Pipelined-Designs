// Project: RISC-V CPU
// by: Omar Mohamed Araby

module control_unit (op,funct3,funct7,imm_sel,B_J,memwrite_en,regwrite_en,alu_op,data_size, extension_type,wb_src,alu_src,op1_src);
    input [6:0] op,funct7;
    input [2:0] funct3;

    output reg [2:0] imm_sel;
    output reg [2:0] B_J;
    output reg memwrite_en,regwrite_en;
    output reg [3:0] alu_op;
    output reg [1:0] data_size;
    output reg  extension_type;
    output reg [1:0] wb_src;
    output reg alu_src,op1_src;

    always @(*) begin
        case(op)
        7'b0110111: begin // LUI
            imm_sel = 3'b000; // U-FORMAT
            op1_src = 1'b0;
            alu_src = 1'b0;
            alu_op = 4'b0000;  // ADD
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b000; 
            data_size = 2'b11; 
            extension_type = 1'b0;
            wb_src = 2'b10; // IMMEDIATE
        end
        7'b0010111: begin // AUIPC
            imm_sel = 3'b000; // U-FORMAT
            op1_src = 1'b1; // PC
            alu_src = 1'b1; // immediate
            alu_op = 4'b0000; // ADD
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b000;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b00; // ALU
        end
        7'b1101111: begin // JAL
            imm_sel = 3'b001; // J-FORMAT
            op1_src = 1'b1; // PC
            alu_src = 1'b1; // immediate
            alu_op = 4'b0000; // ADD
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b111;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b11; // PC+4
        end
        7'b1100111: begin // JALR
            imm_sel = 3'b100; // I-FORMAT-SIGNED
            op1_src = 1'b0; // data1
            alu_src = 1'b1; // immediate
            alu_op = 4'b0000; // ADD
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b111;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b11; // PC+4
        end
        7'b1100011: begin // BRANCH
            imm_sel = 3'b011; // B-FORMAT
            op1_src = 1'b1; // pc
            alu_src = 1'b1; // imediate
            alu_op = 4'b0000; // ADD
            case(funct3)
                3'b000: begin // BEQ
                    B_J = 3'b001;
                end
                3'b001: begin // BNE
                    B_J = 3'b010;
                end
                3'b100: begin // BLT
                    B_J = 3'b011;
                end
                3'b101: begin // BGE
                    B_J = 3'b100;
                end
                3'b110: begin // BLTU
                    B_J = 3'b101;
                end
                3'b111: begin // BGEU
                    B_J = 3'b110;
                end
                default: begin
                    B_J = 3'b000;
                end
            endcase
            memwrite_en = 1'b0;
            regwrite_en = 1'b0;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b00; // ALU
        end
        7'b0000011: begin // LOAD
            imm_sel = 3'b100; // I-FORMAT-UNSIGNED
            op1_src = 1'b0; // data1
            alu_src = 1'b1; // immediate
            alu_op = 4'b0000; // ADD
            case(funct3)
                3'b000: begin // LB
                    data_size = 2'b00;
                    extension_type = 1'b0;
                end
                3'b001: begin // LH
                    data_size = 2'b01;
                    extension_type = 1'b0;
                end
                3'b010: begin // LW
                    data_size = 2'b10;
                    extension_type = 1'b0;
                end
                3'b100: begin // LBU
                    data_size = 2'b00;
                    extension_type = 1'b1;
                end
                3'b101: begin // LHU
                    data_size = 2'b01;
                    extension_type = 1'b1;
                end
                default: begin
                    data_size = 2'b11;
                    extension_type = 1'b0;
                end
            endcase
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b000;
            wb_src = 2'b01; // MEM
        end
        7'b0100011: begin // STORE
            imm_sel = 3'b010; // S-FORMAT
            op1_src = 1'b0; // data1
            alu_src = 1'b1; // immediate
            alu_op = 4'b0000; // ADD
            case(funct3)
                3'b000: begin // SB
                    data_size = 2'b00;
                end
                3'b001: begin // SH
                    data_size = 2'b01;
                end
                3'b010: begin // SW
                    data_size = 2'b10;
                end
                default: begin
                    data_size = 2'b11;
                end
            endcase
            extension_type = 1'b0;
            memwrite_en = 1'b1;
            regwrite_en = 1'b0;
            B_J = 3'b000;
            wb_src = 2'b00; // ALU
        end
        7'b0010011: begin // IMMEDIATE
            case(funct3)
            3'b000: begin // ADDI
                imm_sel = 3'b100; // I-FORMAT-SIGNED
                alu_op = 4'b0000; // ADD
            end
            3'b010: begin // SLTI
                imm_sel = 3'b100; // I-FORMAT-SIGNED
                alu_op = 4'b1000; // SLT
            end
            3'b011: begin // SLTIU
                imm_sel = 3'b110; // I-FORMAT-UNSIGNED
                alu_op = 4'b1001; // SLTU
            end
            3'b100: begin // XORI
                imm_sel = 3'b100; // I-FORMAT-SIGNED
                alu_op = 4'b0100; // XOR
            end
            3'b110: begin // ORI
                imm_sel = 3'b100; // I-FORMAT-SIGNED
                alu_op = 4'b0011; // OR
            end
            3'b111: begin // ANDI
                imm_sel = 3'b100; // I-FORMAT-SIGNED
                alu_op = 4'b0010; // AND
            end
            3'b001: begin // SLLI
                imm_sel = 3'b101; // I-SHIFT-FORMAT
                alu_op = 4'b0101; // SLL
            end
            3'b101: begin // SRLI/SRAI
                imm_sel = 3'b101; // I-SHIFT-FORMAT
                case(funct7)
                7'b0000000: begin // SRLI
                    alu_op = 4'b0110;
                end
                7'b0100000: begin // SRAI
                    alu_op = 4'b0111;
                end
                default: begin
                    alu_op = 4'b0110;
                end
                endcase
            end
            default: begin
                imm_sel = 3'b100; // Default to I-FORMAT-SIGNED
                alu_op = 4'b0000; // ADD
            end
            endcase
            op1_src = 1'b0; // data1
            alu_src = 1'b1; // immediate
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b000;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b00; //ALU
        end
        7'b0110011: begin // R-TYPE
            imm_sel = 3'b000; // R-FORMAT
            case(funct3)
            3'b000: begin // ADD/SUB
                case(funct7)
                7'b0000000: begin // ADD
                    alu_op = 4'b0000; 
                end
                7'b0100000: begin // SUB
                    alu_op = 4'b0001;
                end
                default: begin
                    alu_op = 4'b0000;
                end
                endcase
            end
            3'b001: begin // SLL
                alu_op = 4'b0101;
            end
            3'b010: begin // SLT
                alu_op = 4'b1000;
            end
            3'b011: begin // SLTU
                alu_op = 4'b1001;
            end
            3'b100: begin // XOR
                alu_op = 4'b0100;
            end
            3'b101: begin // SRL/SRA
                case(funct7)
                7'b0000000: begin // SRL
                    alu_op = 4'b0110;
                end
                7'b0100000: begin // SRA
                    alu_op = 4'b0111;
                end
                default: begin
                    alu_op = 4'b0110;
                end
                endcase
            end
            3'b110: begin // OR
                alu_op = 4'b0011;
            end
            3'b111: begin // AND
                alu_op = 4'b0010;
            end
            default: begin
                alu_op = 4'b0000;
            end
            endcase
            op1_src = 1'b0; // data1
            alu_src = 1'b0; // data2
            memwrite_en = 1'b0;
            regwrite_en = 1'b1;
            B_J = 3'b000;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b00; //ALU
        end
        default: begin
            imm_sel = 3'b000; // Default
            op1_src = 1'b0; // data1
            alu_src = 1'b0; // data2
            alu_op = 4'b0000; // ADD
            memwrite_en = 1'b0;
            regwrite_en = 1'b0;
            B_J = 3'b000;
            data_size = 2'b11;
            extension_type = 1'b0;
            wb_src = 2'b00; //ALU
        end
    endcase
    end

    
endmodule