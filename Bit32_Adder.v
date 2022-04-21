`timescale 1ns / 1ps

/*  This 32bit adder works like a ripple effect,
Passing the previous c_out bit to the next c_in bit   */

module Bit32_Adder(
    output wire [9:0]sum,
    output wire c_out,
    input wire [9:0] a,
    input wire [9:0] b,
    input wire c_in
    );
    
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11;
    
    Full_Adder u1(.a(a[0]), .b(b[0]), .c_in(0), .sum(sum[0]), .c_out(c1) );
    Full_Adder u2(.a(a[1]), .b(b[1]), .c_in(c1), .sum(sum[1]), .c_out(c2) );
    Full_Adder u3(.a(a[2]), .b(b[2]), .c_in(c2), .sum(sum[2]), .c_out(c3) );
    Full_Adder u4(.a(a[3]), .b(b[3]), .c_in(c3), .sum(sum[3]), .c_out(c4) );
    Full_Adder u5(.a(a[4]), .b(b[4]), .c_in(c4), .sum(sum[4]), .c_out(c5) );
    Full_Adder u6(.a(a[5]), .b(b[5]), .c_in(c5), .sum(sum[5]), .c_out(c6) );
    Full_Adder u7(.a(a[6]), .b(b[6]), .c_in(c6), .sum(sum[6]), .c_out(c7) );
    Full_Adder u8(.a(a[7]), .b(b[7]), .c_in(c7), .sum(sum[7]), .c_out(c8) );
    Full_Adder u9(.a(a[8]), .b(b[8]), .c_in(c8), .sum(sum[8]), .c_out(c9) );
    
    Full_Adder u10(.a(a[9]), .b(b[9]), .c_in(c9), .sum(sum[9]), .c_out(c_out) );
endmodule
