`timescale 1ns / 1ps

module DataMemory(input wire clk, input wire [31:0] addr, input wire [31:0] dataW, 
                    input wire enaR, input wire enaW,
                    output reg [31:0] data_out,
                    output reg [7:0] outPort,
                    input wire [7:0] inPort
                    );
    
    localparam OUTPORTADDR = 1023;
    localparam INPORTADDR = 1022;
    
    reg [31:0] dataMem [0:1023];
    integer i;
    
    initial begin      
        for(i = 0; i<1024; i = i +1) begin
            dataMem[i] = 32'd0;  //initialize dataMemory to zero
        end          
    end
    
    
    always@(posedge clk) begin 
        // writes to data memory location
        dataMem[INPORTADDR] <= {24'd0, inPort[7:0]};      
        if(enaW == 1) begin
            dataMem[addr] <= dataW;
        end
    end
    
    always @(negedge clk) begin 
        // read from data memory location
        outPort <= dataMem[OUTPORTADDR][7:0];
        if(enaR == 1) begin
            data_out <= dataMem[addr];
        end
    end
    
    
    
endmodule
