`timescale 1ns / 1ps

module SignExtend #(parameter N = 16)(input [(N-1):0] origNum, output wire [31:0] extendedNum );
    
    

    if(N == 16)    
    assign extendedNum[31:N] = 16'hFFFF * origNum[N-1];      
    else
    assign extendedNum[31:N] = 6'b111111 * origNum[N-1];
    
    assign extendedNum[(N-1):0] = origNum[(N-1):0];
    
    /*
	always @* begin
	
	if (origNum[15] == 1)
		extendedNum[31:16] = 16'hFFFF;
	else
	   extendedNum[31:16] = 16'h0000;
	
	
	extendedNum[15:0] = origNum[15:0];
	end
*/
endmodule
