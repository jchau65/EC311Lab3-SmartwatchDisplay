`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2026 09:43:39 PM
// Design Name: 
// Module Name: TimeKeeper
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


module Timekeeper(
    input wire clk,
    input wire rst,
    input wire min_incrementer,
    input wire [1:0] edit_field, // controls which field is being edited
    input wire inc_en, // when the incrementer is enabled
    input wire dec_en, // when the decrementer is enabled

    output reg [4:0] hours, // outputs the hours to the top file
    output reg [5:0] mins // outputs the minutes to the top file
    // output seconds // do if have time
    // output day_carry // do if have time
    );

    always @(posedge clk) begin
        if (rst) begin
            // resets the time
            hours <= 5'd0;
            mins <= 6'd0;
        end else begin
            // increments the minute 
            if (min_incrementer && edit_field == 2'b00) begin
                if (mins == 59) begin
                    mins  <= 6'd0;
                    hours <= (hours == 23) ? 5'd0 : hours + 1;
                end else mins <= mins + 1;
            end
            
            // edit fields
            if (edit_field == 2'b10) begin
                if (inc_en) hours <= (hours == 23) ? 5'd0 : hours + 1;
                if (dec_en) hours <= (hours == 0) ? 5'd23 : hours - 1;
            end

            else if (edit_field == 2'b01) begin
                if (inc_en) mins <= (mins == 59) ? 0 : mins + 1;
                if (dec_en) mins <= (mins == 0) ? 59 : mins - 1;
            end 
        end
    end
endmodule