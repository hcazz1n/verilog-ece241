module part3 (SW, LEDR, Cin, S, Cout);
    input[5:0] SW; //5:3 A, 2:0 B
    input[9:0] LEDR;
    input Cin;
    output[2:0] S;
    output Cout;

    wire [2:0] A;
    wire [2:0] B;

    assign A = SW[5:3];
    assign B = SW[2:0];

    wire C1, C2;
    FA U1 (A[0], B[0], Cin, S[0], C1);
    FA U2 (A[1], B[1], C1, S[1], C2);
    FA U3 (A[2], B[2], C2, S[2], Cout);
endmodule;

module FA (a, b, Cin, S, Cout);
    input a, b, Cin;
    output S, Cout;

    assign S = a ^ b ^ Cin;
    assign Cout = (a & b) | (b & Cin) | (a & Cin);
endmodule