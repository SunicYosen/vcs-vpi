module vpi_test_module(input wire clk,
									  	input wire [15:0] a,
								  		input wire [6:0] b,
										  input wire [31:0] c);

reg [15:0] a_temp;
reg [6:0] b_temp;
reg [31:0] count;
reg [31:0] result;

always @(posedge clk)
	a_temp = a;

always @(posedge clk)
	b_temp = b;

always @(posedge clk)
	count = c; 

always @(posedge clk)
begin
	$testParams(a_temp,b_temp,count);
	//$testPut(result);
	$display("Result = %.8h",result);
end

endmodule

