`timescale 1ns / 1ps


module bit32Adder(
    output wire [31:0] sum,
	output wire c_out,
	input wire [31:0] a,
	input wire [31:0] b,
	input wire c_in
    );
    
    wire c1;
    
    bit16Adder u1(.a(a[15:0]), .b(b[15:0]), .c_in(c_in), .sum(sum[15:0]), .c_out(c1) );
    bit16Adder u2(.a(a[31:16]), .b(b[31:16]), .c_in(c1), .sum(sum[31:16]), .c_out(c_out) );
   
    
endmodule
