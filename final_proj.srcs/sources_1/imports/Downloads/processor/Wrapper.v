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

module Wrapper (
	input clk,
	output [15:0] LED, 

	input CPU_RESETN,
	input [3:0] SW,
	inout PS2_CLK,
	inout PS2_DATA,
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
	reg clock;
	reg [2:0]counter;
	always@(posedge clk)begin
	   if(counter <2)
	       counter <= counter +1;
	   else begin
	       counter<=0;
	       clock <= ~clock;
	   end
	end


    VGAController vga(.clk(clk),.reset(reset),.hSync(hSync),.vSync(vSync),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B),.ps2_clk(PS2_CLK),.ps2_data(PS2_DATA),.LED(LED),.SW(SW)); 	

	wire data_ping_in;
	assign data_ping_in=0;
	wire comEn;
	assign comEn=0;

	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "";
	
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regAReal), .data_readRegB(regB),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({INSTR_FILE, ".mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));

	wire[31:0] regAReal;
	reg[31:0] datainReg = 0;
	assign regAReal = (rs1==20)? datainReg:regA;
	reg seenRDY = 0;

	always @(posedge clk) begin
		seenRDY = dataRDY;
		if (rwe == 1 & rd == 20) begin
			datainReg <= rData;
		end else if (dataRDY & seenRDY != dataRDY) begin
			datainReg <= receiverdata;
		end

	end
	//input clk, input reset, input datain, output[31:0] reg data, input comEn, output reg dataRDY
	wire dataRDY;
	wire[31:0] receiverdata;
	receiver datarec(clk, CPU_RESETN, data_ping_in, receiverdata, comEn, dataRDY);

	//ALSO NEED TO READ THE DATA CONSTANTLY FROM THE OUTPUT REGS WHEN TRADES R EXECUTED!!!!!!!!!!!!!!!!!!!!!!
	
	// Register File
	regfile RegisterFile(.clock(clock), 
		.ctrl_writeEnable(rwe), .ctrl_reset(reset), 
		.ctrl_writeReg(rd),
		.ctrl_readRegA(rs1), .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regA), .data_readRegB(regB));
						
	// Processor Memory (RAM)
	RAM ProcMem(.clk(clock), 
		.wEn(mwe), 
		.addr(memAddr[11:0]), 
		.dataIn(memDataIn), 
		.dataOut(memDataOut));

always @(posedge clock) begin
			if (mwe) begin
				$display("Wrote %0d into address %0d", memDataIn, memAddr);
			end
end


endmodule




