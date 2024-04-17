`timescale 1ns / 1ps
/**
 * 
 * READ THIS DESCRIPTION:
 *
 * This is the Wrapper module that will serve as the header file combining your processor, 
 * RegFile and Memory elements together.
 *
 * This file will be used to generate the bitstream to upload to the FPGA.
 * We have provided a sibling file, Wrapper_tb.v so that you can test your processor's functionality.
 * 
 * We will be using our own separate Wrapper_tb.v to test your code. You are allowed to make changes to the Wrapper files 
 * for your own individual testing, but we expect your final processor.v and memory modules to work with the 
 * provided Wrapper interface.
 * 
 * Refer to Lab 5 documents for detailed instructions on how to interface 
 * with the memory elements. Each imem and dmem modules will take 12-bit 
 * addresses and will allow for storing of 32-bit values at each address. 
 * Each memory module should receive a single clock. At which edges, is 
 * purely a design choice (and thereby up to you). 
 * 
 * You must change line 36 to add the memory file of the test you created using the assembler
 * For example, you would add sample inside of the quotes on line 38 after assembling sample.s
 *
 **/

module WrapperUser (
	output [15:0] LED, 
	input data_ping_in,
	input comEn,
	input clk, 
	input CPU_RESETN,
	input [3:0] SW,
	inout PS2_CLK,
	inout PS2_DATA,
	output comEnOut,
	output dataPingOut,
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B);  // Blue Signal Bits
    
	wire rwe, mwe,reset;
	wire[4:0] rd, rs1, rs2;
	wire[31:0] instAddr, instData, 
		rData, regA, regB,
		memAddr, memDataIn, memDataOut;
	assign reset = ~CPU_RESETN;	
		
    //Clock divider 100 Mhz to 50 Mhz
	reg clock=0;
	reg [2:0]counter;
	always@(posedge clk)begin
	   if(counter <2)
	       counter <= counter +1;
	   else begin
	       counter<=0;
	       clock <= ~clock;
	   end
	end

    //order info from user
    wire [31:0] order;
    assign order = 32'b00010001000000000100000000000001;
    
    wire ready,out1,out2;
  
    dffe_ref flip1(out1,ready,clock,1'b1, 1'b0);
    dffe_ref flip2(out2,out1,clock,1'b1,1'b0);
    assign readyf = out1 & ~out2;
    
    VGAController vga(.clk(clk),.reset(reset),.hSync(hSync),.vSync(vSync),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B),.ps2_clk(PS2_CLK),.ps2_data(PS2_DATA),.LED(LED),.order(), .ready(ready),.SW(SW)); 	
    communicate comMod(clock, readyf, reset, order, dataPingOut, comEnOut);
    
    


endmodule




