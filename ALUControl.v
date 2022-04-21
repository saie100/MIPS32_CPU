`timescale 1ns / 1ps

module ALUControl( input wire [5:0] func, input wire [1:0] ALUop, output reg [2:0] ALU_Control);


always @(*) begin

    if(ALUop[1:0] == 2'b00)
        ALU_Control = 3'b010; //load and store operation (signed add)
    else if (ALUop[1:0] == 2'b01)
        ALU_Control = 3'b110; //beq operation (signed sub)
    else if (ALUop[1:0] == 2'b10) begin
        case(func[5:0])
        //This matches the MIPS standard given ALUop and func signals 
        6'b100000 : ALU_Control = 3'b010; //R-type add with overflow (signed add)
        6'b100010 : ALU_Control = 3'b110; //R-Type subtract (signed sub) 
        6'b100100 : ALU_Control = 3'b000; //R-Type AND
        6'b100101 : ALU_Control = 3'b001; //R-Type OR
        6'b101010 : ALU_Control = 3'b111; //R-Type set on less than (signed SLT)     
        //The standard ALU_Control signal for multiply and divide is unknown
        //So I used random signals that were not used from the previous code above
        
        6'b011000 : ALU_Control = 3'b011; //R-Type Multiply   (sigend mult)
        6'b011010 : ALU_Control = 3'b100; //R-Type divide   (sigend div)
        6'b000000 : ALU_Control = 3'b101; //R-Type shift left
        
        default : ALU_Control = 3'b000; //By default we do an and operation 
        endcase
     end

  end
endmodule
