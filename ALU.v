`timescale 1ns / 1ps


module ALU(
    input [31:0] a, 
    input [31:0] b, 
    input [2:0] ALU_Control,
    output reg [31:0] result,
    output zero
    );
    
    wire addOverflow;
    reg [31:0] mulOverflow;
    wire [31:0] rem;
    
    initial mulOverflow = 32'd0;
   /*wires for the adder module  */ 
    wire [31:0] a1, a2, a3;
    assign a1 = a;
    assign a2 = b;
   
   /*registers for the multiplier module module  */ 
    reg [31:0] m1, m2;
    wire [63:0] m3;
    reg invert;
    
    /*wire for the multiplier module module  */
    wire [31:0] d1, d2, d3;
    assign d1 = a;
    assign d2 = b;
    
     bit32Adder add (.a(a1), .b(a2), .c_in(0), .sum(a3), .c_out(addOverflow) );
     
     multiplier multiply(.multiplier(m1), . multiplicand(m2), .product(m3));
     
     divider divide(.Q(d1), .M(d2), .Quo(d3), .Rem(rem));
        

 always @(*)
    begin
    invert = 0;
    m1 = a;
    m2 = b;
    
    if(m1[31] == 1)
    begin 
        m1 = ~m1 +1;
       invert = 1;     
    end
    
    if(m2[31] == 1)
    begin 
        m2 = ~m2 +1;
       invert = 1;     
    end
    
    if(m1[31] == 1 && m2[31] == 1)
    begin 
        m1 = ~m1 +1;
        m2 = ~m2 +1;
       invert = 0;     
    end    
    
        case(ALU_Control)
        3'b000 : result = a & b; //(0) AND
        3'b001 : result = a | b; //(1) OR
        3'b010 : result = a3; //result = a + b;  //(2)signed Addition with overflow
        3'b110 : result = a - b; //(6)sigend Subtraction with overflow
        3'b011 : begin //(3) sigend multiplication with overflow
         if(invert == 0)
            result = m3[31:0];
         else
            result = ~(m3[31:0]) +1;
         end
        3'b100 : result = d3;   //result = a / b; (4) sigend division with overflow
        3'b101 : result = b << a; //(5)shift left by b
        3'b111 : begin if (a<b) result = 32'd1; //(7) set if less than (SLT)
                        else result = 32'd0;
                 end 
        default: result = 32'b0;
        endcase
    end
    
    assign zero = (result==32'd0) ? 1'b1: 1'b0; //zero output

endmodule
