module part5 (SW, KEY, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);
    input [7:0] SW;
    input [1:0] KEY;
    output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output [9:0] LEDR; 

    assign clock = KEY[1];
    assign Resetn = KEY[0];

    wire [7:0] Q;
    
    wire [7:0] storedQ;

    async_R8 R(SW[7:0], clock, Resetn, Q, storedQ); //sets Q to D if we are assigning values (clock = 1, Resetn = 1) or Q to 0 if we are resetting values (clock = x, Resetn = 0)

    seg7 H3(SW[7:4], HEX3); //first 4bits A
    seg7 H2(SW[3:0], HEX2); //second 4bits A
    seg7 H1(SW[7:4], HEX1); //first 4bits B
    seg7 H0(SW[3:0], HEX0); //second 4bits B


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

// module seg7_0or1(SW, HEX);
//     input [7:4] SW;
//     output [6:0] reg HEX;

//     assign comparator = SW[7] & (SW[6] | SW[5]);
//     always @ (comparator)
//         if(comparator)
//             HEX = 7'b1111100;
//         else
//             HEX = 7'b0111111;
// endmodule;

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
