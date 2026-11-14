`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2026 08:23:34 PM
// Design Name: 
// Module Name: Top
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


module Top #(parameter CLOCK_SPEED = 100000000)(
        input wire clk,
        input wire rst,
        input wire stateSwitcherButton, 
        input wire incrementButton, 
        input wire decrementButton,


        output wire [7:0] state, 
        output wire [6:0] segments,
        output wire [7:0] enabled
    );
    
    wire [7:0] tempState;
    wire debb;
    wire debi;
    wire debd;
    
    // debounced buttons
//    Debouncer stateSwitch(clk, rst, stateSwitcherButton, debb);
//    Debouncer increment(clk, rst, incrementButton, debi);
//    Debouncer decrement(clk, rst, decrementButton, debd);

    // posedge detected and debounced buttons
    PosedgeDetector #(.COUNTER(CLOCK_SPEED / 50)) stateSwitch(.clk(clk), .rst(rst), .button(stateSwitcherButton), .out(debb));
    PosedgeDetector #(.COUNTER(CLOCK_SPEED / 50)) increment(.clk(clk), .rst(rst), .button(incrementButton), .out(debi));
    PosedgeDetector #(.COUNTER(CLOCK_SPEED / 50)) decrement(.clk(clk), .rst(rst), .button(decrementButton), .out(debd));
    
    // controls the state
    Controller ctrl(
                    .clk(clk), 
                    .rst(rst), 
                    .stateSwitcherButton(debb),
                    .boot_en(boot_enable),
                    .state(tempState));
                    
    // boot timer - 1 when up
    wire boot_enable;
    
    // incrementers - 1 when that amount of time has passed
    wire min_incrementer;
    wire blink_incrementer;
    wire display_incrementer;
    
    // "generates" ticks for each unit of time
    TickGen #(.CLOCK_SPEED(CLOCK_SPEED)) tickgen(
                    .clk(clk),
                    .rst(rst),
                    .boot_enable(boot_enable),
                    .min_incrementer(min_incrementer),
                    .blink_incrementer(blink_incrementer),
                    .display_incrementer(display_incrementer)
                    );
                    
    // TIME KEEPER VARIABLES
    wire [4:0] hours;
    wire [5:0] mins;
    reg [1:0] ef_time; // edit field for time
    
    Timekeeper timekeep(
                        .clk(clk),
                        .rst(rst),
                        .min_incrementer(min_incrementer),
                        .edit_field(ef_time), // todo: MAKE EDIT_FIELD
                        .inc_en(debi),
                        .dec_en(debd),
                        .hours(hours),
                        .mins(mins)
                        );    
                    
    // DATE KEEPER OUTPUTS VARIABLES          
    wire [3:0] month;
    wire [4:0] day;
    wire [6:0] year;
    reg [2:0] ef_date; // edit field for date
    
    Datekeeper datekeeper(
                          .clk(clk),
                          .rst(rst),
                          .edit_field(ef_date),
                          .inc_en(debi),
                          .dec_en(debd), 
                          .month(month),
                          .day(day),
                          .year(year)
                          );
                          
    // SEVEN SEGMENT DRIVER VARIABLES                      
    wire [39:0] digits;
    
    SevenSegmentDriver sevSegDisp(
                                  .clk(clk),
                                  .rst(rst),  
                                  .display_incrementer(display_incrementer),
                                  .digits(digits),    
                                  .seg(segments),
                                  .an(enabled)
                                  );                
    
    
    // DISPLAY
    Display display(
                    .clk(clk),
                    .rst(rst),  
                    .state(tempState),
                    .blink_incrementer(blink_incrementer),
                    .hours(hours),
                    .mins(mins),
                    .days(day),
                    .months(month),
                    .year(year),
                    .digits(digits)
                    );
    
    
    
//    reg [counter_width-1:0] counter;
//    always @(posedge clk) begin
//        if (rst) begin
//            counter <= 0;
//        end else begin
//            counter <= counter + 1;
//        end
//    end
    

    
    always@(*) begin
        case(state)
            8'b10000000: begin // BOOT
                // here for documentation
                ef_time = 2'b00;
                ef_date = 3'b000;
            end
            8'b01000000: begin // TIME DISPLAY
                ef_time = 2'b00;
                ef_date = 3'b000;
            end
            8'b00100000: begin // HOUR SET
                ef_time = 2'b10;
                ef_date = 3'b000;
            end
            8'b00010000: begin // MINUTE SET
                ef_time = 2'b01;
                ef_date = 3'b000;
            end
            8'b00001000: begin // DATE DISPLAY
                ef_time = 2'b00;
                ef_date = 3'b000;
            end
            8'b00000100: begin // MONTH SET
                ef_date = 3'b100;
                ef_time = 2'b00;
            end
            8'b00000010: begin // DAY SET
                ef_date = 3'b010;
                ef_time = 2'b00;
            end
            8'b00000001: begin // YEAR SET
                ef_date = 3'b001;
                ef_time = 2'b00;
            end
        endcase
    end
    
    assign state = tempState;
endmodule
