module part4(SW, LEDR, HEX0);
	input [1:0] SW; // toggle switches
	output [9:0] LEDR; // red LEDs
	output [6:0] HEX0; // 7-seg display
	
	assign c1 = SW[1];
	assign c0 = SW[0];
	
	assign HEX0[0] = (~c1 & ~c0) | (c1 & ~c0) | (c1 & c0);
	assign HEX0[1] = (~c1 & c0) | (c1 & c0);
	assign HEX0[2] = HEX0[1];
	assign HEX0[3] = (c1 & ~c0) | (c1 & c0);
	assign HEX0[4] = HEX0[3];
	assign HEX0[5] = (~c1 & ~c0) | (c1 & ~c0) | (c1 & c0);
	assign HEX0[6] = HEX0[3];
endmodule
	