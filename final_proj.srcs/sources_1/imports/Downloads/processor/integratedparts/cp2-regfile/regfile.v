module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;

	wire [31:0]regout0, regout1, regout2, regout3, regout4, regout5, regout6, regout7, regout8, regout9, regout10, regout11, regout12, regout13, regout14, regout15, regout16, regout17, regout18, regout19, regout20, regout21, regout22, regout23, regout24, regout25, regout26, regout27, regout28, regout29, regout30, regout31;
	wire enr0, enr1, enr2, enr3, enr4, enr5, enr6, enr7, enr8, enr9, enr10, enr11, enr12, enr13, enr14, enr15, enr16, enr17, enr18, enr19, enr20, enr21, enr22, enr23, enr24, enr25, enr26, enr27, enr28, enr29, enr30, enr31;
	wire [31:0] enw;
	wire enw0, enw1, enw2, enw3, enw4, enw5, enw6, enw7, enw8, enw9, enw10, enw11, enw12, enw13, enw14, enw15, enw16, enw17, enw18, enw19, enw20, enw21, enw22, enw23, enw24, enw25, enw26, enw27, enw28, enw29, enw30, enw31;
	// add your code here

	
	reg32 reg0(regout0, clock, one, data_writeReg, ctrl_writeEnable, enw[0]);
	reg32 reg1(regout1, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[1]);
	reg32 reg2(regout2, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[2]);
	reg32 reg3(regout3, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[3]);
	reg32 reg4(regout4, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[4]);
	reg32 reg5(regout5, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[5]);
	reg32 reg6(regout6, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[6]);
	reg32 reg7(regout7, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[7]);
	reg32 reg8(regout8, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[8]);
	reg32 reg9(regout9, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[9]);
	reg32 reg10(regout10, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[10]);
	reg32 reg11(regout11, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[11]);
	reg32 reg12(regout12, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[12]);
	reg32 reg13(regout13, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[13]);
	reg32 reg14(regout14, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[14]);
	reg32 reg15(regout15, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[15]);
	reg32 reg16(regout16, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[16]);
	reg32 reg17(regout17, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[17]);
	reg32 reg18(regout18, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[18]);
	reg32 reg19(regout19, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[19]);
	reg32 reg20(regout20, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[20]);
	reg32 reg21(regout21, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[21]);
	reg32 reg22(regout22, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[22]);
	reg32 reg23(regout23, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[23]);
	reg32 reg24(regout24, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[24]);
	reg32 reg25(regout25, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[25]);
	reg32 reg26(regout26, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[26]);
	reg32 reg27(regout27, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[27]);
	reg32 reg28(regout28, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[28]);
	reg32 reg29(regout29, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[29]);
	reg32 reg30(regout30, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[30]);
	reg32 reg31(regout31, clock, ctrl_reset, data_writeReg, ctrl_writeEnable, enw[31]);



	wire [31:0] Aout, Bout, aSel, bSel;
	

	tristate A0(Aout, regout0, aSel[0]);
	tristate A1(Aout, regout1, aSel[1]);
	tristate A2(Aout, regout2, aSel[2]);
	tristate A3(Aout, regout3, aSel[3]);
	tristate A4(Aout, regout4, aSel[4]);
	tristate A5(Aout, regout5, aSel[5]);
	tristate A6(Aout, regout6, aSel[6]);
	tristate A7(Aout, regout7, aSel[7]);
	tristate A8(Aout, regout8, aSel[8]);
	tristate A9(Aout, regout9, aSel[9]);
	tristate A10(Aout, regout10, aSel[10]);
	tristate A11(Aout, regout11, aSel[11]);
	tristate A12(Aout, regout12, aSel[12]);
	tristate A13(Aout, regout13, aSel[13]);
	tristate A14(Aout, regout14, aSel[14]);
	tristate A15(Aout, regout15, aSel[15]);
	tristate A16(Aout, regout16, aSel[16]);
	tristate A17(Aout, regout17, aSel[17]);
	tristate A18(Aout, regout18, aSel[18]);
	tristate A19(Aout, regout19, aSel[19]);
	tristate A20(Aout, regout20, aSel[20]);
	tristate A21(Aout, regout21, aSel[21]);
	tristate A22(Aout, regout22, aSel[22]);
	tristate A23(Aout, regout23, aSel[23]);
	tristate A24(Aout, regout24, aSel[24]);
	tristate A25(Aout, regout25, aSel[25]);
	tristate A26(Aout, regout26, aSel[26]);
	tristate A27(Aout, regout27, aSel[27]);
	tristate A28(Aout, regout28, aSel[28]);
	tristate A29(Aout, regout29, aSel[29]);
	tristate A30(Aout, regout30, aSel[30]);
	tristate A31(Aout, regout31, aSel[31]);



	tristate B0(Bout, regout0, bSel[0]);
	tristate B1(Bout, regout1, bSel[1]);
	tristate B2(Bout, regout2, bSel[2]);
	tristate B3(Bout, regout3, bSel[3]);
	tristate B4(Bout, regout4, bSel[4]);
	tristate B5(Bout, regout5, bSel[5]);
	tristate B6(Bout, regout6, bSel[6]);
	tristate B7(Bout, regout7, bSel[7]);
	tristate B8(Bout, regout8, bSel[8]);
	tristate B9(Bout, regout9, bSel[9]);
	tristate B10(Bout, regout10, bSel[10]);
	tristate B11(Bout, regout11, bSel[11]);
	tristate B12(Bout, regout12, bSel[12]);
	tristate B13(Bout, regout13, bSel[13]);
	tristate B14(Bout, regout14, bSel[14]);
	tristate B15(Bout, regout15, bSel[15]);
	tristate B16(Bout, regout16, bSel[16]);
	tristate B17(Bout, regout17, bSel[17]);
	tristate B18(Bout, regout18, bSel[18]);
	tristate B19(Bout, regout19, bSel[19]);
	tristate B20(Bout, regout20, bSel[20]);
	tristate B21(Bout, regout21, bSel[21]);
	tristate B22(Bout, regout22, bSel[22]);
	tristate B23(Bout, regout23, bSel[23]);
	tristate B24(Bout, regout24, bSel[24]);
	tristate B25(Bout, regout25, bSel[25]);
	tristate B26(Bout, regout26, bSel[26]);
	tristate B27(Bout, regout27, bSel[27]);
	tristate B28(Bout, regout28, bSel[28]);
	tristate B29(Bout, regout29, bSel[29]);
	tristate B30(Bout, regout30, bSel[30]);
	tristate B31(Bout, regout31, bSel[31]);


	
	//2 read decoders
	
	wire one;
	assign one = 1;

	decoder writedec(enw, ctrl_writeReg, one);

	decoder Adec(aSel, ctrl_readRegA, one);
	decoder Bdec(bSel, ctrl_readRegB, one);

	assign data_readRegA = Aout;
	assign data_readRegB = Bout;





	//2 32 bit mux's for each of the outputs for readA and readB



	

endmodule
