module part1 (SW, KEY, HEX1, HEX0);
    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX1, HEX0;

    wire [0:7] Q;

    TFF T0(SW[1], KEY[0], SW[0], Q[0]);
    TFF T1(SW[1] & Q[0], KEY[0], SW[0], Q[1]); //curious abt & vs &&
    TFF T2(SW[1] & Q[1], KEY[0], SW[0], Q[2]);
    TFF T3(SW[1] & Q[2], KEY[0], SW[0], Q[3]);
    TFF T5(SW[1] & Q[3], KEY[0], SW[0], Q[4]);
    TFF T6(SW[1] & Q[4], KEY[0], SW[0], Q[5]);
    TFF T7(SW[1] & Q[5], KEY[0], SW[0], Q[6]);
    TFF T8(SW[1] & Q[6], KEY[0], SW[0], Q[7]);

    BtoH7seg H0(Q[0:3], HEX0);
    BtoH7seg H1(Q[4:7], HEX1);
endmodule

module TFF(T, Clock, Clearn, Q);
    input T, Clock, Clearn;
    output reg Q;

    always @ (posedge Clock)
    begin
        if(!Clearn)
            Q <= 0;
        else if(T)
            Q <= T;
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