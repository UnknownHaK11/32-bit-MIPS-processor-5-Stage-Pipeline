module mod10_test;
reg clk,rst;
wire [3:0] q;
mod10 uut(.q(q),.rst(rst),.clk(clk));
initial
begin
clk=1'b0;
end
always
#10 clk=~clk;
initial
begin
rst=1'b1;
#10 rst=1'b0;
end
endmodule