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
`define X 0x58
`define Y 0x59
`define i 0x69

module vpi_test_nvmain(input          clk,
                       input          command_enable,
                       input [7:0]    arg0,
                       input [31:0]   arg1,
                       input [31:0]   arg2,
                       input [31:0]   arg3,
                       input [7:0]    arg4,
                       output         is_issuable);
  reg command_en;
  reg [7:0]   arg0_reg;
  reg [31:0]  arg1_reg;
  reg [31:0]  arg2_reg;
  reg [31:0]  arg3_reg;
  reg [7:0]   arg4_reg;

  reg[7:0] is_issuable_flag;

  assign is_issuable = (is_issuable_flag > 0) ? 1 : 0;

  initial
  begin
    is_issuable_flag = 8'd0;
    $rvsim_set_config;
    $rvsim_set_parameters;
  end

  always @(posedge clk)
  begin
    command_en <= command_enable; //one command one cycle
    arg0_reg   <= arg0;
    arg1_reg   <= arg1;
    arg2_reg   <= arg2;
    arg3_reg   <= arg3;
    arg4_reg   <= arg4;
  end

  always @(posedge clk)
  begin
    $rvsim_cycle();
  end

  always @(posedge clk)
  begin
    if(command_en)
    begin
      $display("[+](Verilog test_nvmain) Get Command: [ 0x%.2h, 0x%.8h, 0x%.8h, 0x%.8h, 0x%.2h ]", arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      
      if(arg0_reg == 8'h69)
        $rvsim_is_issuable();
      
      // if(arg0_reg == 8'h6C)
      //   $rvsim_is_issuable();
      //   //$rvsim_is_issuable(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);

      // else if(arg0_reg == 8'h77)
      //   $rvsim_is_issuable();
      //   //$rvsim_is_issuable(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      
      // else if(arg0_reg == 8'h72)
      //   $rvsim_is_issuable();
      //   //$rvsim_is_issuable(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      
      // else if(arg0_reg == 8'h63)
      //   $rvsim_is_issuable();
      //   //$rvsim_is_issuable(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);

      else if(arg0_reg == 8'h4C)
      begin
        is_issuable_flag <= 0;
        $rvsim_issue_command(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      end

      else if(arg0_reg == 8'h57)
      begin
        is_issuable_flag <= 0;
        $rvsim_issue_command(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      end

      else if(arg0_reg == 8'h52)
      begin
        is_issuable_flag <= 0;
        $rvsim_issue_command(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      end

      else if(arg0_reg == 8'h43)
      begin
        is_issuable_flag <= 0;
        $rvsim_issue_command(arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
      end
      
      else
      begin
        $display("[-] Error command![ %.2h, %.8h, %.8h, %.8h, %.2h ]\n", arg0_reg, arg1_reg, arg2_reg, arg3_reg, arg4_reg);
        $finish();
      end
    end
  end

endmodule