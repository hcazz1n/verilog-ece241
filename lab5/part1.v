module part1(SW, KEY, LEDR);
    input [1:0] SW;
    input [0:0] KEY;
    output [9:0] LEDR;

    assign w = SW[1];
    assign Clock = KEY[0];
    assign Resetn = SW[0];

    wire [0:8] Y, y_Q;  //next state values assigned to present state on each clock edge depending on the input, and then one hot present states (one FF/state)
    wire z;

    assign LEDR[8:0] = y_Q;
    assign LEDR[9] = z;    

    assign Y[1] = (y_Q[0] & ~w) | (y_Q[5] & ~w) | (y_Q[6] & ~w) | (y_Q[7] & ~w) | (y_Q[8] & ~w);
    assign Y[2] = y_Q[1] & ~w;
    assign Y[3] = y_Q[2] & ~w;
    assign Y[4] = (y_Q[3] & ~w) | (y_Q[4] & ~w);
    assign Y[5] = (y_Q[0] & w) | (y_Q[1] & w) | (y_Q[2] & w) | (y_Q[3] & w) | (y_Q[4] & w);
    assign Y[6] = y_Q[5] & w;
    assign Y[7] = y_Q[6] & w;
    assign Y[8] = (y_Q[7] & w) | (y_Q[8] & w);

    assign z = y_Q[4] | y_Q[8];

    FF_Sync_StateA S0(Y[0], Clock, Resetn, y_Q[0]);
    FF_Sync S1(Y[1], Clock, Resetn, y_Q[1]);
    FF_Sync S2(Y[2], Clock, Resetn, y_Q[2]);
    FF_Sync S3(Y[3], Clock, Resetn, y_Q[3]);
    FF_Sync S4(Y[4], Clock, Resetn, y_Q[4]);
    FF_Sync S5(Y[5], Clock, Resetn, y_Q[5]);
    FF_Sync S6(Y[6], Clock, Resetn, y_Q[6]);
    FF_Sync S7(Y[7], Clock, Resetn, y_Q[7]);
    FF_Sync S8(Y[8], Clock, Resetn, y_Q[8]);
endmodule

module FF_Sync_StateA(D, Clock, Resetn, Q); //special module for state A, which does not change based on the input Y[0]. As given in the state diagram, we are in A only right after a reset and then 0 forever until another reset.
    input D, Clock, Resetn;
    output reg Q;
    always @ (posedge Clock)
        if(!Resetn)
            Q <= 1'b1;
        else
            Q <= 1'b0;
endmodule

module FF_Sync(D, Clock, Resetn, Q);
    input D, Clock, Resetn;
    output reg Q;

    always @ (posedge Clock)
        if(!Resetn)
            Q <= 1'b0;
        else
            Q <= D;
endmodule
