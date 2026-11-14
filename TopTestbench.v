`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 06:39:43 PM
// Design Name: 
// Module Name: TopTestbench
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


module TopTestbench(

    );
    reg clk;
    reg rst;
    reg stateSwitcherButton;
    reg incrementButton;
    reg decrementButton;
    
    wire [7:0] state;
    wire [6:0] segments;
    wire [7:0] enabled;
    
    always #1 clk = ~clk;
    
    Top #(.CLOCK_SPEED(2000)) top(.clk(clk), .rst(rst), .stateSwitcherButton(stateSwitcherButton), .incrementButton(incrementButton), .decrementButton(decrementButton), .state(state), .segments(segments), .enabled(enabled));
    
    integer i = 0;
    initial
    begin
        clk = 0;
        stateSwitcherButton = 0;
        incrementButton = 0;
        decrementButton = 0;
        rst = 1;
        #2;
        rst = 0;
        #2;
        
        #5000; // wait for boot sequence
        
        for (i = 0; i < 8; i = i+1) begin
            stateSwitcherButton = 1;
            #100;
            stateSwitcherButton = 0;
            #1000;
        end
        
        for (i = 0; i < 8; i = i+1) begin
            incrementButton = 1;
            #100;
            incrementButton = 0;
            #100;
        end
        
        for (i = 0; i < 8; i = i+1) begin
            decrementButton = 1;
            #100;
            decrementButton = 0;
            #100;
        end
        
        #5000;
        
        $finish;
   end
endmodule
