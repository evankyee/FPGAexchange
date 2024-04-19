module receiver(input clk, input reset, input datain, output reg [31:0] data=0, input comEn, output reg dataRDY=0, output reg[7:0] counter=0);

//reg[7:0] counter=0;

reg clock=0;
reg [31:0] counter2;
always @(posedge clk) begin
    if (counter2<500000)
    counter2 <= counter2 +1;
    else begin
        counter2 <= 0;
        clock <= ~clock;
    end

end


always @(posedge clock or posedge reset) begin
    if (reset) begin
        counter <= 0;
        data <= 32'b0;
        dataRDY <= 0;
    end else if (comEn) begin
        if (counter < 33) begin
            data <= (data << 1) | datain;
            counter <= counter + 1;
            dataRDY <= 0;
        end
        if (counter==33) begin
            dataRDY <= 1;
        end
    end else if (!comEn) begin //making sure if we have dataen off we arent counting/updating our data!
        counter <= 0;
        data <= 0;
        dataRDY <= 0;
    end
end


endmodule