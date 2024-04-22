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
    wire ready,out1,out2;
  
    dffe_ref flip1(out1,ready,clock,1'b1, 1'b0);
    dffe_ref flip2(out2,out1,clock,1'b1,1'b0);
    assign readyf = out1 & ~out2;
    
    
    
    
    wire [2:0] sectrade;
    wire [3:0] user1,user2;
    wire [7:0] trade1,trade2,trade3;
    assign user1=datainReg[3:0];
    assign user2=datainReg[27:24];
    assign sectrade=datainReg[30:28];
    assign trade1 = datainReg ? (sectrade + 65) : 32;
    assign trade2 = datainReg ? (user1 +65) : 32;
    assign trade3 = datainReg ? (user2 +65) : 32;
    
    assign LED = SW[0] ? trade1 : SW[1] ? trade2 : SW[2]? trade3 :datainReg;
    VGAController vga(.clk(clk),.reset(reset),.hSync(hSync),.vSync(vSync),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B),.ps2_clk(PS2_CLK),.ps2_data(PS2_DATA),.LED(LED),.order(order), .ready(ready),.SW(SW),.trade1(trade1), .trade2(trade2), .trade3(trade3)); 	
    communicate comMod(clock, readyf, reset, order, dataPingOut, comEnOut);
    
    
    reg[31:0] datainReg = 0;
    reg[1:0] seenRDY = 0;
	always @(posedge clock) begin
		if (seenRDY[0] & (seenRDY[0] != seenRDY[1])) begin
			if(receiverdata!=32'b11111111111111111111111111111111)begin
			     datainReg <= receiverdata;
			end
		end 
		seenRDY <= {seenRDY[0], dataRDY};
	end
	//input clk, input reset, input datain, output[31:0] reg data, input comEn, output reg dataRDY
	wire dataRDY;
	wire[31:0] receiverdata;
	wire[7:0] cnt;
	receiver datarec(clock, reset, data_ping_in, receiverdata, comEn, dataRDY,cnt);
    
    


endmodule




