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

module WrapperBook (
	output [15:0] LED, 
	input data_ping_in,
	input comEn,
	input clk, 
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

    VGAControllerBook vga2(.clk(clk),.reset(reset),.hSync(hSync),.vSync(vSync),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B)); 	

	//okay so heads of sell and buy are in reg 26 and reg 25


	// ADD YOUR MEMORY FILE HERE
	localparam INSTR_FILE = "exchange";
	
	// Main Processing Unit
	processor CPU(.clock(clock), .reset(reset), 
								
		// ROM
		.address_imem(instAddr), .q_imem(instData),
									
		// Regfile
		.ctrl_writeEnable(rwe),     .ctrl_writeReg(rd),
		.ctrl_readRegA(rs1),     .ctrl_readRegB(rs2), 
		.data_writeReg(rData), .data_readRegA(regAReal), .data_readRegB(regBReal),
									
		// RAM
		.wren(mwe), .address_dmem(memAddr), 
		.data(memDataIn), .q_dmem(memDataOut)); 
	
	// Instruction Memory (ROM)
	ROM #(.MEMFILE({"exchange.mem"}))
	InstMem(.clk(clock), 
		.addr(instAddr[11:0]), 
		.dataOut(instData));

	//GENERATE 16 32 bit regs to store all the buy and sell heads!
	reg[31:0] buyA=0;
	reg[31:0] buyB=0;
	reg[31:0] buyC=0;
	reg[31:0] buyD=0;
	reg[31:0] buyE=0;
	reg[31:0] buyF=0;
	reg[31:0] buyG=0;
	reg[31:0] buyH=0;

	reg[31:0] sellA=0;
	reg[31:0] sellB=0;
	reg[31:0] sellC=0;
	reg[31:0] sellD=0;
	reg[31:0] sellE=0;
	reg[31:0] sellF=0;
	reg[31:0] sellG=0;
	reg[31:0] sellH=0;
 	//nvmnvm
	always @ (posedge clock) begin
		if (mwe==1 & memAddr==32) begin //BUYA
			buyA <= memDataIn;
		end 
		else if (mwe==1 & memAddr==33) begin //BUYB
			buyB <= memDataIn;
		end 
		else if (mwe==1 & memAddr==34) begin //BUYC
			buyC <= memDataIn;
		end 
		else if (mwe==1 & memAddr==35) begin //BUYD
			buyD <= memDataIn;
		end 
		else if (mwe==1 & memAddr==36) begin //BUYE
			buyE <= memDataIn;
		end 
		else if (mwe==1 & memAddr==37) begin //BUYF
			buyF <= memDataIn;
		end 
		else if (mwe==1 & memAddr==38) begin //BUYG
			buyG <= memDataIn;
		end 
		else if (mwe==1 & memAddr==39) begin //BUYH
			buyH <= memDataIn;
		end 
		else if (mwe==1 & memAddr==40) begin //SELLA
			sellA <= memDataIn;
		end 
		else if (mwe==1 & memAddr==41) begin //SELLB
			sellB <= memDataIn;
		end 
		else if (mwe==1 & memAddr==42) begin //SELLC
			sellC <= memDataIn;
		end 
		else if (mwe==1 & memAddr==43) begin //SELLD
			sellD <= memDataIn;
		end 
		else if (mwe==1 & memAddr==44) begin //SELLE
			sellE <= memDataIn;
		end 
		else if (mwe==1 & memAddr==45) begin //SELLF
			sellF <= memDataIn;
		end 
		else if (mwe==1 & memAddr==46) begin //SELLG
			sellG <= memDataIn;
		end 
		else if (mwe==1 & memAddr==47) begin //SELLH
			sellH <= memDataIn;
		end 
	end
	/*
#32 1 Head Buy Val
#33 2 Head Buy Val
#34 3 Head Buy Val
#35 4 Head Buy Val
#36 5 Head Buy Val
#37 6 Head Buy Val
#38 7 Head Buy Val
#39 8 Head Buy Val

#40 1 Head Sell Val
#41 2 Head Sell Val
#42 3 Head Sell Val
#43 4 Head Sell Val
#44 5 Head Sell Val
#45 6 Head Sell Val
#46 7 Head Sell Val
#47 8 Head Sell Val

	*/


	wire[31:0] regAReal, regBReal;
	reg[31:0] datainReg = 0;
	assign regAReal = (rs1==20)? datainReg:regA;
	assign regBReal = (rs2==20)? datainReg:regB;
	reg[1:0] seenRDY = 0;
	always @(posedge clock) begin
		if (seenRDY[0] & (seenRDY[0] != seenRDY[1])) begin
			datainReg <= receiverdata;
		end else if (rwe == 1 & rd == 20) begin
			datainReg <= rData;
		end
		seenRDY <= {seenRDY[0], dataRDY};
	end
	//input clk, input reset, input datain, output[31:0] reg data, input comEn, output reg dataRDY
	wire dataRDY;
	wire[31:0] receiverdata;
	wire[7:0] cnt;
	receiver datarec(clock, reset, data_ping_in, receiverdata, comEn, dataRDY,cnt);

	//ALSO NEED TO READ THE DATA CONSTANTLY FROM THE OUTPUT REGS WHEN TRADES R EXECUTED!!!!!!!!!!!!!!!!!!!!!!
	//assign LED = SW[0] ? {seenRDY, dataRDY, (seenRDY[0] & (seenRDY[0] != seenRDY[1]))} : SW[1] ? receiverdata : SW[2] ? cnt : datainReg;
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
assign LED = poop;
reg [11:0] poop=0;

always @(posedge clock) begin
        $fdisplay("Hello");
			if (mwe & memDataIn!=0) begin
				poop <= memDataIn;
			end
			if (rwe && rd != 0) begin
				$display("Wrote %0d into register %0d", rData, rd);
			end
end


endmodule




