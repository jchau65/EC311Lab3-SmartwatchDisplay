`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:19:34 PM
// Design Name: 
// Module Name: DebouncerTestbench
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


module DebouncerTestbench();
    //input registers
    reg clk; // flips between on and off
    reg rst; 
    reg button;
    
    //output wires
    wire out;
    
    Debouncer debounce(
                       .clk(clk), 
                       .rst(rst), 
                       .button(button), 
                       .debb(out)
                       );
    
    //variables for testing the code
    integer i; //increments to represent different values
    
    //setup
    initial
    begin
        clk = 1'b0;
        rst = 1'b0;
        button = 1'b0;
        #5;
    end
    
    //clock
    always #1 clk = ~clk;
    
    //we lock tf in
    initial begin
        for(i = 0; i < 2; i = i+1) begin
            rst = i;
            
            // bouncy press
            #50;
            button = 1'b1; 
            #100;
            button = 1'b0;
            #200;
            
            button = 1'b1; 
            #200;
            button = 1'b0;
            #300;
            
            button = 1'b1;
            #4_500_000;
            
            // bouncy release
            button = 1'b0; 
            #100;
            button = 1'b1;
            #200;
            
            button = 1'b0; 
            #200;
            button = 1'b0;
            #300;
            
            button = 1'b0;
            #4_500_000;
        end
        $finish;
    end
    
endmodule
