module Datekeeper (
    input wire clk,
    input wire rst,
    //input wire day_carry // do if have time
    input wire [2:0] edit_field,
    input wire inc_en, // used for increasing a field
    input wire dec_en, // used for decreasing a field

    output reg [3:0] month,
    output reg [4:0] day,
    output reg [6:0] year // limited to the 21st century
    );

    always@(posedge clk) begin
        if (rst) begin
            // resets the time
            month <= 4'd1;
            day <= 5'd1;
            year <= 7'd0;
        end else begin
            // incrementing by day -- not going to be implemented unless time allows
            // also, some months do not have 31 days, not going to be implemented unless time allows

            // edit field
            if (edit_field == 3'b100) begin
                if (inc_en) month <= (month == 12) ? 1 : month + 1;
                if (dec_en) month <= (month == 1) ? 12 : month - 1;
            end else if (edit_field == 3'b010) begin
                if (inc_en) day <= (day == 31) ? 1 : day + 1;
                if (dec_en) day <= (day == 1) ? 31 : day - 1;
            end else if (edit_field == 3'b001) begin
                if (inc_en) year <= (year == 99) ? 0 : year + 1;
                if (dec_en) year <= (year == 0) ? 99 : year - 1;
            end
        end
    end
endmodule