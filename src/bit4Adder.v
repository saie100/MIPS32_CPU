`timescale 1ns / 1ps

module bit4Adder(
    output wire [3:0] sum,
	output wire c_out,
	input wire [3:0] a,
	input wire [3:0] b,
	input wire c_in
    );
    
    
     wire c1 ,c2 ,c3;

    Full_Adder u1(.a(a[0]), .b(b[0]), .c_in(c_in), .sum(sum[0]), .c_out(c1) );
    Full_Adder u2(.a(a[1]), .b(b[1]), .c_in(c1), .sum(sum[1]), .c_out(c2) );
    Full_Adder u3(.a(a[2]), .b(b[2]), .c_in(c2), .sum(sum[2]), .c_out(c3) );
    Full_Adder u4(.a(a[3]), .b(b[3]), .c_in(c3), .sum(sum[3]), .c_out(c_out) );
    
    
    
endmodule
