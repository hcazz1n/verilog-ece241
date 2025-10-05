module part3(SW, LEDR);
    input [1:0] SW;
    output [9:0] LEDR;
    wire Clock, D; 
    wire Qm, notQm, Q, notQ;

    assign Clock = SW[1];
    assign D = SW[0];

    D_latch master(~Clock, D, Qm, notQm); //for a positive-edge triggered D flip-flop, the master receives ~Clock and the slave receives Clock (Qm = D for Clk = 0, Qs = D for Clk = 1).
    D_latch slave(Clock, Qm, Q, notQ);

    assign LEDR[0] = Q;
endmodule;

module D_latch(Clk, D, Qa, Qb);
    input Clk, D;
    output Qa, Qb;
    wire S_g, R_g;

    assign S_g = ~(D & Clk);
    assign R_g = ~(~D & Clk);
    assign Qa = ~(S_g & Qb);
    assign Qb = ~(R_g & Qa);
endmodule;

