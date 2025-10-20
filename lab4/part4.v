module part4 (KEY, CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
    input [0:0] KEY;
    input CLOCK_50;
    output [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

    wire [31:0] cycle;
    wire [1:0] HEXNUM5, HEXNUM4, HEXNUM3, HEXNUM2, HEXNUM1, HEXNUM0;

    Sync_second_cycle_4bit MEGA_CLOCK(CLOCK_50, KEY[0], HEXNUM5, HEXNUM4, HEXNUM3, HEXNUM2, HEXNUM1, HEXNUM0, cycle);

    BtoH7seg(HEXNUM5, HEX5);
    BtoH7seg(HEXNUM4, HEX4);
    BtoH7seg(HEXNUM3, HEX3);
    BtoH7seg(HEXNUM2, HEX2);
    BtoH7seg(HEXNUM1, HEX1);
    BtoH7seg(HEXNUM0, HEX0);

endmodule

module Sync_second_cycle_4bit(Clock, Resetn, HEXNUM5, HEXNUM4, HEXNUM3, HEXNUM2, HEXNUM1, HEXNUM0, Q);
    input Clock, Resetn;
    output reg [1:0] HEXNUM5, HEXNUM4, HEXNUM3, HEXNUM2, HEXNUM1, HEXNUM0;
    output reg [2:0] Q;

    reg [25:0] value; //26 bits needed to rep. 50 mil

    always @ (posedge Clock)
    begin
        if(!Resetn)
        begin
            Q <= 0;
            value <= 0;
            HEXNUM5 <= 2'b11;
            HEXNUM4 <= 2'b11;
            HEXNUM3 <= 2'b11;
            HEXNUM2 <= 2'b00;
            HEXNUM1 <= 2'b01;
            HEXNUM0 <= 2'b10;
        end
        else if(value != 50000000 - 1) //0 to 49999999 = 50 million cycles
            value <= value + 1;
        else
        begin
            value <= 0;
            if(Q == 6) //6 unique cycles
            begin
                Q <= 0;
                Q <= Q + 1;
            end
            HEXNUM5 <= HEXNUM4;
            HEXNUM4 <= HEXNUM3;
            HEXNUM3 <= HEXNUM2;
            HEXNUM2 <= HEXNUM1;
            HEXNUM1 <= HEXNUM0;
            HEXNUM0 <= HEXNUM5;
        end
    end

endmodule

module BtoH7seg (x, HEX);
    input [1:0] x;
    output reg [6:0] HEX;

    always @ (*)
    begin
        case (x)
        2'b00: HEX = 7'b0100001; //case statement d
            2'b01: HEX = 7'b0000110; //case statement E
            2'b10: HEX = 7'b1111001; //case statement 1
            2'b11: HEX = 7'b1111111; //displays blank
        endcase
    end
endmodule