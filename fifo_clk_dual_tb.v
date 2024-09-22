`timescale 1ns / 1ps

`timescale 1ns/1ps

module fifo_clk_dual_tb;

  reg clk_r, clk_w, rst;
  reg wr_en, rd_en;
  reg [7:0] buf_in;
  wire [7:0] buf_out;
  wire buf_empty, buf_full;
  wire [3:0] fifo_counter;
  
  fifo_clk_dual fifo_1(clk_r,clk_w,rst,buf_in,buf_out,wr_en,rd_en,buf_empty,buf_full,fifo_counter);
  
  initial begin
    $monitor("time: %dt \t, wr_en: %b \t, rd_en: %b \t, buf_in:%d \t, buf_out:%d \t, buf_empty: %b \t, buf_full: %b | fifo_counter: %d",$time, wr_en, rd_en, buf_in, buf_out, buf_empty, buf_full, fifo_counter);
  end
  //Generate the clock
  initial begin
    clk_r = 0;
    clk_w = 0;
    forever begin
      #5 clk_r = ~clk_r;  
      #3 clk_w = ~clk_w; 
    end
end
 // Simulation initialization
initial begin
    $dumpfile("fifo_clk_dual_tb.vcd");
    $dumpvars(0, fifo_clk_dual_tb);
    //Initial signal
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    buf_in = 8'd0;
    
    // Reset
    #10 rst = 0;
    
    // Write 5 values to the FIFO
    write_data(8'd11);
    write_data(8'd22);
    write_data(8'd33);
    write_data(8'd44);
    write_data(8'd55);
    
    // Read 2 values from the FIFO
    read_data();
    read_data();

    // write few more values
    write_data(8'd66);
    write_data(8'd77);
    write_data(8'd88);
    
    // read all the values
    repeat(6) read_data();
    
    // End simulation
    #20;
    $finish;
end

// Writing the data into FIFO
task write_data;
input [7:0] data;
begin
@(posedge clk_w);
buf_in = data;
wr_en = 1;
@(posedge clk_w);
wr_en = 0;
#2;
end
endtask

//Reading the data into FIFO
task read_data;
begin
  @(posedge clk_r);
  rd_en = 1;
  @(posedge clk_r);
  rd_en = 0;
  #2;
end
endtask

endmodule

