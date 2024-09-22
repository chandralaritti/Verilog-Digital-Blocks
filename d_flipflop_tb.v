module d_flipflop_tb;
    reg d,clk,rst,set;
    wire q;
    d_flipflop d1(q,d,clk,rst,set);
    
    always #5 clk=~clk;
    
    initial begin
        clk=1;
        rst=1;
        d=1;
        #10 rst=0;
        #20 rst=1;
        #30 d=0;
        #50 set=1;
        #60 rst=0;
        #70 d=1;
        #80 set=0;
        
        #100 $stop;
   end
endmodule
