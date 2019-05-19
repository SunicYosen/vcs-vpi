// Test nvmain function
// Autor: Sunic
// Time: 2019.05.07
`timescale 1ns/1ps
`define a 0x61
`define A 0x41
`define c 0x63
`define i 0x69
`define C 0x43
`define l 0x6C
`define L 0x4C
`define r 0x72
`define R 0x52
`define w 0x77
`define W 0x57

module tb_nvmain;

reg         clk;
reg         command_en;
reg [7:0]   arg0_reg;
reg [31:0]  arg1_reg;
reg [31:0]  arg2_reg;
reg [31:0]  arg3_reg;
reg [7:0]   arg4_reg;

wire         is_issuable;

reg [31:0]  count_flag;
reg [2:0]   is_issuable_fre_count;
reg [1:0]   issue_comand_count;

reg [7:0]   arg0_mem [0:9];
reg [31:0]  arg1_mem [0:9];
reg [31:0]  arg2_mem [0:9];
reg [31:0]  arg3_mem [0:9];
reg [7:0]   arg4_mem [0:9];

always #1 clk = ~clk;

initial
begin
    clk = 0;
    count_flag <= 32'd0;
    is_issuable_fre_count <= 3'd0;
    issue_comand_count <= 2'd0;

    arg0_mem[0] = 8'h4C;        //L
    arg0_mem[1] = 8'h43;        //C
    arg0_mem[2] = 8'h4C;        //L
    arg0_mem[3] = 8'h43;        //C
    arg0_mem[4] = 8'h4C;        //L
    arg0_mem[5] = 8'h43;        //C
    arg0_mem[6] = 8'h4C;        //L
    arg0_mem[7] = 8'h43;        //C
    arg0_mem[8] = 8'h4C;        //L
    arg0_mem[9] = 8'h43;        //C
    
    arg1_mem[0] = 32'h00000000;     //L
    arg1_mem[1] = 32'h00000000;     //C
    arg1_mem[2] = 32'h00010000;     //L
    arg1_mem[3] = 32'h00010000;     //C
    arg1_mem[4] = 32'h00020000;     //L
    arg1_mem[5] = 32'h00020000;     //C
    arg1_mem[6] = 32'h00030000;     //L
    arg1_mem[7] = 32'h00030000;     //C
    arg1_mem[8] = 32'h00040000;     //L
    arg1_mem[9] = 32'h00040000;     //C

    arg2_mem[0] = 32'h00010000;           //L
    arg2_mem[1] = 32'h00010000;           //C
    arg2_mem[2] = 32'h00010000;           //L
    arg2_mem[3] = 32'h00010000;           //C
    arg2_mem[4] = 32'h00010000;           //L
    arg2_mem[5] = 32'h00010000;           //C
    arg2_mem[6] = 32'h00010000;           //L
    arg2_mem[7] = 32'h00010000;           //C
    arg2_mem[8] = 32'h00010000;           //L
    arg2_mem[9] = 32'h00010000;           //C

    arg3_mem[0] = 32'h00000001;           //L
    arg3_mem[1] = 32'h00010000;           //C
    arg3_mem[2] = 32'h00000001;           //L
    arg3_mem[3] = 32'h00010000;           //C
    arg3_mem[4] = 32'h00000001;           //L
    arg3_mem[5] = 32'h00010000;           //C
    arg3_mem[6] = 32'h00000001;           //L
    arg3_mem[7] = 32'h00010000;           //C
    arg3_mem[8] = 32'h00000001;           //L
    arg3_mem[9] = 32'h00010000;           //C

    arg4_mem[0] = 8'h58;             //Reserved parameter, No sense.
    arg4_mem[1] = 8'h58;             //X    slide mode for compute
    arg4_mem[2] = 8'h58;             //Reserved parameter, No sense.
    arg4_mem[3] = 8'h58;             //X    slide mode for compute
    arg4_mem[4] = 8'h58;             //Reserved parameter, No sense.
    arg4_mem[5] = 8'h58;             //X    slide mode for compute
    arg4_mem[6] = 8'h58;             //Reserved parameter, No sense.
    arg4_mem[7] = 8'h58;             //X    slide mode for compute
    arg4_mem[8] = 8'h58;             //Reserved parameter, No sense.
    arg4_mem[9] = 8'h59;             //Y    slide mode for compute
/*
    #10
    arg0_reg = 8'h63;
    arg1_reg = 32'd384;
    arg2_reg = 32'd191991292;
    arg3_reg = 32'd12331;
    arg4_reg = 8'h58;    //X
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
*/

    #10000000
    $finish;
end

vpi_test_nvmain vpi_test_nvmain(.clk(clk),
                                .command_enable(command_en),
                                .arg0(arg0_reg),
                                .arg1(arg1_reg),
                                .arg2(arg2_reg),
                                .arg3(arg3_reg),
                                .arg4(arg4_reg),
                                .is_issuable(is_issuable));

always @(posedge clk)
begin
    if(is_issuable)
        begin
            if(issue_comand_count == 2'b00)
              begin
                $display("[+] Issue command count_flag = %.2d", count_flag);
                arg0_reg <= arg0_mem[count_flag];
                arg1_reg <= arg1_mem[count_flag];
                arg2_reg <= arg2_mem[count_flag];
                arg3_reg <= arg3_mem[count_flag];
                arg4_reg <= arg4_mem[count_flag];    //X
                command_en <= 1;
                if(count_flag < 32'd9)
                    count_flag <= count_flag + 1'd1;
                else
                    count_flag <= 32'd0;
                
                issue_comand_count <= issue_comand_count + 1;  
              end
            
            else if(issue_comand_count == 2'b10)
              begin
                issue_comand_count <= 2'b00;
                command_en <= 0;
              end

            else
              begin
               issue_comand_count <= issue_comand_count + 1;  
               command_en <= 0;
              end     
        end
    else
        begin
            if(is_issuable_fre_count == 3'b000)
              begin
                arg0_reg <= 8'h69;
                arg1_reg <= arg1_mem[count_flag];
                arg2_reg <= arg2_mem[count_flag];
                arg3_reg <= arg3_mem[count_flag];
                arg4_reg <= arg4_mem[count_flag];   //X
                command_en <= 1;
                is_issuable_fre_count <= is_issuable_fre_count + 3'b001;
              end
            else
              begin
                is_issuable_fre_count <= is_issuable_fre_count + 3'b001;
                command_en <= 1'b0;
              end
        end
end

endmodule