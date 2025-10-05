module part2 (SW, LEDR);
    input [1:0] SW;
    output [9:0] LEDR;

    D_latch D1(SW[1], SW[0], LEDR[0], LEDR[1]);
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