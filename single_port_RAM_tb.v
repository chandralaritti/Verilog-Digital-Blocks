`timescale 1ns / 1ps

module single_port_RAM_tb;

    // Testbench signals
    reg [7:0] data;
    reg [5:0] rd_addr, wr_addr;
    reg wr_en, clk;
    wire [7:0] q;

    // Instantiate the single_port_RAM module
    single_port_RAM s1(q,data,rd_addr,wr_addr,wr_en,clk);
     initial begin
        $monitor("At time %t: rd_addr = %d, wr_addr = %d, data = %d, q = %d, wr_en = %b", $time, rd_addr, wr_addr, data, q, wr_en);
    end

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        data = 8'd0;
        rd_addr = 6'd0;
        wr_addr = 6'd0;
        wr_en = 0;

        #10;
        
        wr_en = 1;  
        data = 8'd55;
        wr_addr = 6'd0;
        #10;

        data = 8'd100;
        wr_addr = 6'd1;
        #10;
        
        data = 8'd200;
        wr_addr = 6'd2;
        #10;

        wr_en = 0;
        #10;

        rd_addr = 6'd0;
        #10;

        rd_addr = 6'd1;
        #10;
        
        rd_addr = 6'd2;
        #10;

        $stop;
    end

   
endmodule

