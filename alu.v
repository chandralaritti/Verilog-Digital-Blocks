`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2024 03:17:48 PM
// Design Name: 
// Module Name: alu
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


module alu(x,y,a,b,opcode);

input [3:0] a,b,opcode;
output reg [3:0] x,y;

always@(a,b,opcode)
    case (opcode)
        4'b0000: x[0]=|a;
        4'b0001:x[0]=&a;
        4'b0010:x[0]=^a;
        4'b0011:x[0]=a & b;
        4'b0100:x[0]=a | b;
        4'b0101:x[0]=a ^ b;
        4'b0110:x[0]=a > b;
        4'b0111:x[0]=a < b;
        4'b1000:x[0]=!a;
        4'b1001:x[0]=(a == b);
        4'b1010:{y[0],x}=a+b;
        4'b1011:x=a - b;
        4'b1100:{y,x}=a * b;
        4'b1101:{y,x}=a >> b;
        4'b1110:{y,x}=a << b;
        4'b1111:x=~a;
        default:$display("error");
    endcase
endmodule
