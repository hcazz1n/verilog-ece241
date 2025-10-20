module part2(SW, KEY, HEX3, HEX2, HEX1, HEX0);
    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX3, HEX2, HEX1, HEX0;

    wire [0:15] Q;

    Sync_counter_16bit Counter(KEY[0], SW[0], SW[1], Q);

    BtoH7seg(Q[0:3], HEX0);
    BtoH7seg(Q[4:7], HEX1);
    BtoH7seg(Q[8:11], HEX2);
    BtoH7seg(Q[12:15], HEX3);
endmodule

module Sync_counter_16bit(Clock, Resetn, T, Q);
    input Clock, Resetn;
    output reg [0:15] Q;

    always @ (posedge clock)
    begin
        if(!Resetn)
            Q <= 0;
        else if(T)
            Q <= Q + 1;
    end
endmodule

module BtoH7seg (x, seg);
    input [3:0] x;
    output reg [6:0] seg;

  always @ (*) 
  begin
    case (x)
        4'h0: seg = 7'b1000000;
        4'h1: seg = 7'b1111001;
        4'h2: seg = 7'b0100100;
        4'h3: seg = 7'b0110000;
        4'h4: seg = 7'b0011001;
        4'h5: seg = 7'b0010010;
        4'h6: seg = 7'b0000010;
        4'h7: seg = 7'b1111000;
        4'h8: seg = 7'b0000000;
        4'h9: seg = 7'b0010000;
        4'hA: seg = 7'b0001000;
        4'hB: seg = 7'b0000011;
        4'hC: seg = 7'b1000110;
        4'hD: seg = 7'b0100001;
        4'hE: seg = 7'b0000110;
        4'hF: seg = 7'b0001110;
        default: seg = 7'b1111111;
    endcase
  end
endmodule