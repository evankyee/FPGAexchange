
/*
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	//codebegin
    wire one, zero;
    assign one = 1;
    assign zero = 0;
    wire[31:0] nop = 32'b0;


    wire stepfwd;
    assign stepfwd = (pcreg_en & multdivexception & exping2 & (alu_ctrl==5'b00111 | alu_ctrl==5'b00110) & stage3opcode==5'b00000);

    //STAGE1

    wire[31:0] pcreg_out, pcreg_in, pciter;
    wire pcreg_en;

    //CONSIDERING JUST PAUSING ALL REGS DURING
    assign pcreg_en=(~((divactive | multactive))|(data_resultRDY & ~datacheck)); //&(~stallping)
    wire[31:0] imem_in, imem_out;
    reg32 pclatch(.out(pcreg_out), .clk(~clock), .controlres(reset), .dat(pcreg_in), .ctrlen((pcreg_en & ~exceping & ~twodiv & ~twomult) | stepfwd), .writeen(~stallping));
    
    wire pcNE, pcLT, pcOVF;
    wire[31:0] addone;
    assign addone = pcreg_en?32'd1:32'b00000000000000000000000000000000;
    alu adder(pcreg_out, 32'd1, 5'b00000, 5'b00000, pciter, pcNE, pcLT, pcOVF);
    //data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow
    
    wire[31:0] FDpcout, FDpcin, FDirout, FDirin, pcelse;
    wire pcctrl;
    assign FDpcin = pciter;
    assign address_imem = pcreg_out;
    //USING BRANCHES OR HAZARD TO FLUSH ISNS!
    assign FDirin = (branchsel | twodiv | twomult)?32'b0:q_imem; //IMEM I/O ()
    assign pcreg_in = branchsel? pcelse: pciter; //MUX FOR WHAT GOES INTO PCREGIN

 

    doublereg32 FDlatch(FDirout, FDpcout, ~clock, reset, FDirin, FDpcin, (((pcreg_en & ~exceping) | stepfwd) & ~stallping), ~stallping);
    


    //STAGE2

    wire[4:0] opcode;
    assign opcode = FDirout[31:27];

    wire[1:0] isn_type;

    wire iand0, iand1, iand2, iand3, iand4, jiand0, jiand1, jiand2, jiand3;

    //isn type definitions
    wire rtype, itype, jitype, jiitype;
    and r_and(rtype, ~opcode[0], ~opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);

    or i_or(itype, iand0, iand1, iand2, iand3, iand4);
    and i_and0(iand0, opcode[0], ~opcode[1], opcode[2], ~opcode[3], ~opcode[4]);
    and i_and1(iand1, opcode[0], opcode[1], opcode[2], ~opcode[3], ~opcode[4]);
    and i_and2(iand2, ~opcode[0], ~opcode[1], ~opcode[2], opcode[3], ~opcode[4]);
    and i_and3(iand3, ~opcode[0], opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
    and i_and4(iand4, ~opcode[0], opcode[1], opcode[2], ~opcode[3], ~opcode[4]);

    or ji_or(jitype, jiand0, jiand1, jiand2, jiand3);
    and ji_and0(jiand0, opcode[0], ~opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
    and ji_and1(jiand1, opcode[0], opcode[1], ~opcode[2], ~opcode[3], ~opcode[4]);
    and ji_and2(jiand2, ~opcode[0], opcode[1], opcode[2], ~opcode[3], opcode[4]);
    and ji_and3(jiand3, opcode[0], ~opcode[1], opcode[2], ~opcode[3], opcode[4]);

    and jii_and(jiitype, ~opcode[0], ~opcode[1], opcode[2], ~opcode[3], ~opcode[4]);

    wire[4:0] rd;
    assign ctrl_readRegA = ((itype | rtype) ? FDirout[21:17]:zero);   //rs1
    assign ctrl_readRegB =  D_bex? 5'b11110:((itype|jiitype)?FDirout[26:22]:((rtype) ? FDirout[16:12]:zero)); //rs2 RD for JR RD is in B!!! SO bypassing needs B
    assign ctrl_writeEnable = (rtype5 | iand05 | iand25 |jiand15 | activeexception|setx); //when we are writing to a register. ((INCLUDING JAL))



    //RD=B for I type, RT=B for R type
    //RS=A for both R and I type.
    

    wire[31:0] DXpcout, DXpcin, DXirout, DXirin, DXAout, DXBout;

    assign DXpcin=FDpcout;
    assign DXirin=(branchsel)?32'b0:FDirout;

    doublereg32 DXlatch(DXirout, DXpcout, ~clock, reset, DXirin, DXpcin, (((pcreg_en & ~exceping) | stepfwd) & ~stallping), ~stallping);
    doublereg32 DXAB(DXAout, DXBout, ~clock, reset, data_readRegA, data_readRegB, (((pcreg_en & ~exceping) | stepfwd) & ~stallping), ~stallping);
    
    wire D_bex;
    assign D_bex = opcode==5'b10110; //if D_bex, then bex operation and put r30 data in Bout to see if zero.




    //STAGE3
    //R30 is Rstatus, so we need to wren when we have diff data exceptions and change the data we have going in;

    wire rtype3, itype3, jitype3, jiitype3;
    wire[4:0] stage3opcode;
    assign stage3opcode=DXirout[31:27];

    wire iand03, iand13, iand23, iand33, iand43, jiand03, jiand13, jiand23, jiand33;

    and r_and3(rtype3, ~stage3opcode[0], ~stage3opcode[1], ~stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);

    or i_or3(itype3, iand03, iand13, iand23, iand33, iand43);
    and i_and03(iand03, stage3opcode[0], ~stage3opcode[1], stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);
    and i_and13(iand13, stage3opcode[0], stage3opcode[1], stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);
    and i_and23(iand23, ~stage3opcode[0], ~stage3opcode[1], ~stage3opcode[2], stage3opcode[3], ~stage3opcode[4]);
    and i_and33(iand33, ~stage3opcode[0], stage3opcode[1], ~stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);
    and i_and43(iand43, ~stage3opcode[0], stage3opcode[1], stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);

    or ji_or3(jitype3, jiand03, jiand13, jiand23, jiand33);
    and ji_and03(jiand03, stage3opcode[0], ~stage3opcode[1], ~stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);
    and ji_and13(jiand13, stage3opcode[0], stage3opcode[1], ~stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);
    and ji_and23(jiand23, ~stage3opcode[0], stage3opcode[1], stage3opcode[2], ~stage3opcode[3], stage3opcode[4]);
    and ji_and33(jiand33, stage3opcode[0], ~stage3opcode[1], stage3opcode[2], ~stage3opcode[3], stage3opcode[4]);

    and jii_and3(jiitype3, ~stage3opcode[0], ~stage3opcode[1], stage3opcode[2], ~stage3opcode[3], ~stage3opcode[4]);

    wire[16:0] intermediate;
    wire[31:0] signextend;
    assign intermediate = DXirout[16:0];
    assign signextend[16:0] = intermediate;
    assign signextend[31:17]=intermediate[16]? 15'b111111111111111:15'b000000000000000;


    wire[31:0] aluA, aluB, aluresult;
    wire[4:0] alu_ctrl, alushiftamt;
    wire aluLT, aluNE, ovf;

    assign alu_ctrl=branchsel?5'b00000:(itype3?5'b00000:DXirout[6:2]);
    assign alushiftamt=DXirout[11:7];

    

    
    wire Atop, Btop, Amid, Bmid;
    assign Atop = (bypassA==2'b00);
    assign Btop = (bypassB==2'b00);
    assign Amid = (bypassA==2'b01);
    assign Bmid = (bypassB==2'b01);
    /*
    assign Atop = (bypassA==2'b00 & (rtype3|itype3) & (rtype4|iand24|iand04) & DXirout!=(32'b0) & (pcreg_en | multping | divping));
    assign Btop = (bypassB==2'b00 & (rtype3 & alu_ctrl!=5'b00100 & alu_ctrl!=5'b00101) & (rtype4|iand24|iand04) & DXirout!=(32'b0) & (pcreg_en | multping | divping));
    assign Amid = (bypassA==2'b01 & (rtype3|itype3) & (rtype5|iand25|iand05) & DXirout!=(32'b0) & (pcreg_en | multping | divping));
    assign Bmid = (bypassB==2'b01 & (rtype3 & alu_ctrl!=5'b00100 & alu_ctrl!=5'b00101) & (rtype5|iand25|iand05) & DXirout!=(32'b0) & (pcreg_en | multping | divping));
    */
    assign aluA = (Atop & XM_irout!=32'b00000000000000000000000000000000)?XM_o_out:((Amid & MW_irout!=32'b00000000000000000000000000000000)?datawriteReg1:DXAout);
    //assign aluB= (Btop & XM_irout!=32'b00000000000000000000000000000000)?XM_o_out:((itype3?signextend:DXBout)); //NOT CORRECT VALUE!
    assign aluB= (bex & bexB!=2'b00)?bexExtend:
                 (Btop & XM_irout!=32'b00000000000000000000000000000000)?XM_o_out:((Bmid & MW_irout!=32'b00000000000000000000000000000000)?datawriteReg2:((itype3&stage3opcode!=5'b00010&stage3opcode!=5'b00110)?signextend:DXBout));

    wire[31:0] bexExtend;
    assign bexExtend[26:0] = (bexB==2'b11)?XM_irout[26:0]:((bexB==2'b10)?MW_irout[26:0]:DXBout);
    assign bexExtend[31:27] = bexExtend[26]?5'b11111:5'b00000;

    //assign aluA = DXAout;
    //assign aluB = (itype3?signextend:DXBout);


    alu mainalu(aluA, aluB, alu_ctrl, alushiftamt, aluresult, aluNE, aluLT, ovf);
    //data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow

    wire[31:0] branchB, branchout, branchA;
    wire templt, tempne, tempovf, templt2, tempne2, tempovf2;
    assign branchB=(stage3opcode==5'b00001|stage3opcode==5'b00100|stage3opcode==5'b00011|bex)?32'b00000000000000000000000000000000: DXpcout; //whether we use old PC in new PC (j, jal, jr)
    assign branchA=(jitype3|bex)?branchAextend:((itype3)?signextend:32'b00000000000000000000000000000000); //whether using target or signextend (bne and blt) or zero if doing JII
    
    wire[31:0] branchAextend, branchplus1;
    assign branchAextend[26:0]=DXirout[26:0];
    assign branchAextend[31:27]=(DXirout[26])?5'b11111:5'b00000;

    wire[31:0] datawriteReg1, datawriteReg2;

    assign datawriteReg1=setx? MWtargextend:(exceping? exceptiondat:(jiand15? MW_pcout:(regDatSel? MW_d_out : MW_o_out)));
    assign datawriteReg2=setx? MWtargextend:(exceping? exceptiondat:(jiand15? MW_pcout:(regDatSel? MW_d_out : MW_o_out)));
    

   

    //when we have jal, writeregenable and 
    
    alu branchalu(branchA, branchB, 5'b00000, 5'b00000, branchout, templt, tempne, tempovf); //PC COUNTER BRANCHING (CHOOSING WHETHER ADDING 0 to SIGN EXTEND OR PC)
   
    assign pcelse =(stage3opcode==5'b00100)? aluB:branchout;
    wire branchsel;
    assign branchsel= (stage3opcode==5'b00001)|(stage3opcode==5'b00011)|(stage3opcode==5'b00100)|(stage3opcode==5'b00010 & BneA)|(stage3opcode==5'b00110 & BltA)|(bex & (aluB!=32'b00000000000000000000000000000000));
    //need to check if rd=rs or less than too
    

    //CHECKING IF RD<RS and if NE
    wire BneA, BltA, ABovf;
    wire[31:0] ABout, XM_pcout;
    alu regbranch(aluB, aluA, 5'b00001, 5'b00000, ABout, BneA, BltA, ABovf);

    wire[31:0] XM_o_out, XM_b_out, XM_o_in, XM_b_in, XM_irout, XM_irin;
    assign XM_o_in = (exceping|exping2)?32'b00000000000000000000000000000000:((multactive | divactive)? multdivresult:aluresult);
    assign XM_b_in = DXBout;
    assign XM_irin=pcreg_en?DXirout:32'b0;

    doublereg32 XMobLatch(XM_o_out, XM_b_out, ~clock, reset, XM_o_in, XM_b_in, ((pcreg_en & ~exceping) | stepfwd), one);
    reg32 XM_IR(XM_irout, ~clock, reset, XM_irin, ((pcreg_en & ~exceping) | stepfwd), one);
    reg32 XM_PC(XM_pcout, ~clock, reset, DXpcout, ((pcreg_en & ~exceping) | stepfwd), one);
    dffe_ref EXpt1(xmEX, activeexception, ~clock, one, zero);

    dffe_ref EXpt2(mwEX, xmEX, ~clock, one, zero);

    dffe_ref EXpt3(EXzero, mwEX, ~clock, one, zero);

    wire xmEX, mwEX, EXzero;


    //EXCEPTION LOGIC:
    wire[31:0] exceptiondat;
    assign exceptiondat = divexp?32'b00000000000000000000000000000101:(multexp?32'b00000000000000000000000000000100:((iand03 & ovf)? 32'b00000000000000000000000000000010: ((rtype3 & DXirout[6:2]==5'b00000 & ovf)? 32'd1 : ((rtype3 & DXirout[6:2]==5'b00001 & ovf)? 32'b00000000000000000000000000000011 : 32'b0)))); //if ovf and add/sub types, assign rstatus

    wire activeexeption;
    assign activeexception = (iand03 & ovf) | (rtype3 & DXirout[6:2]==5'b00000 & ovf) | (rtype3 & DXirout[6:2]==5'b00001 & ovf) | ((multactive | divactive) &multdivexception & data_resultRDY);

    wire multdivexception;
    assign multdivexception = multdiv_ex; //TEMPORARY UNTIL FINISH MULTDIV (NO EXCPETIONS)!!!!!!!!!!!!!!

    wire bex, setx;
    assign bex = stage3opcode==5'b10110;
    assign setx = stage5opcode==5'b10101;

    wire multexp, divexp;

    assign multexp=(multactive & multdiv_ex & data_resultRDY);
    assign divexp=(divactive & multdiv_ex & data_resultRDY);

    wire exceptcheck;
    dffe_ref except(exceptcheck, activeexception, ~clock, one, zero);

    wire exceping;
    assign exceping = (pcreg_in==32'd1 | pcreg_in==32'd2)?1'b0:(activeexception & ~exceptcheck);

    wire afterexping, exping2;
    dffe_ref except2(afterexping, exceping, ~clock, one, zero);
    
    assign exping2=(pcreg_in==32'd1 | pcreg_in==32'd2)?1'b0:(exceping & ~afterexping);






    //MULT INTERLOCKING (rs in A, rt in B)_______________________________________________________________

    //on mult, we need to send in 8 nops, for div we need to send 32 nops!!!!!!

    wire multactive, divactive, multping, divping, data_resultRDY;
    assign multactive = (DXirout[6:2]==5'b00110 & DXirout[31:27]==5'b00000);
    assign divactive = (DXirout[6:2]==5'b00111 & DXirout[31:27]==5'b00000);

    //SKETCHY!!!!!!!
    assign multping = (multactive & clock & ~multcheck); //WE WANT TO PING ONCE FOR CTRLMULT WHEN WE START MULT (so this is only when dataready (not currenlty perfomring multdiv))
    assign divping = (divactive & clock & ~divcheck);
    //for first multdiv, we dont have any dataresultready, need to see if we've never seen one before
    wire currmultdiv;
    dffe_ref multact(currmultdiv, (address_imem==32'b00000000000000000000000000000000), ~clock, (address_imem==32'b00000000000000000000000000000000 | (multactive | divactive)), zero); //after first dataresultready, should be zero
    //q, d, clk, en, clr

    multdiv mult(inmultA, inmultB, multping, divping, ~clock, multdivresult, multdiv_ex, data_resultRDY);
