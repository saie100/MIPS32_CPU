`timescale 1ns / 1ps

module Registers(input wire clk, input wire [4:0] R1, input wire [4:0] R2, input wire [4:0] DstR, input wire enaW, input wire [31:0] dataW, 
                output wire [31:0] d_out1, output wire [31:0] d_out2);
    
    reg [31:0] regFile [0:31];
    integer i = 0;
    
    initial begin
    //Zero register is always zero. Do NOT overwrite zero register
    
        for(i=0; i<32; i=i+1) begin
            regFile[i] = 32'd0; //initialize registers to zero
        end
    end

    always@(posedge clk ) begin
    if(enaW == 1) 
     regFile[DstR] <= dataW;
    end 
      
     assign d_out1 = regFile[R1];
     assign d_out2 = regFile[R2];
    
endmodule
