module mod10(clk,rst,q);
input clk,rst;
output reg [3:0] q;
always@(posedge clk or posedge rst)
begin 
if(rst)
q<=4'b0000;
else if (q<=4'b1001)
q<=q+1'b1;
else
q<=4'b0000;
end 
endmodule
