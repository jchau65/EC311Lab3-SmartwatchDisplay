`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:18:29 PM
// Design Name: 
// Module Name: DisplayTestbench
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


module DisplayTestbench();

    reg clk;
    reg rst;
    reg [7:0] state;
    reg blink_incrementer;
    reg [4:0] hours;
    reg [5:0] mins;
    reg [4:0] days;
    reg [3:0] months;
    reg [6:0] year;
    
    wire [39:0] digits;
    
    Display disp(clk, rst, state, blink_incrementer, hours, mins, days, months, year, digits);
    
        integer i = 0;
    
    initial
    begin
        clk = 0;
        rst = 1;
        state = 0;
        blink_incrementer = 0;
        #2;
        rst = 0;
        hours = 5'b00110;
        mins = 6'b001011;
        days = 5'b00011;
        months = 4'b0111;
        year = 7'b0001101;
        #2;
        
        state = 8'b10000000;
    
        for(i = 8; i >= 2; i = i-1) begin
            state = state >> 1; // to get one hot
            blink_incrementer = ~blink_incrementer;
            #2;
            blink_incrementer = ~blink_incrementer;
            #2;
        end
        $finish;
    end
    
    always #2 clk = ~clk;
    
    
endmodule





