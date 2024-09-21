`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2024 03:18:48 PM
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb;

reg [3:0] a, b,opcode;
wire [3:0] x,y;

alu alu_1(x,y,a,b,opcode);

initial
$monitor("time=%d \t a=%a \t b=%b \t opcode=%opcode \t x=%x \t y=%y \t",$time,a,b,opcode,x,y);

initial begin
    a=0;
    b=0;
    opcode =0;
    repeat(16) begin
            #10 a=a+1;
            repeat(16) begin
                    #10 b=b+1;
                    repeat(2)
                        #10 opcode=~opcode;
            end
    end
end

endmodule
