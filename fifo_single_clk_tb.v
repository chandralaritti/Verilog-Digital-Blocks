`timescale 1ns/1ps

module fifo_single_clk_tb;

// Inputs to DUT
reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] buf_in;

// Outputs from DUT
wire [7:0] buf_out;
wire buf_empty;
wire buf_full;
wire [7:0] fifo_counter;

fifo_single_clk fifo_1(clk,rst,buf_in,buf_out,wr_en,rd_en,buf_empty,buf_full,fifo_counter);

initial begin
    $monitor("time = %t \t ,fifo_counter = %d \t ,buf_in = %d \t ,buf_out = %d \t,buf_empty = %d \t,buf_full = %d \t",$time, fifo_counter, buf_in, buf_out, buf_empty, buf_full);
end

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;       
    wr_en = 0;
    rd_en = 0;
    buf_in = 8'b0;

    // rst
    #10;
    rst = 0;

   //Write data
    #10;
    write_fifo(8'd11);  
    write_fifo(8'd12);  
    write_fifo(8'd13);  

    //Read data
    #20;
    read_fifo();        
    read_fifo();        
    read_fifo();        

    // fill the FIFO to full
    #20;
    repeat (64) write_fifo($random % 256);

    // Check buf_full
    if (buf_full) 
        $display("FIFO is full as expected.");

    // check it is empty
    #20;
    repeat (64) read_fifo();

    // Check FIFO buf_empty
    if (buf_empty) 
        $display("FIFO is empty as expected.");

    // Finish simulation
    #50;
    $stop;
end

// Write the data into fifo
task write_fifo;
    input [7:0] data;
    begin
        @(posedge clk);
        wr_en = 1;
        buf_in = data;
        @(posedge clk);
        wr_en = 0;
    end
endtask

// Read the data into fifo
task read_fifo;
    begin
        @(posedge clk);
        rd_en = 1;
        @(posedge clk);
        rd_en = 0;
    end
endtask

endmodule
