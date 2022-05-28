`timescale 1ns / 1ps

module InstructionMemory(input wire [31:0] pc, output wire [31:0] instruction
    );
    
    reg [31:0] InstructionMem [0:1023];
    integer i =0;
    
    initial begin
    
        for(i=3; i<65535; i= i +1) begin
            /*
            InstructionMem[0] = 32'h214A0005;  //001000 (op)- 01010 (Rs)- 01010 (Rt)- 0000000000000101 //  addi R10, R10, 5    set $t2 == 5
            InstructionMem[1] = 32'h21290001; // increment $t1
            InstructionMem[2] = 32'h112A0001; // branch ahead by 1,  if $t1 == $t2
            InstructionMem[3] = 32'h08000001; // jump back to PC 1
            InstructionMem[4] = 32'h216B0064; // set $t3 == 100 to indicate we are done
            InstructionMem[5] = 32'hAC0B03FF; // store value of $t3 in mem location 1023  
            InstructionMem[6] = 32'h8C0903FE; // load value from mem location 1022 and store it in t1  
            
            */
            
            /* Initializing instruction memory*/
            
            InstructionMem[0] = {6'b100011, 5'b00000, 5'b00001, 16'b1111111110}; // lw R1, 1022(R0)
            
            InstructionMem[1] = {6'b101011, 5'b00000, 5'b00001, 16'b1111111111}; // sw R1, 1023(R0)
            
            InstructionMem[2] = {6'b000010, 26'b00000000000000000000000000}; // jump back to PC 0
            
            InstructionMem[i] = 32'hFFFFFFFF; // initialize instruction memory to NOP
        end
    end 
  
    
    assign instruction[31:0] = InstructionMem[pc];
    
  
endmodule
