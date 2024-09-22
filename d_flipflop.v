`timescale 1ns / 1ps
//Synchronous set and reset
module d_flipflop(q,d,clk,rst,set);
    input d,clk,rst,set;
    output reg q;
    always @(posedge clk)
        if(!rst)
            q<=1'b0;
        else if(set)
            q<=1'b1;
        else
            q<=d;
endmodule
