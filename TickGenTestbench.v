`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:16:10 PM
// Design Name: 
// Module Name: TickGenTestbench
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

// clock should be at least 1000 cuz of displayincrementer
module TickGenTestbench();

    reg clk;
    reg rst;
    wire boot_enable;
    wire min_incrementer;
    wire blink_incrementer;
    wire display_incrementer;
    
    TickGen #(.CLOCK_SPEED(2000)) tg(
        .clk(clk),
        .rst(rst),
        .boot_enable(boot_enable),
        .min_incrementer(min_incrementer),
        .blink_incrementer(blink_incrementer),
        .display_incrementer(display_incrementer)
        );
        
    initial
    begin
        clk = 0;
        rst = 0;
    end
    
    always #2 clk = ~clk;
    
    //1000 clock ticks = 1 second. 4 time units per tick cycle. 60 seconds per minute. 
    initial
    begin
        rst = 0;
        #480000;
        rst = 1;
        #20;
        $finish;
    end
        
    
endmodule









