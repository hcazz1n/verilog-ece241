module lab1part3(SW, LEDR);
	input [9:0] SW;
	output [0:1] LEDR;
	
	wire [0:1] S0, S1, U, V, W;
	wire [0:1] T, M;
	
	assign S = SW[9:8];
	assign U = SW[5:4];
	assign V = SW[3:2];
	assign W = SW[1:0];
	
	assign T[0] = (~S0[0] & U[0]) | (~S0[0] & V[0]);
	assign T[1] = (~S0[1] & U[1]) | (~S0[1] & V[1]);
	
	assign M[0] = (~S1[0] & T[0]) | (S1[0] & W[0]);
	assign M[1] = (~S1[1] & T[1]) | (S1[1] & W[1]);
	
	assign LEDR = M;
endmodule