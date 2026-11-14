`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:16:43 PM
// Design Name: 
// Module Name: TimeKeeperTestbench
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


module TimeKeeperTestbench();
    reg clk;
    reg rst;
    reg min_incrementer;
    reg [1:0] edit_field;
    reg inc_en;
    reg dec_en;
    wire [4:0] hours;
    wire [5:0] mins;
    
    Timekeeper tk(clk, rst, min_incrementer, edit_field, inc_en, dec_en, hours, mins);
    
    initial
    begin
        clk = 0;
        rst = 1;
        min_incrementer = 0;
        edit_field = 0;
        inc_en = 0;
        dec_en = 0;
        #5;
        rst = 0;
        #5;
    end
    
    always #1 clk = ~clk;
    integer i = 0;
    integer j = 0;
    
    initial
    begin
        for(i = 0; i <= 3'b111; i = i+1) begin
            {min_incrementer, edit_field} = i[2:0];
            //minute incrementing
            for(j = 0; j <= 60; j = j+1) begin
                inc_en = ~inc_en;
                #5;
                inc_en = ~inc_en;
                #5;
            end
            //minute decrementing
            for(j = 0; j <= 60; j = j+1) begin
                dec_en = ~dec_en;
                #5;
                dec_en = ~dec_en;
                #5;
            end
            //hour incrementing
            for(j = 0; j <= 60; j = j+1) begin
                inc_en = ~inc_en;
                #5;
                inc_en = ~inc_en;
                #5;
            end
            //hour decrementing
            for(j = 0; j <= 60; j = j+1) begin
                dec_en = ~dec_en;
                #5;
                dec_en = ~dec_en;
                #5;
            end
        end
        $finish;
    end
        
endmodule
