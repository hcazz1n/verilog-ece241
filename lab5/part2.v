module part2(SW, KEY, LEDR);
    input [1:0] SW;
    input [0:0] KEY;
    output reg [0:8] LEDR; //0 = state 0 = A, 1 = state 1 = B, ... , 9 = output

    wire w, z;
    assign w = SW[1];
    assign LEDR[9] = z;

    reg [3:0] y_Q, Y_D;
    parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110, H = 4'b0111, I = 4'b1000;

    always @ (w, y_Q)
    begin : state_table
        case(y_Q) //2 statements for each present state, one for !w (if input = 0, next state = ...), one for w (if input = 1, next state = ...)
            A: if(!w) Y_D = B; else Y_D = F;
            B: if(!w) Y_D = C; else Y_D = F;
            C: if(!w) Y_D = D; else Y_D = F;
            D: if(!w) Y_D = E; else Y_D = F;
            E: if(!w) Y_D = E; else Y_D = F;
            F: if(!w) Y_D = B; else Y_D = G;
            G: if(!w) Y_D = B; else Y_D = H;
            H: if(!w) Y_D = B; else Y_D = I;
            I: if(!w) Y_D = B; else Y_D = I;
        endcase
    end

    always @ (posedge KEY[0])
    begin : state_FFs
        if(!SW[0])
            y_Q <= 4'b0;
        else
            y_Q <= Y_D;
    end

    always @ (*)
    begin : assign_output
        LEDR = 10'b0;
        case(y_Q)
            A: LEDR[0] = 1;
            B: LEDR[1] = 1;
            C: LEDR[2] = 1;
            D: LEDR[3] = 1;
            E: LEDR[4] = 1;
            F: LEDR[5] = 1;
            G: LEDR[6] = 1;
            H: LEDR[7] = 1;
            I: LEDR[8] = 1;
            default;
        endcase

        if(Y_D == E || Y_D == I) LEDR[9] = 1;
    end

endmodule;