module part5 (SW, LEDR, HEX2, HEX1, HEX0);
	input [9:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX2, HEX1, HEX0;
	assign LEDR = SW;

	wire [1:0] S, U, V, W, M
	wire H0, H1, H2;
	
	assign S = SW[9:8];
	assign U = SW[5:4];
	assign V = SW[3:2];
	assign W = SW[1:0];
	
	assign LEDR = SW;
	
	mux M0 (S, U, V, W, H0);
	mux M1 (S, V, W, U, H1);
	mux M2 (S, W, U, V, H2);

	seg7 seg7_0 (H0, HEX0);
	seg7 seg7_1 (H1, HEX1);
	seg7 seg7_2 (H2, HEX2);
endmodule

module mux(S, U, V, W, M);
	output [1:0] M;
	input [1:0] S, U, V, W;
	
	assign M[0] = (~S[1] & ((~S[0] & U[0]) | (S[0] & V[0]))) | (S[1] & W[0]);
	assign M[1] = (~S[1] & ((~S[0] & U[1]) | (S[0]&V[1]) )) | (S[1]&W[1]);
endmodule

module seg7(X, HEX);
	input [1:0] X;
	output [6:0] HEX;
		
	assign HEX[0] = ~(X[0] & ~X[1]);
	assign HEX[1] = X[0];
	assign HEX[2] = HEX[1];
	assign HEX[3] = X[1];
	assign HEX[4] = HEX[3];
	assign HEX[5] = HEX[0];
	assign HEX[6] = HEX[3];
endmodule;