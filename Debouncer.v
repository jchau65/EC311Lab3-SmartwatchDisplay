`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 07:30:14 PM
// Design Name: 
// Module Name: Debouncer
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


module Debouncer#(parameter COUNTER = 32'd2_000_000)(
    input wire clk,
    input wire rst,
    input wire button,
    
    output reg debb // short for debounced button
    );
    
    reg [31:0] counter;
    
    always @(posedge clk) begin
        if(rst) begin
            counter <= 0;
            debb <= 0;   
        end else begin
            if(button) begin
                counter <= counter + 1;
                if (counter == COUNTER) begin
                    debb <= 1;
                end else begin 
                    debb <= debb;
                end
            end else begin
                counter <= 0;
                debb <= 0;
            end
        end
    end
    
    
endmodule
