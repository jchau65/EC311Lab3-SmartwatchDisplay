module Display(
    input wire clk,
    input wire rst,
    input wire [7:0] state,
    input wire blink_incrementer,
    input wire [4:0] hours,
    input wire [5:0] mins,
    input wire [4:0] days,
    input wire [3:0] months,
    input wire [6:0] year,

    output reg [39:0] digits // outputs all 8 digits at a time
    );

    // digits codes copy pasted from seven segment display
    localparam C_B = 5'd10;
    localparam C_O = 5'd11;
    localparam C_T = 5'd12;
    localparam C_DASH = 5'd13;
    localparam C_BLANK = 5'd31;

    // enumerate states so I don't lose my mind typing 1s and 0s
    localparam S_BOOT = 8'b10000000;
    localparam S_TIME = 8'b01000000;
    localparam S_HOUR = 8'b00100000;
    localparam S_MIN  = 8'b00010000;
    localparam S_DATE = 8'b00001000;
    localparam S_DAY  = 8'b00000100;
    localparam S_MONTH= 8'b00000010;
    localparam S_YEAR = 8'b00000001;
    

    reg blink_on; // controls the blinking indicating the field that is being edited
    always @(posedge clk) begin
        if (rst) blink_on <= 0;
        else if (blink_incrementer) blink_on <= ~blink_on; // controls the blinnking
    end

    // split the values of each entry into tens and ones places
    wire [4:0] hours_t = hours / 10;
    wire [4:0] hours_o = hours % 10;
    wire [4:0] mins_t = mins / 10;
    wire [4:0] mins_o = mins % 10;
    wire [4:0] days_t = days / 10;
    wire [4:0] days_o = days % 10;
    wire [4:0] months_t = months / 10;
    wire [4:0] months_o = months % 10;
    wire [4:0] years_t = year / 10;
    wire [4:0] years_o = year % 10;

    // wire choosing what to hide
    wire hide_h = (state == S_HOUR) & ~blink_on;
    wire hide_m = (state == S_MIN) & ~blink_on;
    wire hide_d = (state == S_DAY) & ~blink_on;
    wire hide_M = (state == S_MONTH) & ~blink_on;
    wire hide_y = (state == S_YEAR) & ~blink_on;

    // wire that carries the true signal after decideing what to hide
    wire [9:0] hh = hide_h ? {C_BLANK, C_BLANK} : {hours_t, hours_o};
    wire [9:0] mm = hide_m ? {C_BLANK, C_BLANK} : {mins_t, mins_o};
    wire [9:0] dd = hide_d ? {C_BLANK, C_BLANK} : {days_t, days_o};
    wire [9:0] MM = hide_M ? {C_BLANK, C_BLANK} : {months_t, months_o};
    wire [9:0] yy = hide_y ? {C_BLANK, C_BLANK} : {years_t, years_o};

    // choose what to show depending on the state
    always @(*) begin
        case (state)
            S_BOOT:
                digits = {C_BLANK, C_BLANK, C_BLANK, C_BLANK, C_B, C_O, C_O, C_T};
            S_TIME, S_HOUR, S_MIN:
                digits = {C_BLANK, hh, C_BLANK, C_BLANK, mm, C_BLANK};
            S_DATE, S_DAY, S_MONTH, S_YEAR:
                digits = {dd, C_BLANK, MM, C_BLANK, yy};
            default: digits = {8{C_BLANK}}; // also cool trick apparently
        endcase
    end

endmodule