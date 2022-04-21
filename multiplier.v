module multiplier(input [31:0] multiplier, input [31:0] multiplicand, output reg [63:0] product);
reg [31:0] a, b;
/*
the multiplier module works by shifting the multiplicand by 1 each iteration of a loop that runs 32 times and adds the multiplicand to the product every time a certain bit of the multiplier is equal to 1. The multiplier is iterated from the LSB to the MSB.
*/
	integer i; //counter variable

	always @*
	begin 
		product = 0;
		a = multiplier;
		b = multiplicand;
		for(i = 0; i < 32; i = i + 1)
		begin 
			if(a[0] == 1)
				begin
					product = product + b; //only if bit=1 
					b = b << 1; 
					a = a >> 1;
				end
			else
				//shifts multiplicand by 1 each iteration
				begin
					b = b << 1; 
					a = a >> 1;
				end
		end
	end
endmodule
