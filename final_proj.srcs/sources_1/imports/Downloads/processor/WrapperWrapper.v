`timescale 1ns / 1ps
module WrapperWrapper();

    wire comEn, reset, data_ping_in;
    reg clock=0;
    assign reset = 0;
    
    Wrapper wrapper(.data_ping_in(data_ping_in), .comEn(comEn), .CPU_RESETN(~reset), .clk(clock));
    communicate communicate(clock, start, reset, word, data_ping_in, comEn);

    reg[31:0] word;
    reg start;
    initial begin
        $dumpfile({"/Users/evanyee/Desktop/Duke/Junior Spring/ECE350/FPGAexchange/final_proj.srcs/sources_1/imports/Downloads/processor/Test Files/exchange.vcd"});
        $dumpvars(0, WrapperWrapper);
        $display("cmon");
        #10
        word = 32'b00010001000000000100000000000001; //sell vol1, price4
        start = 1;
        #2
        start=0;
        #2000
        word = 32'b00010001000000001000000000000001; //sell vol1, price8
        start = 1;
        #2
        start=0;
        #2000
        word = 32'b00010001000000000010000000000010; //sell vol2, price2
        start = 1;
        #2
        start=0;
        #2000
        word = 32'b10010001000000001010000000000010; //buy vol2, price 10 execute
        start = 1;
        #2
        start=0;
        #2000
        word = 32'b10010001000000000010000000000010; //buy vol2, price 2
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