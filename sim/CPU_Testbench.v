`timescale 1ns / 1ps

module CPU_Testbench;

reg clk;
reg rst;
reg [7:0] inputPort = 0;
wire [7:0] outputPort;

CPU MIPS_CPU(.clk(clk), .rst(rst), .inputPort(inputPort), .outputPort(outputPort));

initial clk = 0;
initial rst = 1;
always #40 clk =~clk; //period 80ns

initial begin
  #80;
  rst = 0;
  #40;
  inputPort = 8'b00000001;
  #1000;
  inputPort = 8'b00000010;
  #1000;
  inputPort = 8'b00000100;
  #1000;
  inputPort = 8'b00001000;
  #1000;
  inputPort = 8'b00010000;
  #1000;
  inputPort = 8'b00100000;
  #1000;
  inputPort = 8'b01000000;
  #1000;
  inputPort = 8'b10000000;
  #1000;
  $finish;

end


endmodule
