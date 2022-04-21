`timescale 1ns / 1ps


module ProgramCounter(input wire clk, input wire rst, input wire [31:0] nextPC,
                      output reg [31:0] currentPC
    );
    
    always@(posedge clk) begin
       if(rst == 1) begin 
            currentPC <= 0;
        end
        else begin
            currentPC <= nextPC;
        end
    end
   
endmodule
