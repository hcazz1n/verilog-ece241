module part4(SW, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input[8:0] SW;
    output[9:0] LEDR;
    output[6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    assign HEX4 = 7'b1111111;
    assign HEX2 = 7'b1111111;

    wire [3:0] X, Y, cout, A, B, M, H, zFix;
    wire cin, z, checkX, checkY;
    wire [3:0] result;

    assign X = SW[7:4];
    assign Y = SW[3:0];
    assign cin = SW[8];

    assign checkX = X[3] & (X[2] | X[1]);
    assign checkY = Y[3] & (Y[2] | Y[1]);

    assign LEDR[9] = checkX | checkY;

    seg7 H5 (X, HEX5);
    seg7 H3 (Y, HEX3);

    fullAdder f0(X[0], Y[0], cin, result[0], cout[0]);
    fullAdder f1(X[1], Y[1], cout[0], result[1], cout[1]);
    fullAdder f2(X[2], Y[2], cout[1], result[2], cout[2]);
    fullAdder f3(X[3], Y[3], cout[2], result[3], cout[3]);

    assign z = (result[3]&(result[2] | result[1]));

    assign A[3] = 0;
    assign A[2] = result[2] & result[1];
    assign A[1] = ~result[1];
    assign A[0] = result[2] & result[0];

    mux U1 (result, A, z, M);

    assign zFix[0] = z;
    assign zFix[1] = 0;
    assign zFix[2] = 0;
    assign zFix[3] = 0;

    assign B[3] = ~M[1];
    assign B[2] = M[1];
    assign B[1] = M[1];
    assign B[0] = ~M[2] & ~M[0];

    mux U2(M, B, result[3], H);

    seg7 H1 (zFix, HEX1);
    seg7 H0 (H, HEX0);

    assign LEDR[4:0] = result;
endmodule

module fullAdder (A, B, Cin, S, Cout);
    input[3:0] A,B;
    input Cin;
    output[3:0] S;
    output Cout;

    wire C1, C2, C3;
    FA U1 (A[0], B[0], Cin, S[0], C1);
    FA U2 (A[1], B[1], C1, S[1], C2);
    FA U3 (A[2], B[2], C2, S[2], C3);
    FA U4 (A[3], B[3], C3, S[3], Cout);
endmodule

module FA (a, b, Cin, S, Cout);
    input a, b, Cin;
    output S, Cout;

    assign S = a ^ b ^ Cin;
    assign Cout = (a & b) | (b & Cin) | (a & Cin);
endmodule

module mux (result, A, z, M);
    input [3:0] result, A;
    input z;
    output [3:0] M;

    assign M[0] = (~z & result[0]) | (z & A[0]);
    assign M[1] = (~z & result[1]) | (z & A[1]);
    assign M[2] = (~z & result[2]) | (z & A[2]);
    assign M[3] = (~z & result[3]) | (z & A[3]);
 
endmodule

module seg7 (SW, HEX);
    input [3:0] SW;
    output [6:0] HEX;

    assign HEX[0] = ~SW[1] & ((~SW[3] & ~SW[2] & SW[0]) | (SW[2] & ~SW[0]));
    assign HEX[1] = SW[2] & ((~SW[1] & SW[0]) | (SW[1] & ~SW[0]));
    assign HEX[2] = ~SW[2] & SW[1] & ~SW[0];
    assign HEX[3] = (SW[2] & ~SW[1] & ~SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & SW[0]);
    assign HEX[4] = SW[0] | (~SW[1] & SW[2]);
    assign HEX[5] = (SW[1] & SW[0]) | (~SW[3] & ~SW[2] & SW[0]) | (~SW[3] & ~SW[2] & SW[1]);
    assign HEX[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (SW[2] & SW[1] & SW[0]);

endmodule
