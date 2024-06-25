module counter_test;
reg clk, rst, up_down;
wire [3:0] q;
counter uut(.q(q),.up_down(up_down),.rst(rst),.clk(clk));
initial 
begin
clk=1'b0;
end
always
#10 clk=~clk;
initial
begin
rst=1'b1;
#10 up_down=1'b1; rst=1'b0;
#100 up_down=1'b0; rst=1'b0;
end
endmodule