`timescale 1ns / 1ps

module ControlModule(input wire clk, input wire [5:0] Opcode, output reg RegDst, output reg Jump, output reg Branch, 
                    output reg MemRead, output reg MemToReg, output reg [1:0] ALUOp, output reg MemWrite, 
                    output reg ALUSrc, output reg RegWrite
    );
    
    
    always @(*) begin
    
    case(Opcode[5:0])
    
    6'b000000 : begin //R-Type instruction
    RegWrite = 1;
    RegDst = 1;
    ALUSrc = 0;
    MemToReg = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b10;
    end
    
    
    6'b100011 : begin //load word lw
    RegWrite = 1;
    RegDst = 0;
    ALUSrc = 1;
    MemToReg = 1;
    MemRead = 1;
    MemWrite = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b00; 
    end
    
    6'b101011 : begin //store word sw
    RegWrite = 0;
    RegDst = 0;
    ALUSrc = 1;
    MemToReg = 0;
    MemRead = 0;
    MemWrite = 1;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b00; 
    end
    
    6'b000100 : begin //Beq (Branch) instruction
    RegDst = 0;
    ALUSrc = 0;
    MemToReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 1;
    Jump = 0;
    ALUOp = 2'b01;
    end
    
    6'b001000 : begin //ADDI (add immediate) instruction
    RegDst = 0;
    ALUSrc = 1;
    MemToReg = 0;
    RegWrite = 1;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b00;
    end
    
    6'b000010 : begin //Jump J type - instruction 
    RegDst = 0;
    ALUSrc = 0;
    MemToReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    Jump = 1;
    ALUOp = 2'b00;
    end
    
    
    default : begin //deafult case 
    RegDst = 0;
    ALUSrc = 0;
    MemToReg = 0;
    RegWrite = 0;
    MemRead = 0;
    MemWrite = 0;
    Branch = 0;
    Jump = 0;
    ALUOp = 2'b00;
    end
    
    endcase
    end
endmodule
