module controller
#(
    parameter INST_ADDR = 3'd0, INST_FETCH = 3'd1, INST_LOAD = 3'd2, IDLE = 3'd3, OP_ADDR = 3'd4, OP_FETCH = 3'd5, ALU_OP = 3'd6, STORE = 3'd7,
    OPCODE_WIDTH = 3, PHASE_WIDTH = 3,
    HLT = 3'd0, SKZ = 3'd1, ADD = 3'd2, AND = 3'd3, XOR = 3'd4, LDA = 3'd5, STO = 3'd6, JMP = 3'd7
)
(
    input zero,
    input [OPCODE_WIDTH-1:0] opcode,
    input [PHASE_WIDTH-1:0] phase,
    output reg sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
);

always @(*) begin

    {sel, rd, ld_ir, inc_pc, data_e, ld_ac, ld_pc, wr, halt} = 9'b0;
    
    case (phase)
    INST_ADDR: sel = 1;
    INST_FETCH: begin
        sel = 1; rd = 1;
    end
    INST_LOAD: begin
        sel = 1; rd = 1; ld_ir = 1;
    end
    IDLE: begin
        sel = 1; rd = 1; ld_ir = 1;
    end
    OP_ADDR: begin
        halt = (opcode == HLT) ? 1 : 0;
        inc_pc = 1;
        end

    OP_FETCH: begin
        case (opcode)
            ADD, AND, XOR, LDA: rd = 1;
            default: rd = 0;
        endcase
    end

    ALU_OP: begin
        case (opcode)
            ADD, AND, XOR, LDA: rd = 1;
            default: rd = 0;
        endcase
        inc_pc = (opcode == SKZ && zero) ? 1 : 0;
        ld_pc = (opcode == JMP) ? 1 : 0;
        data_e = (opcode == STO) ? 1 : 0;
    end

    STORE: begin
        case (opcode)
            ADD, AND, XOR, LDA: {rd, ld_ac} = 2'b11;
            default: {rd, ld_ac} = 2'b00;
        endcase
        ld_pc = (opcode == JMP) ? 1 : 0;
        {wr, data_e} = (opcode == STO) ? 2'b11 : 2'b00;
    end
        default: halt = 1;
    endcase

end

endmodule