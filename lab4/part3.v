module part3 (KEY, CLOCK_50, HEX0);
    input [0:0] KEY;
    input CLOCK_50;
    output [6:0] HEX0;

    assign slow_count = CLOCK_50;
    wire [3:0] digit;

    Sync_second_cycle_4bit Counter(slow_count, KEY[0], digit);

    BtoD7seg H0(digit, HEX0);

endmodule

module Sync_second_cycle_4bit(Clock, Resetn, Q);
    input Clock, Resetn;
    output reg [3:0] Q;

    reg [25:0] value; //26 bits needed to rep. 50 mil

    always @ (posedge Clock)
    begin
        if(!Resetn)
        begin
            Q <= 0;
            value <= 0;
        end
        else if(value != 50000000 - 1) //0 to 49999999 = 50 million cycles
            value <= value + 1;
        else
        begin
            value <= 0;
            if(Q == 9)
                Q <= 0;
            else
                Q <= Q + 1;
        end
    end
endmodule

module BtoD7seg (x, HEX);
    input [3:0] x;
    output reg [6:0] HEX;

    always @ (*) 
    begin
        case (x)
            4'd0: HEX = 7'b1000000;
            4'd1: HEX = 7'b1111001;
            4'd2: HEX = 7'b0100100;
            4'd3: HEX = 7'b0110000;
            4'd4: HEX = 7'b0011001;
            4'd5: HEX = 7'b0010010;
            4'd6: HEX = 7'b0000010;
            4'd7: HEX = 7'b1111000;
            4'd8: HEX = 7'b0000000;
            4'd9: HEX = 7'b0010000;
            default: HEX = 7'b1111111;
        endcase
    end
endmodule