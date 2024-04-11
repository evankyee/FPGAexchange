module receiver(input clk, input reset, input datain, output[31:0] reg data, input comEn, output reg dataRDY);

reg[5:0] counter;

reg clock;
reg [7:0] counter2;
always @(posedge clk) begin
    if (counter1<50)
    counter <= counter +1;
    else begin
        counter <= 0;
        clock <= ~clock;
    end

end

always @(posedge clock or posedge rst) begin
    if (reset) begin
        counter <= 0;
        data <= 32'b0;
        done <= 0;
    end else if (comEn) begin
         if (counter < 32) begin
            word_received <= (word_received << 1) | datain;
            counter <= counter + 1;
            done <= 0;
        end
        if (counter==31) begin
            dataRDY <= 1;
            counter <= 0; 
        end
    end else if (!comEn) begin//making sure if we have dataen off we arent counting/updating our data!
        counter <= 0;
        data <= 0;
        dataRDY <= 0;
    end
end


endmodule