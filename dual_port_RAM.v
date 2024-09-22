`timescale 1ns / 1ps

module dual_port_RAM(q,data,rd_addr,wr_addr,wr_en,rd_clk,wr_clk);
    
    input [7:0] data;
    input [5:0] rd_addr,wr_addr;
    input wr_en,rd_clk,wr_clk;
    output reg [7:0] q;
    reg [7:0] ram[63:0];
    
    //write port
    always @(posedge wr_clk)
        if(wr_en)
            ram[wr_addr]<=data;
    //read port
    always @(posedge rd_clk)
        q<=ram[rd_addr];
 
endmodule
