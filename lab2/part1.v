module part1 (SW, LEDR, HEX1, HEX0);
    input [7:0] SW;
    output [7:0] LEDR;
    output [6:0] HEX1, HEX0;

    assign HEX0[0] = ~SW[1] & ((~SW[3] & ~SW[2] & SW[0]) | (SW[2] & ~SW[0]));
    assign HEX0[1] = SW[2] & ((~SW[1] & SW[0]) | (SW[1] & ~SW[0]));
    assign HEX0[2] = ~SW[2] & SW[1] & ~SW[0];
    assign HEX0[3] = (SW[2] & ~SW[1] & ~SW[0]) | (~SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & SW[0]);
    assign HEX0[4] = SW[0] | (~SW[1] & SW[2]);
    assign HEX0[5] = (SW[1] & SW[0]) | (~SW[3] & ~SW[2] & SW[0]) | (~SW[3] & ~SW[2] & SW[1]);
    assign HEX0[6] = (~SW[3] & ~SW[2] & ~SW[1]) | (SW[2] & SW[1] & SW[0]);

    assign HEX1[0] = ~SW[5] & ((~SW[7] & ~SW[6] & SW[4]) | (SW[6] & ~SW[4]));
    assign HEX1[1] = SW[6] & ((~SW[5] & SW[4]) | (SW[5] & ~SW[4]));
    assign HEX1[2] = ~SW[6] & SW[5] & ~SW[4];
    assign HEX1[3] = (SW[6] & ~SW[5] & ~SW[4]) | (~SW[6] & ~SW[5] & SW[4]) | (SW[6] & SW[5] & SW[4]);
    assign HEX1[4] = SW[4] | (~SW[5] & SW[6]);
    assign HEX1[5] = (SW[5] & SW[4]) | (~SW[7] & ~SW[6] & SW[4]) | (~SW[7] & ~SW[6] & SW[5]);
    assign HEX1[6] = (~SW[7] & ~SW[6] & ~SW[5]) | (SW[6] & SW[5] & SW[4]);
endmodule
