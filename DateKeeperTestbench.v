`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:17:09 PM
// Design Name: 
// Module Name: DateKeeperTestbench
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


module DateKeeperTestbench();
    reg clk;
    reg rst;
    reg [2:0] edit_field;
    reg inc_en;
    reg dec_en;
    wire [3:0] month;
    wire [4:0] day;
    wire [6:0] year;
    
    Datekeeper dk(clk, rst, edit_field, inc_en, dec_en, month, day, year);
    
    initial
    begin
        rst = 1;
        clk = 0;
        edit_field = 0;
        inc_en = 0;
        dec_en = 0;
        #5;
        rst = 0;
    end
    
    always #1 clk = ~clk;
    integer i = 0;
    integer j = 0;
    
    initial
    begin
        for(i = 1; i <= 3'b111; i = i*2) begin // to gor thru one hot
            {edit_field} = i[2:0];
            //month incrementing
            for(j = 0; j <= 12; j = j+1) begin
                inc_en = ~inc_en;
                #5;
                inc_en = ~inc_en;
                #5;
            end
            //month decrementing
            for(j = 0; j <= 12; j = j+1) begin
                dec_en = ~dec_en;
                #5;
                dec_en = ~dec_en;
                #5;
            end
            //day incrementing
            for(j = 0; j <= 31; j = j+1) begin
                inc_en = ~inc_en;
                #5;
                inc_en = ~inc_en;
                #5;
            end
            //day decrementing
            for(j = 0; j <= 31; j = j+1) begin
                dec_en = ~dec_en;
                #5;
                dec_en = ~dec_en;
                #5;
            end
            //year incrementing
            for(j = 0; j <= 100; j = j+1) begin
                inc_en = ~inc_en;
                #5;
                inc_en = ~inc_en;
                #5;
            end
            //year decrementing
            for(j = 0; j <= 100; j = j+1) begin
                dec_en = ~dec_en;
                #5;
                dec_en = ~dec_en;
                #5;
            end
        end
        $finish;
    end
endmodule
