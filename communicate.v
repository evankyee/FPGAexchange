module communicate(input clk, input start, input reset, input[31:0] word, output reg dataout, output reg comEn);

reg[5:0] counter;
reg[31:0] shiftreg;
reg state;

reg clock;
reg [7:0] counter2;
always @(posedge clk) begin
    if (counter2<50)
    counter2 <= counter2 +1;
    else begin
        counter2 <= 0;
        clock <= ~clock;
    end

end

parameter on =1, off=0;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= 0;
        shiftreg <= 32'b0;
        counter <= 0;
        dataout <= 0;
        comEn <= 0;    //ensure data is off if reset
    end else begin
        case (state) 
            off:
                if (start==1) begin
                    shiftreg <= word; //at start we put word into reg we are shifting
                    state <= on;
                    comEn <= 1;    
                end else begin
                    comEn <= 0;    
                end
            on:
                if (counter<32) begin
                    dataout <= shiftreg[31];
                    shiftreg <= shiftreg <<1; //shifting reg by 1 and sending MSB to outpt
                    counter <= counter+1;
                end else begin
                    counter <= 0;
                    state <= off;
                    comEn <= 0;    
                    dataout <= 0;
                end

        endcase
                end
        
    end



endmodule