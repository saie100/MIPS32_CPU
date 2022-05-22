`timescale 1ns / 1ps

module DataMemory(input wire clk, input wire [31:0] addr, input wire [31:0] dataW, 
                    input wire enaR, input wire enaW,
                    output reg [31:0] data_out,
                    output reg [7:0] outPort,
                    input wire [7:0] inPort
                    );
    
    reg [31:0] dataMem [0:1023];
    integer i =0;
    
    localparam OUTPORTADDR = 1023;
    localparam INPORTADDR = 1022;
    
    
  
    initial begin      
        for(i =0; i<1024; i = i +1) begin
            dataMem[i] = 32'd0;  //initialize dataMemory to zero
        end          
    end
    
    
    always@(posedge clk) begin    
        // writes to data memory location
        if(enaW == 1) begin
            dataMem[addr] <= dataW;
            dataMem[INPORTADDR] <= inPort;
        end
        // read from data memory location
        else if(enaR == 1) begin
            data_out <= dataMem[addr];
            outPort <= dataMem[OUTPORTADDR];
        end
        
        
       
        else if(enaW == 0 && enaR == 0) begin
            dataMem[INPORTADDR] <= inPort;
        end
        
    end
   
    /*always@(*) begin  
        if(enaR == 1) begin
            data_out = dataMem[addr];
            outPort = dataMem[OUTPORTADDR];
        end
    
        else if(enaR == 0 && enaW == 0) begin
            outPort = dataMem[OUTPORTADDR]; 
        end
    
    end
    
    */
    
    
endmodule
