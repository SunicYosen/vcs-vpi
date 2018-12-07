module helloVPI(input wire clk,
				input wire [15:0] a,
				input wire [6:0] b);

reg [15:0] a_temp;
reg [6:0] b_temp;
reg [31:0] result;

always @(posedge clk)
	a_temp = a;

always @(posedge clk)
	b_temp = b;

always @(posedge clk)
 begin
	$testParams(a_temp,b_temp);
	//$testPut(result);
	$display("Result = %.8h",result);
	$helloVPICPP;
 end

endmodule

