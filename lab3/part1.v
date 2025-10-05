module part1 (Clk, R, S, Qa, Qb);
    input Clk, R, S;
    output Qa, Qb;
    wire R_g, S_g;
    assign R_g = R & Clk;
    assign S_g = S & Clk;
    assign Qa = ~(R_g | Qb);
    assign Qb = ~(S_g | Qa); //this is allowed. You can assign Qb after Qa and still use Qb in prior lines of the module.
endmodule