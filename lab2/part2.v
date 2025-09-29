module part2 (SW, HEX1, HEX0);
    input [3:0] SW;
    output [6:0] HEX1, HEX0;

    wire [3:0]V;
    assign V = SW[3:0];
    
    wire z;
    assign z = (V[3] & (V[2] | V[1]));

    wire [3:0]A;

    assign A[3] = 0;
    assign A[2] = (V[3] & V[2] & V[1] & ~V[0]) | (V[3] & V[2] & V[1] & V[0]);
    assign A[1] = (V[3] & V[2] & ~V[1] & ~V[0]) | (V[3] & V[2] & ~V[1] & V[0]);
    assign A[0] = (V[3] & ~V[2] & V[1] & V[0]) | (V[3] & V[2] & ~V[1] & V[0]) | (V[3] & V[2] & V[1] & V[0]);

    assign HEX1[0] = z;
    assign HEX1[1] = 0;
    assign HEX1[2] = 0;
    assign HEX1[3] = z;
    assign HEX1[4] = z;
    assign HEX1[5] = z;
    assign HEX1[6] = 1;

    wire [3:0]M;
    assign M[3] = (~z & V[3]) | (z & A[3]);
    assign M[2] = (~z & V[2]) | (z & A[2]);
    assign M[1] = (~z & V[1]) | (z & A[1]);
    assign M[0] = (~z & V[0]) | (z & A[0]);

    assign HEX0[0] = ~M[1] & ((~M[3] & ~M[2] & M[0]) | (M[2] & ~M[0]));
    assign HEX0[1] = M[2] & ((~M[1] & M[0]) | (M[1] & ~M[0]));
    assign HEX0[2] = ~M[2] & M[1] & ~M[0];
    assign HEX0[3] = (M[2] & ~M[1] & ~M[0]) | (~M[2] & ~M[1] & M[0]) | (M[2] & M[1] & M[0]);
    assign HEX0[4] = M[0] | (~M[1] & M[2]);
    assign HEX0[5] = (M[1] & M[0]) | (~M[3] & ~M[2] & M[0]) | (~M[3] & ~M[2] & M[1]);
    assign HEX0[6] = (~M[3] & ~M[2] & ~M[1]) | (M[2] & M[1] & M[0]);

endmodule