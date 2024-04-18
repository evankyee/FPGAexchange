module communicate(input clk, input start, input reset, input[31:0] word, output reg dataout, output reg comEn);

reg[7:0] counter=0;
reg[31:0] shiftreg;
reg state=0;

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

reg [31:0] counter3=0;


always @(posedge clk) begin
    if (start==1) begin
        counter3 <= 1;
    end
    else if ((counter3<=1280000) & (counter3>0)) begin
        counter3<=counter3+1;
    end
    else if (start==0 & counter3>1280000) begin
        counter3<=0;
    end
end

parameter on =1, off=0;

reg starter=0;
always @(*) begin
    if (counter3>0) begin
        starter <= 1;
    end 
    else begin
        starter <= 0;
    end

end


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
                if (starter==1) begin
                    shiftreg <= word; //at start we put word into reg we are shifting
                    state <= on;
                    comEn <= 1;    
                end 
            on:
                if (counter<33) begin
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