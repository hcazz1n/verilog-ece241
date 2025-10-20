module part2(SW, KEY, HEX3, HEX2, HEX1, HEX0);
    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX3, HEX2, HEX1, HEX0;

    wire [0:15] Count;

    Sync_counter_16bit Counter(KEY[0], SW[0], SW[1], Count);

    BtoH7seg H0(Count[0:3], HEX0);
    BtoH7seg H1(Count[4:7], HEX1);
    BtoH7seg H2(Count[8:11], HEX2);
    BtoH7seg H3(Count[12:15], HEX3);
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

module BtoH7seg (x, HEX);
    input [3:0] x;
    output reg [6:0] HEX;

  always @ (*) 
  begin
    case (x)
        4'h0: HEX = 7'b1000000;
        4'h1: HEX = 7'b1111001;
        4'h2: HEX = 7'b0100100;
        4'h3: HEX = 7'b0110000;
        4'h4: HEX = 7'b0011001;
        4'h5: HEX = 7'b0010010;
        4'h6: HEX = 7'b0000010;
        4'h7: HEX = 7'b1111000;
        4'h8: HEX = 7'b0000000;
        4'h9: HEX = 7'b0010000;
        4'hA: HEX = 7'b0001000;
        4'hB: HEX = 7'b0000011;
        4'hC: HEX = 7'b1000110;
        4'hD: HEX = 7'b0100001;
        4'hE: HEX = 7'b0000110;
        4'hF: HEX = 7'b0001110;
        default: HEX = 7'b1111111;
    endcase
  end
endmodule