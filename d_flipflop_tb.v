`timescale 1ns / 1ps

//synchronous D-FlipFlop with reset and set

module d_flipflop_tb;

    reg d, clk, rst, set;
    wire q;
    
    d_flipflop d1(q,d,clk,rst,set);
    
    initial begin
        $monitor("time=%0d, rst=%b, set=%b, d=%b, q=%b", $time, rst, set, d, q);
    end

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        d = 0;
        rst = 0;
        set = 0;

        #10 rst = 0;
        #10 rst = 1; 

        #10 set = 1;  
        #10 set = 0;  

        
        #10 d = 1;    
        #10 d = 0;    

        
        #10 rst = 0;  
        #10 rst = 1;  

        #20 $stop;
    end
endmodule

