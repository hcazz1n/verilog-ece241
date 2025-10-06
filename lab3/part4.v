module part4(Clk, D, Qa, Qb, Qc);
    input Clk, D;
    output Qa, Qb, Qc;

    assign Clock = Clk;

    D_latch D1(Clock, D, Qa);
    Flipflop FF1(Clock, D, Qb); //for a positive-edge (rising) triggered D flip-flop, the master receives ~Clock and the slave receives Clock (Qm = D for Clk = 0, Qs = D for Clk = 1)
    Flipflop FF2(~Clock, D, Qc); //for a negative-edge (falling) triggered D flip-flop. Clock -> Clk. Thus, in master, ~Clk = ~(~Clock) = Clock. The master receieves Clock and slave receives ~Clock (Qm = D for Clk = 1, Qs = D for Clk = 0)
endmodule;

module D_latch(Clk, D, Qa);
    input Clk, D;
    output Qa;
    wire Qb, S_g, R_g;

    assign S_g = ~(D & Clk);
    assign R_g = ~(~D & Clk);
    assign Qa = ~(S_g & Qb);
    assign Qb = ~(R_g & Qa);
endmodule;

module Flipflop(Clk, D, Qs); //ouput Qs only changes at the rising or falling edge of the clock (if Clk = Clock, changes on rising edge. if Clk = ~Clock, changes on falling edge.)
    input Clk, D;
    output Qs; //output the slave result
    wire Qm;

    D_latch master(~Clk, D, Qm);
    D_latch slave(Clk, Qm, Qs);
endmodule;

