`timescale 1ns / 1ps


module Full_Adder(
    
    output wire sum,
    output wire c_out,
    input wire a, 
    input wire b,
    input wire c_in
);

wire s1, c1, c2;

Half_Adder u1(.sum(s1), .c_out(c1), .a(a), .b(b) );
Half_Adder u2(.sum(sum), .c_out(c2), .a(s1), .b(c_in));
or (c_out, c2, c1);

endmodule

