`timescale 1ns / 1ps

module single_port_RAM(q,data,rd_addr,wr_addr,wr_en,clk);
    input [7:0] data;
    input [5:0] rd_addr,wr_addr;
    input wr_en,clk;
    output reg [7:0] q;
    reg [7:0] ram[63:0];
    
    always @(posedge clk) begin
        if(wr_en)
            ram[wr_addr]<=data;
        q<=ram[rd_addr];
    end
endmodule
