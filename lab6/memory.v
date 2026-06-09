module memory #(
    parameter AWIDTH = 5, DWIDTH = 8
) (
    input wr, rd, clk,
    input [AWIDTH-1:0] addr,
    inout [DWIDTH-1:0] data
);

    reg [DWIDTH-1:0] mem [2**AWIDTH-1:0];
    assign data = (rd == 1) ? mem[addr] : {DWIDTH{1'bz}};
    always @(posedge clk) begin
        mem[addr] <= (wr == 1) ? data : mem[addr];
    end

endmodule