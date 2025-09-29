module part4(SW, LEDR, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input[8:0] SW;
    output[9:0] LEDR;
    output[6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    wire [3:0] X, Y, cout, A, B, M, H, zFix;
    wire cin, z, compX, compY;
    wire [4:0] result;

    assign X = SW[7:4];
    assign Y = SW[3:0];
    assign cin = SW[8];

    assign compX = X[3] & (X[2] | X[1]);
    assign compY = Y[3] & (Y[2] | Y[1]);

    assing LEDR[9] = compX | compY;

    seg7 H5(X, HEX5);
    seg7 H3(Y, HEX3):

    FA F0(X[0], Y[0], cin, cout[0], result[0]);
    FA F1(X[1], Y[1], cout[0], cout[1], result[1]);
    FA F2(X[2], Y[2], cout[1], cout[2], result[2]);
    FA F3(X[3], Y[3], cout[2], cout[3], result[3]);

endmodule;

module FA (a, b, Cin, S, Cout);
    input a, b, Cin;
    output S, Cout;

    assign S = a ^ b ^ Cin;
    assign Cout = (a & b) | (b & Cin) | (a & Cin);
endmodule