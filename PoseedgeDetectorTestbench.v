`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2026 02:19:10 PM
// Design Name: 
// Module Name: PoseedgeDetectorTestbench
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


module PoseedgeDetectorTestbench();
    //register inputs
    reg clk;
    reg rst;
    reg button;
    //wire outputs
    wire out;
    
    PosedgeDetector #(.COUNTER(32'd5)) posdet(
                           .clk(clk),
                           .rst(rst),
                           .button(button),
                           .out(out)
                           );
    
    //setup
    initial
    begin
        clk = 1'b0;
        rst = 1'b0;
        #5;
    end
    
    //clock
    always #1 clk = ~clk;
    
    reg [2:0] i = 0;
    reg [1:0] signalTemp;
    
    initial
    begin
        for(i = 0; i <= 3'b111; i = i+1) begin
            {rst, signalTemp} = i;
            button = signalTemp[0];
            #15;
        end
        $finish;
    end
    
    
endmodule
