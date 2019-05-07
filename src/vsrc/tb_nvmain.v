// Test nvmain function
// Autor: Sunic
// Time: 2019.05.07
`timescale 1ns/1ps
`define a 0x61
`define A 0x41
`define c 0x63
`define C 0x43
`define l 0x6C
`define L 0x4C
`define r 0x72
`define R 0x52
`define w 0x77
`define W 0x57

module tb_nvamin;

reg         clk;
reg         command_en;
reg [7:0]   arg0_reg;
reg [31:0]  arg1_reg;
reg [31:0]  arg2_reg;
reg [31:0]  arg3_reg;
reg [7:0]   arg4_reg;

always #1 clk = ~clk;

initial
begin
    clk = 0;
    #10
    arg0_reg = 8'h63;
    arg1_reg = 32'd384;
    arg2_reg = 32'd191991292;
    arg3_reg = 32'd12331;
    arg4_reg = 8'h58;   //X
    command_en = 1;
    #2
    command_en = 0;

    #10
    arg0_reg = 8'h43;
    arg1_reg = 32'd384;
    arg2_reg = 32'd191991292;
    arg3_reg = 32'd12331;
    arg4_reg = 8'h58;    //X
    command_en = 1;
    #2
    command_en = 0;

    #10000
    $finish;
end

vpi_test_nvmain vpi_test_nvmain(.clk(clk),
                                .command_enable(command_en),
                                .arg0(arg0_reg),
                                .arg1(arg1_reg),
                                .arg2(arg2_reg),
                                .arg3(arg3_reg),
                                .arg4(arg4_reg));

endmodule

