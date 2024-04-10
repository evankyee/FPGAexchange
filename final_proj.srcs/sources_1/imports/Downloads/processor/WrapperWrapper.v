`timescale 1ns / 1ps
module WrapperWrapper();

    wire comEn, reset, data_ping_in;
    reg clock;
    assign reset = 0;
    
    Wrapper wrapper(.data_ping_in(data_ping_in), .comEn(comEn), .CPU_RESETN(~reset), .clk(clock));
    communicate communicate(clock, start, reset, word, data_ping_in, comEn);

    reg[31:0] word;
    reg start;
    initial begin
        #10
        word = 32'b00010001000000000100000000000001; //buy vol1, price4
        start = 1;
        #2
        start=0;
        #200
        word = 32'b00010001000000001000000000000001; //buy vol1, price8
        start = 1;
        #2
        start=0;
        #200
        word = 32'b00010001000000000010000000000010; //buy vol2, price2
        start = 1;
        #2
        start=0;
        #200
        word = 32'b10010001000000001010000000000010; //sell vol2, price 10 (should not execute)
        start = 1;
        #2
        start=0;
        #200
        word = 32'b10010001000000000010000000000010; //sell vol2, price 2 (should execute 4 and 8)
        start = 1;
        #2
        start=0;
        #2000
		$finish;
    end

	// Create the clock
	always
		#1 clock = ~clock; 



endmodule