module counter
#(
    parameter WIDTH = 5
) (
    input clk, rst, load, enab,
    input [WIDTH-1:0] cnt_in,
    output reg [WIDTH-1:0] cnt_out
);
    always @(posedge clk) begin
        if (rst) cnt_out <= 0;
        else if (load) cnt_out <= cnt_in;
        else if (enab) cnt_out <= cnt_out + 1;
        else cnt_out <= cnt_out;
    end

endmodule