`timescale 1ns / 1ps

module CPU_Testbench;

reg clk;
reg rst;
reg [31:0] inputPort = 0;
wire [31:0] outputPort;

CPU MIPS_CPU(.clk(clk), .rst(rst), .inputPort(inputPort), .outputPort(outputPort));

initial clk = 0;
initial rst = 1;
always #40 clk =~clk; //period 80ns

initial begin
  #80;
  rst = 0;
  #40;
  inputPort = 82;
  #1000;
  inputPort = 50;
  #1000;
  $finish;

end


endmodule
