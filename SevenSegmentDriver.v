module SevenSegmentDriver(
    input wire clk,
    input wire rst,
    input wire display_incrementer, // pulse from TickGen
    input wire [39:0] digits, // 8 x 5-bit codes; digits[4:0] = rightmost digit (AN0 i think)

    output reg [6:0] seg,
    output wire [7:0] an // determines which digit is outputted
    );

    // digit codes for letters
    localparam C_B = 5'd10;
    localparam C_O = 5'd11;
    localparam C_T = 5'd12;
    localparam C_DASH = 5'd13;
    localparam C_BLANK = 5'd31;

    // this part should handle which digit is outputted
    reg [2:0] digit_sel; // selects which digit to use
    always @(posedge clk) begin
        if (rst) digit_sel <= 3'b000;
        else if (display_incrementer) digit_sel <= digit_sel + 1;
    end

    wire [4:0] current_digit = digits[digit_sel*5 +: 5];

    // output for anode
    assign an = ~(8'b00000001 << digit_sel); // cool trick from google -- left shifts the bit by the amount that digit_sel is set to
    
    always @(*) begin
        case(current_digit) 
            5'd0: seg = 7'b1000000; // 0
            5'd1: seg = 7'b1111001; // 1
            5'd2: seg = 7'b0100100; // 2
            5'd3: seg = 7'b0110000; // 3
            5'd4: seg = 7'b0011001; // 4
            5'd5: seg = 7'b0010010; // 5
            5'd6: seg = 7'b0000010; // 6
            5'd7: seg = 7'b1111000; // 7
            5'd8: seg = 7'b0000000; // 8
            5'd9: seg = 7'b0010000; // 9
            C_B: seg = 7'b0000011; // B
            C_O: seg = 7'b0100011; // O
            C_T: seg = 7'b0000111; // T
            C_DASH: seg = 7'b0111111; // - probably not going to use this one
            default: seg = 7'b1111111; // all off
        endcase
    end
endmodule