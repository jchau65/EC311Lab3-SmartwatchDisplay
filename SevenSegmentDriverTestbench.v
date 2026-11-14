`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:17:29 PM
// Design Name: 
// Module Name: SevenSegmentDriverTestbench
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


module SevenSegmentDriverTestbench(
 
    );
    reg clk;
    reg rst;
    reg display_incrementer;
    reg [39:0] digits;
    
    wire [6:0] seg;
    wire [7:0] an;
    
    SevenSegmentDriver driver(clk, rst, display_incrementer, digits, seg, an);
    
    initial
    begin
        clk = 0;
        rst = 1;
        display_incrementer = 0;
        digits = 40'd0;
        
        #2
        
        rst = 0;
        
        #2
        
        digits = {{5'b11111}, {5'b00000}, {5'b00010}, {5'b11111}, {5'b11111}, {5'b00011}, {5'b00111}, {5'b11111}};
        
        #40;
        
        $finish;
    end
    
    always #1 clk = ~clk;
    always #1 display_incrementer = ~display_incrementer;
endmodule
