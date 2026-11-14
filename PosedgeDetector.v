`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 09:26:57 PM
// Design Name: 
// Module Name: PosedgeDetector
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


module PosedgeDetector#(parameter COUNTER = 32'd2_000_000)(
    input wire clk,
    input wire rst,
    input wire button,
    
    output wire out
    );
    
    wire debb;
    Debouncer #(.COUNTER(COUNTER)) debounced (
        .clk(clk), 
        .rst(rst), 
        .button(button), 
        .debb(debb));
    
    reg signal_previous; // previous version of the state switching input
    wire switch; // stay on for one clock cycle -- used for posedge detection
    
    always@(posedge clk) begin
        if (rst) begin
            signal_previous <= 1'b0;
        end else begin
            signal_previous <= debb;
        end
    end
    
    assign out = debb & ~signal_previous;
endmodule
