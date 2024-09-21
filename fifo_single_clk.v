`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2024 05:41:00 PM
// Design Name: 
// Module Name: fifo_single_clk
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


module fifo_single_clk(clk,rst,buf_in,buf_out,wr_en,rd_en,buf_empty,buf_full,fifo_counter);

input rst,clk,wr_en,rd_en;
input [7:0] buf_in;

output reg [7:0] buf_out;
output reg buf_empty,buf_full;
output [7:0] fifo_counter;

reg [6:0] fifo_counter;
reg [3:0] rd_ptr, wr_ptr;
reg [7:0] buf_mem[63:0];

//Check the status flag
always @(fifo_counter) begin
    buf_empty=(fifo_counter ==0);
    buf_full=(fifo_counter==64);
end

//manages fifo counter
always @(posedge clk,posedge rst) begin
    if(rst)
        fifo_counter <=0;
    else if((!buf_full && wr_en) &&(!buf_empty && rd_en))
        fifo_counter <=fifo_counter;
    else if(!buf_full && wr_en)
        fifo_counter <= fifo_counter+1;
    else if(!buf_empty && rd_en)
        fifo_counter <=fifo_counter-1;
    else
        fifo_counter <=fifo_counter;
        
end 

// fetch the data from FIFO
always @(posedge clk or posedge rst) begin
    if (rst)
        buf_out<=0;
    else begin
        if(rd_en && !buf_empty)
            buf_out <=buf_mem[rd_ptr];
        else
            buf_out <= buf_out;
   end
end

//writing the data into FIFO
always @(posedge clk) begin
    if(wr_en && !buf_full)
        buf_mem[wr_ptr]=buf_in;
    else
        buf_mem[wr_ptr] <= buf_mem[wr_ptr];
end

//manage the pointers
always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <=0;
        rd_ptr <=0;
    end
    else begin
        if (!buf_full && wr_en)
            wr_ptr <=wr_ptr+1;
        else
            wr_ptr <=wr_ptr;
        if (!buf_empty && rd_en)
            rd_ptr <=rd_ptr + 1;
        else
            rd_ptr <= rd_ptr;
    end
end
    
endmodule

