module part5 (SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);
    input [7:0] SW;
    input [1:0] KEY;
    output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output [9:0] LEDR; 

    assign clock = KEY[1];
    assign Resetn = KEY[0];

    wire [7:0] Q, storedQ;
    async_R8 R(SW[7:0], clock, Resetn, Q, storedQ); //sets Q to D if we are assigning values (clock = 1, Resetn = 1) or Q to 0 if we are resetting values (clock = x, Resetn = 0)

    seg7 H3(SW[7:4], HEX3); //first 4bits A
    seg7 H2(SW[3:0], HEX2); //second 4bits A
    seg7 H1(SW[7:4], HEX1); //first 4bits B
    seg7 H0(SW[3:0], HEX0); //second 4bits B

    //8bit ripple-carry adder (add from LSB to MSB)
    wire [7:0] S, cout;
    FA F0(storedQ[0], Q[0], 0, S[0], cout[0]); //add A (stored) and B (active switches) and the Cin (starts at 0 -> will be the cout of the previous), to make a sum and the cout
    FA F1(storedQ[1], Q[1], cout[0], S[1], cout[1]);
    FA F2(storedQ[2], Q[2], cout[1], S[2], cout[2]);
    FA F3(storedQ[3], Q[3], cout[2], S[3], cout[3]);
    FA F4(storedQ[4], Q[4], cout[3], S[4], cout[4]);
    FA F5(storedQ[5], Q[5], cout[4], S[5], cout[5]);
    FA F6(storedQ[6], Q[6], cout[5], S[6], cout[6]);
    FA F7(storedQ[7], Q[7], cout[6], S[7], cout[7]);

    assign LEDR[0] = cout[7];

    seg7 H5();
    seg7 H4();

endmodule;

module async_R8(D, clock, Resetn, Q, storedQ); //asynchronous 8bit register (8bit flip flop). num holds A or B.
    input [7:0] D;
    input clock, Resetn;
    output reg [7:0] Q, storedQ;

    reg [7:0] old;

    always @ (negedge Resetn, posedge clock) //if Resetn -> 0 OR clock on a positive edge (clock -> 1). Since Resetn is in sensitivity list, it can directly influence the output, i.e. doesn't have to wait for posedge clock to be true before evaluating the statements in the always block.
    begin
        if(!Resetn)
            storedQ <= D
        else
            Q <= D;
    end
endmodule;

module seg7(SW, HEX);
    input [3:0] SW;
    output [6:0] HEX;

    assign [3:0] X = SW;

    //made k-map of zeros, so ~ whole term around to be active-low instead
    assign HEX[6] = ~((~X[3] & X[2] & ~X[1]) | (X[3] & ~X[2] & ~X[1]) | (X[3] & X[2] & X[0]) | (~X[2] & X[1] & X[0]) | (X[1] & ~X[0]));
    assign HEX[5] = ~((~X[1] & ~X[0]) | (X[3] & ~X[2]) | (X[3] & X[1]) | (~X[3] & X[2] & ~X[0]) | (~X[3] & X[2] & ~X[1]));
    assign HEX[4] = ~((~X[3] & ~X[2] & ~X[0]) | (X[3] & X[2]) | (X[3] & ~X[2] & ~X[0]) | (X[3] & ~X[2] & X[1]) | (X[1] & ~X[0]));
    assign HEX[3] = ~((~X[3] & ~X[2] & ~X[0]) | (X[3] & ~X[1]) | (X[2] & ~X[1] & X[0]) | (X[3] & ~X[2] & X[0]) | (X[2] & X[1] & ~X[0]) | (~X[3] & ~X[2] & X[1]));
    assign HEX[2] = ~((~X[3] & ~X[1] & ~X[0]) | (X[3] & ~X[2]) | (~X[1] & X[0]) | (~X[3] & X[2]) | (~X[3] & X[1] & X[0]));
    assign HEX[1] = ~((~X[3] & ~X[1] & ~X[0]) | (X[3] & ~X[2] & ~X[0]) | (X[3] & ~X[1] & X[0]) | (~X[3] & X[1] & X[0]) | (~X[3] & ~X[2]));
    assign HEX[0] = ~((~X[2] & ~X[1] & ~X[0]) | (X[3] & X[2] & ~X[0]) | (X[3] & ~X[2] & ~X[1] & X[0]) | (X[3] & X[1] & ~X[0]) | (X[3] & X[2] & X[1]) | (~X[3] & X[1]) | (~X[3] & X[2] & X[0]));
endmodule;

module FA (a, b, Cin, S, Cout);
    input a, b, Cin;
    output S, Cout;

    assign S = (a ^ b) ^ Cin;
    assign Cout = (a & b) | (b & Cin) | (a & Cin);
endmodule
