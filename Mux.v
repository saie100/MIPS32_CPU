`timescale 1ns / 1ps

module Mux #(parameter N = 32)( input wire [(N-1):0] a, input wire [(N-1):0] b, input wire sel, output reg [(N-1):0] y
    );
    
    always @* begin
    if(sel == 1)
     y = a;
    else
    y = b;
    
    end
endmodule
