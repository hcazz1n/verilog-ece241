module part4 (KEY, CLOCK_50, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);

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

module Sync_counter_16bit(Clock, Resetn, T, Q);
    input Clock, Resetn, T;
    output reg [0:15] Q;

    always @ (posedge Clock)
    begin
        if(!Resetn)
            Q <= 0;
        else if(T)
            Q <= Q + 1;
    end
endmodule

module dE1_BtoH7seg (x, HEX);
    input [3:0] x;
    output reg [6:0] HEX;

  always @ (*) 
  begin
    case (x)
        4'h1: HEX = 7'b1111001;
        4'hD: HEX = 7'b0100001;
        4'hE: HEX = 7'b0000110;
        default: HEX = 7'b1111111; //any value that isn't d E 1 will be set to the default 1111111
    endcase
  end
endmodule

