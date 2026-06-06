module alu 
#(
    parameter  WIDTH = 8, OPCODE_WIDTH = 3
)
(
    input [WIDTH-1:0] in_a, in_b,
    input [OPCODE_WIDTH-1:0] opcode,
    output reg [WIDTH-1:0] alu_out,
    output reg a_is_zero
);

always @(*) begin

if (!in_a)
a_is_zero = 1'b1;
else
a_is_zero = 1'b0;

case (opcode)
3'd0: alu_out = in_a;
3'd1: alu_out = in_a;
3'd2: alu_out = in_a + in_b;
3'd3: alu_out = in_a & in_b;
3'd4: alu_out = in_a ^ in_b;
3'd5: alu_out = in_b;
3'd6: alu_out = in_a;
3'd7: alu_out = in_a;
endcase

end
endmodule