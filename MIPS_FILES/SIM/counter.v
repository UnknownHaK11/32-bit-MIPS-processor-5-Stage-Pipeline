module counter(clk, rst, up_down,q);
input clk, rst, up_down;
output reg [3:0] q;
always@(posedge clk or posedge rst)
begin
if(rst)
q<=4'b0000;
else if(up_down)
q<=q+1'b1;
else 
q<=q-1'b1;
end
endmodule
