`timescale 1ns / 1ps

module bit16Adder(
    output wire [15:0] sum,
	output wire c_out,
	input wire [15:0] a,
	input wire [15:0] b,
	input wire c_in
    );
    
     wire c1 ,c2 ,c3;
    bit4Adder u1(.a(a[3:0]), .b(b[3:0]), .c_in(c_in), .sum(sum[3:0]), .c_out(c1) );
    bit4Adder u2(.a(a[7:4]), .b(b[7:4]), .c_in(c1), .sum(sum[7:4]), .c_out(c2) );
    bit4Adder u3(.a(a[11:8]), .b(b[11:8]), .c_in(c2), .sum(sum[11:8]), .c_out(c3) );
    bit4Adder u4(.a(a[15:12]), .b(b[15:12]), .c_in(c3), .sum(sum[15:12]), .c_out(c_out) );
    
    
    
endmodule
