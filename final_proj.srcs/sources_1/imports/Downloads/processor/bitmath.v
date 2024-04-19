module bitmath(
    input [11:0] binary,  // 12-bit binary input
    output reg [7:0] hundreds,  // BCD hundreds digit
    output reg [7:0] tens,  // BCD tens digit
    output reg [7:0] ones  // BCD ones digit
);
    integer i;
    reg [3:0] bcd[2:0];  // Array to hold the three BCD digits

    // Initialize the BCD digits to 0
    always @(binary) begin
        bcd[0] = 4'd0;  // ones
        bcd[1] = 4'd0;  // tens
        bcd[2] = 4'd0;  // hundreds
        for (i = 11; i >= 0; i = i - 1) begin
            if (bcd[0] >= 5)
                bcd[0] = bcd[0] + 3;
            if (bcd[1] >= 5)
                bcd[1] = bcd[1] + 3;
            if (bcd[2] >= 5)
                bcd[2] = bcd[2] + 3;

            bcd[2] = bcd[2] << 1;
            bcd[2][0] = bcd[1][3];
            bcd[1] = bcd[1] << 1;
            bcd[1][0] = bcd[0][3];
            bcd[0] = bcd[0] << 1;
            bcd[0][0] = binary[i];
        end

        hundreds = bcd[2];
        tens = bcd[1];
        ones = bcd[0];
    end
endmodule