//    wire multdiv_ex;
//    assign multdiv_ex = 1'b0;
//    assign data_resultRDY=1'b0;
    
    wire[31:0] multA, multB, inmultA, inmultB;

    assign inmultA=(multping | divping)?aluA:multA;
    assign inmultB=(multping | divping)?aluB:multB;


    reg32 aluAreg(multA, ~clock, zero, aluA, (multping | divping), one);
    reg32 aluBreg(multB, ~clock, zero, aluB, (multping | divping), one);

    wire[31:0] multdivresult, storedmultdiv;
    reg32 multdivstore(storedmultdiv, ~clock, zero, multdivresult, data_resultRDY, one); //writeenabled on dataRDY
    
    
    //(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);

    wire divpingreset;
    assign divpingreset = data_resultRDY & ~clock & divactive & ~pcreg_en ;

    dffe_ref cmon(multcheck, multactive, ~clock, one, zero);
    dffe_ref cmon2(divcheck, divactive, ~clock, one, zero);
    dffe_ref cmon3(datacheck, data_resultRDY, ~clock, one, zero);

    wire[7:0] divcount, multcount;
    clockcount counterd(divcount, clock, divping);
    clockcount counterm(multcount, clock, multping);


    dffe_ref dping(dpingcheck, divping, ~clock, one, zero);

    wire divp2, multp2;

    assign divp2=(divactive & XMdiv & clock & divcount==7'b0100100); //sketch

    assign XMmult = (XM_irout[6:2]==5'b00110 & XM_irout[31:27]==5'b00000);
    assign XMdiv = (XM_irout[6:2]==5'b00111 & XM_irout[31:27]==5'b00000);

    wire FDinmult, FDindiv, DXinmult, DXindiv;
    assign FDinmult=(q_imem[6:2]==5'b00110 & q_imem[31:27]==5'b00000);
    assign FDindiv=(q_imem[6:2]==5'b00111 & q_imem[31:27]==5'b00000);

    assign DXinmult = (DXirin[6:2]==5'b00110 & DXirin[31:27]==5'b00000);
    assign DXindiv = (DXirin[6:2]==5'b00111 & DXirin[31:27]==5'b00000);

    wire twodiv, twomult;

    assign twodiv = DXindiv & FDindiv;
    assign twomult = DXinmult & FDinmult;


    


    //STAGE4

    assign address_dmem = XM_o_out; //BYPASS_DMEM


    assign data=(dmembypass & (rtype5|itype5))?data_writeReg:XM_b_out;


    wire[4:0] stage4opcode;
    assign stage4opcode=XM_irout[31:27];
    and wrenand(wren, ~stage4opcode[4], ~stage4opcode[3], stage4opcode[2], stage4opcode[1], stage4opcode[0]);


    wire[31:0] MW_o_out, MW_d_out, MW_o_in, MW_d_in, MW_irout, MW_irin, MW_pcout;
    assign MW_o_in = XM_o_out;
    assign MW_d_in = q_dmem;
    assign MW_irin=XM_irout;


   

    wire rtype4, itype4, jitype4, jiitype4;
    wire iand04, iand14, iand24, iand34, iand44, jiand04, jiand14, jiand24, jiand34;

    and r_and4(rtype4, ~stage4opcode[0], ~stage4opcode[1], ~stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);

    or i_or4(itype4, iand04, iand14, iand24, iand34, iand44);
    and i_and04(iand04, stage4opcode[0], ~stage4opcode[1], stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);
    and i_and14(iand14, stage4opcode[0], stage4opcode[1], stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);
    and i_and24(iand24, ~stage4opcode[0], ~stage4opcode[1], ~stage4opcode[2], stage4opcode[3], ~stage4opcode[4]);
    and i_and34(iand34, ~stage4opcode[0], stage4opcode[1], ~stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);
    and i_and44(iand44, ~stage4opcode[0], stage4opcode[1], stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);

    or ji_or4(jitype4, jiand04, jiand14, jiand24, jiand34);
    and ji_and04(jiand04, stage4opcode[0], ~stage4opcode[1], ~stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);
    and ji_and14(jiand14, stage4opcode[0], stage4opcode[1], ~stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);
    and ji_and24(jiand24, ~stage4opcode[0], stage4opcode[1], stage4opcode[2], ~stage4opcode[3], stage4opcode[4]);
    and ji_and34(jiand34, stage4opcode[0], ~stage4opcode[1], stage4opcode[2], ~stage4opcode[3], stage4opcode[4]);

    and jii_and4(jiitype4, ~stage4opcode[0], ~stage4opcode[1], stage4opcode[2], ~stage4opcode[3], ~stage4opcode[4]);




    //STAGE5
    
    doublereg32 MWobLatch(MW_o_out, MW_d_out, ~clock, reset, MW_o_in, MW_d_in, ((pcreg_en & ~exceping) | stepfwd), one);
    reg32 MW_IR(MW_irout, ~clock, reset, MW_irin, ((pcreg_en & ~exceping) | stepfwd), one);
    reg32 MW_PC(MW_pcout, ~clock, reset, XM_pcout, ((pcreg_en & ~exceping) | stepfwd), one);

    wire regDatSel;
    and regseland(regDatSel, ~stage5opcode[4], stage5opcode[3], ~stage5opcode[2], ~stage5opcode[1], ~stage5opcode[0]); //LOAD WORD
    assign data_writeReg = setx? MWtargextend:(exceping? exceptiondat:((EXzero&mwEX)?nop:(jiand15? MW_pcout:(regDatSel? MW_d_out : MW_o_out)))); //sending regdata mux?? what is select bit????
    assign ctrl_writeReg = (exceping | setx) ? 5'b11110 : (jiand15? 5'b11111: MW_irout[26:22]); //exception or setx =30, jal=31, elsefromIR


    wire[31:0] MWtargextend;
    assign MWtargextend[26:0]=MW_irout[26:0];
    assign MWtargextend[31:27]=MW_irout[26]?5'b11111:5'b00000;

    wire[4:0] stage5opcode;
    assign stage5opcode = MW_irout[31:27];

    wire rtype5, itype5, jitype5, jiitype5;
    wire iand05, iand15, iand25, iand35, iand45, jiand05, jiand15, jiand25, jiand35;

    and r_and5(rtype5, ~stage5opcode[0], ~stage5opcode[1], ~stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);

    or i_or5(itype5, iand05, iand15, iand25, iand35, iand45);
    and i_and05(iand05, stage5opcode[0], ~stage5opcode[1], stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);
    and i_and15(iand15, stage5opcode[0], stage5opcode[1], stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);
    and i_and25(iand25, ~stage5opcode[0], ~stage5opcode[1], ~stage5opcode[2], stage5opcode[3], ~stage5opcode[4]);
    and i_and35(iand35, ~stage5opcode[0], stage5opcode[1], ~stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);
    and i_and45(iand45, ~stage5opcode[0], stage5opcode[1], stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);

    or ji_or5(jitype5, jiand05, jiand15, jiand25, jiand35);
    and ji_and05(jiand05, stage5opcode[0], ~stage5opcode[1], ~stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);
    and ji_and15(jiand15, stage5opcode[0], stage5opcode[1], ~stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);
    and ji_and25(jiand25, ~stage5opcode[0], stage5opcode[1], stage5opcode[2], ~stage5opcode[3], stage5opcode[4]);
    and ji_and35(jiand35, stage5opcode[0], ~stage5opcode[1], stage5opcode[2], ~stage5opcode[3], stage5opcode[4]);

    and jii_and5(jiitype5, ~stage5opcode[0], ~stage5opcode[1], stage5opcode[2], ~stage5opcode[3], ~stage5opcode[4]);




    //hazard aversion (send noops when we detect hazard)
    wire stall, dmembypass, bypass5, stallcheck, stallping;
    wire[1:0] bypassA, bypassB, bexB;
    hazard hazbypass(stall, dmembypass, bypassA, bypassB, bexB, bypass5, FDirout, DXirout, XM_irout, MW_irout, rtype3, itype3, jitype3, jiitype3, rtype5, itype5, jitype5, jiitype5, rtype, itype, jitype, jiitype);
    //stall, dmembypass, bypassA, bypassB, bypass5, FDIRout, DXIRout, XMIRout, MWIRout
    dffe_ref staller(stallcheck, stall, ~clock, one, zero);//will assign stallping high for one cycle, then will go low again. 

    assign stallping = ~stallcheck & stall;



    //bypass control (mux's for each spot.)
    





	//endcode

endmodule
