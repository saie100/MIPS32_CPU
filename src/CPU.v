`timescale 1ns / 1ps

module CPU(input wire clk, input wire rst, input wire [7:0] inputPort, output wire [7:0] outputPort);

//Program Counter signals
wire [31:0] currentPC;
wire [31:0] incrementedPC;
wire [31:0] nextPC;

//Instruction Mem Signals
wire [31:0] instr;
wire [4:0] DstReg;
wire [31:0] d1, d2;


wire [31:0] MuxWriteBack;
wire [31:0] M32_1_output;
wire zero;
wire [2:0] ALU_Control;
wire [31:0] result;
wire [31:0] BranchMuxOutput;
wire BranchSel;
wire [31:0] jumpAddr32_bits;
wire [31:0] jumpLocation;
wire [31:0]branchAddr;
wire [31:0] branchLocation;

//Control Module signals
wire RegDst;
wire ALUSrc;
wire MemToReg;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire Jump;
wire [1:0] ALUOp;
wire [31:0] DataMemOut;


ProgramCounter PC(.clk(clk), .rst(rst), .nextPC(nextPC), .currentPC(currentPC));

InstructionMemory IM(.pc(currentPC), .instruction(instr[31:0]));

ControlModule CM(.clk(clk), .Opcode(instr[31:26]), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite),
                    .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .Jump(Jump), .ALUOp(ALUOp) );   

ALU adder1(.a(currentPC[31:0]), .b(32'd1), .result(incrementedPC[31:0]), .ALU_Control(3'b010), .zero());

and AND_GATE(BranchSel, Branch, zero);
ALU adder3(.a(incrementedPC[31:0]), .b(branchAddr[31:0]), .result(branchLocation[31:0]), .ALU_Control(3'b010), .zero());
Mux #(.N(32)) BranchMux(.a(branchLocation[31:0]), .b(incrementedPC[31:0]), .sel(BranchSel), .y(BranchMuxOutput));

assign jumpLocation[25:0] = instr[25:0];
assign jumpLocation[31:26] = incrementedPC[31:26];

Mux #(.N(32)) JumpMux(.a(jumpLocation[31:0]), .b(BranchMuxOutput), .sel(Jump), .y(nextPC));

Mux #(.N(5)) M5(.a(instr[15:11]), .b(instr[20:16]), .sel(RegDst),  .y(DstReg));

Registers registerFile(.clk(clk), .R1(instr[25:21]), .R2(instr[20:16]), .DstR(DstReg), .dataW(MuxWriteBack), .enaW(RegWrite), .d_out1(d1), .d_out2(d2));

Mux #(.N(32)) M32_1(.a(branchAddr[31:0]), .b(d2), .sel(ALUSrc), .y(M32_1_output));

ALU ALU(.a(d1), .b(M32_1_output), .ALU_Control(ALU_Control), .result(result), .zero(zero) );

ALUControl ALUCon(.func(instr[5:0]), .ALUop(ALUOp), .ALU_Control(ALU_Control));

DataMemory DM(.clk(clk), .addr(result), .dataW(d2), .enaR(MemRead), .enaW(MemWrite), .data_out(DataMemOut), .outPort(outputPort), .inPort(inputPort) );

Mux #(.N(32)) M32_2(.a(DataMemOut), .b(result), .sel(MemToReg), .y(MuxWriteBack));

SignExtend #(.N(16)) SignExtend2(.origNum(instr[15:0]), .extendedNum(branchAddr[31:0]) );
endmodule
