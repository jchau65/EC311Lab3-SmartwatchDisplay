module TickGen #( 
    parameter CLOCK_SPEED = 100000000 // clock speed of the FPGA (Nexys A7)
) (

    input wire clk,
    input wire rst,
    output reg min_incrementer, // outputs a 1 on the clock cycle where the minute should be incremented
    output reg blink_incrementer, // outputs a 1 when the output needs to blink
    output reg display_incrementer // outputs a 1 on the clock cycle where the display needs to be refreshed
);
    // these are the counters that need to be incremented
    reg [32:0] min_counter = 0; // 2^33 > 6e9
    reg [26:0] blink_counter = 0; // 2^27 > 50e6
    reg [16:0] display_counter = 0; // 2^17 > 100000

    localparam [32:0] MIN_CYCLES = 64'd60 * CLOCK_SPEED; // 60 is num of seconds, also need the 64'd60 to force a 64bit wide calculation because it was too big for 32-bits
    localparam BLINK_CYCLES = CLOCK_SPEED / 2; // every 0.5 seconds
    localparam DISPLAY_CYCLES = CLOCK_SPEED / 1000; // 1000 is a subfrequency

    always @(posedge clk) begin
        if (rst) begin
            // reset all three counters
            min_counter <= 0;
            blink_counter <= 0;
            display_counter <= 0;
            
            // reset all three incrementers
            min_incrementer <= 0;
            blink_incrementer <= 0;
            display_incrementer <= 0;
        end else begin
            // increment all three counters
            min_counter <= min_counter + 1;
            blink_counter <= blink_counter + 1;
            display_counter <= display_counter + 1;

            // reset all three incrementers
            min_incrementer <= 0;
            blink_incrementer <= 0;
            display_incrementer <= 0;

            // check if minute counter goes over
            if (min_counter >= MIN_CYCLES - 1) begin
                min_counter <= 0;
                min_incrementer <= 1;
            end
            
            // check if blink counter goes over
            if (blink_counter >= BLINK_CYCLES - 1) begin
                blink_counter <= 0;
                blink_incrementer <= 1;
            end

            // check if display counter goes over
            if (display_counter >= DISPLAY_CYCLES - 1) begin
                display_counter <= 0;
                display_incrementer <= 1;
            end
        end
    end

endmodule