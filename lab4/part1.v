module part1 (SW, KEY, HEX1, HEX0);
    input [1:0] SW;
    input [0:0] KEY;
    output [6:0] HEX1, HEX0;

    wire [0:7] Count, T;

	assign T[0] = SW[1];
	assign T[1] = SW[1] & Count[0];
	assign T[2] = SW[1] & Count[0] & Count[1];
	assign T[3] = SW[1] & Count[0] & Count[1] & Count[2];
	assign T[4] = SW[1] & Count[0] & Count[1] & Count[2] & Count[3];
	assign T[5] = SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4];
	assign T[6] = SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4] & Count[5];
	assign T[7] = SW[1] & Count[0] & Count[1] & Count[2] & Count[3] & Count[4] & Count[5] & Count[6];

    TFF T0(T[0], KEY[0], SW[0], Count[0]);
    TFF T1(T[1], KEY[0], SW[0], Count[1]); //curious abt & vs &&
    TFF T2(T[2], KEY[0], SW[0], Count[2]);
    TFF T3(T[3], KEY[0], SW[0], Count[3]);
    TFF T5(T[4], KEY[0], SW[0], Count[4]);
    TFF T6(T[5], KEY[0], SW[0], Count[5]);
    TFF T7(T[6], KEY[0], SW[0], Count[6]);
    TFF T8(T[7], KEY[0], SW[0], Count[7]);

    BtoH7seg H0(Count[0:3], HEX0);
    BtoH7seg H1(Count[4:7], HEX1);
endmodule

module TFF(T, Clock, Clearn, Q);
    input T, Clock, Clearn;
    output reg Q;

    always @ (posedge Clock)
    begin
        if(!Clearn)
            Q <= 0;
        else if(T)
            Q <= ~Q;
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