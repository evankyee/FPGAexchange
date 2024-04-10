module mult(out, A, B, clock, ctrlmult, reset, ready, exception);
    //if enable is 1, restart multiplication and set it equal to zero.
    input clock, ctrlmult, reset;
    output ready, exception;
    input [31:0] A, B;
    output [31:0] out;
    wire clear;
    wire[7:0] count;
    wire[64:0] combined;
    wire one = 1;
    wire zero = 0;
    //A is what we are multiplying (iteratively adding and subtracting)
    

    //my counter made with tffs
    clockcount counter(count, clock, ctrlmult);


    //declaring wires for my register in and out.
    wire[64:0] regout, regin;
    //making a 65 bit wire and giving lower bits equal to B
    assign combined[32:1]=B; //out multiplicand
    assign combined[0]=0; //ghost bit
    assign combined[64:33] = 32'b0;

    //see if we are ctrlmult (which resets multiplication)
    //assign regin=ctrlmult? combined : fin;
    mux65_2 regcontrol(regin, ctrlmult, fin, combined);

    //this is the bit that tracks if we have cycled 16 (modified!!!)
    wire done = count[4];

    //65 bit register
    //out, clock, ctrl_reset, data, ctrlen, writeen
    reg65 boothprod(regout, clock, reset, regin, one, ~done);

    //taking register outputs and separating them
    wire[31:0] upperbooth;
    wire[32:0] lowerbooth;
    assign upperbooth = regout[64:33]; //taking the upper output of our register
    assign lowerbooth = regout[32:0];

    //just declaring opcodes for adding and subtracting using my ALU.
    wire[4:0] addctrl, subctrl;
    assign subctrl[0]=1;
    assign subctrl[4:1] = 4'b0;
    assign addctrl = 5'b0;

    //outputs of ALU operations.
    wire[31:0] preshiftadd, preshiftsub;
    wire aNE, aLT, aOVF, sNE, sLT, sOVF;

    //this decides whether we are sending in our A*2 or A based on if last 2 bits of booth control are equal or not.
    wire[31:0] multiplshift, ALUin;
    assign multiplshift = (A << 1);
    wire aluselect;
    xor (aluselect, boothselect[0], boothselect[1]); //are last 2 bits of booth window equal? if not, aluselect is 1
    mux_2 ALUinselect(ALUin, ~aluselect, A, multiplshift);

    //data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow
    alu adder(upperbooth, ALUin, addctrl, addctrl, preshiftadd, aNE, aLT, qOVF);
    alu subber(upperbooth, ALUin, subctrl, addctrl, preshiftsub, sNE, sLT, sOVF); //We can also just use a mux to determine whether we are adding or subtracting with out ALU Control input. 


    //our control bits for our MUX (3 LSB of lower booth).
    wire[2:0] boothselect;
    assign boothselect = {lowerbooth[2], lowerbooth[1], lowerbooth[0]};
    mux_8 muxbooth(postopbooth, boothselect, upperbooth, preshiftadd, preshiftadd, preshiftadd, preshiftsub, preshiftsub, preshiftsub, upperbooth);

    //assigning out total booth (which has new upper half and same lower half)
    wire[64:0] totalbooth;
    wire[31:0] postopbooth; 
    assign totalbooth[64:33] = postopbooth; 
    assign totalbooth[32:0] = lowerbooth;

    wire[64:0] fin;//what we put back into the register
    rightshift2 shift(fin, totalbooth); //right shift by 2 no matter what.

   
    //output of reg65 into an adder with a controler based on booth.
    //adder and subtracter into mux
    //output of adder into shifter, sra by 1 no matter what. Put this output back into reg65.

    
    assign out = regout[32:1]; //output
    assign ready = done;

    genvar i;
    wire[31:0] signissue;
    generate
        for (i=0; i<32; i=i+1)begin
            xor(signissue[i], regout[64], regout[32+i]); //if all are zero, no sign ovf
        end
    endgenerate
    wire o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31, o32;
    wire i0, i1, i2, i3;
    or (o0, signissue[0], signissue[1]);
    or (o1, signissue[2], o0);
    or (o2, signissue[3], o1);
    or (o3, signissue[4], o2);
    or (o4, signissue[5], o3);
    or (o5, signissue[6], o4);
    or (o6, signissue[7], o5);
    or (o7, signissue[8], o6);
    or (o8, signissue[9], o7);
    or (o9, signissue[10], o8);
    or (o10, signissue[11], o9);
    or (o11, signissue[12], o10);
    or (o12, signissue[13], o11);
    or (o13, signissue[14], o12);
    or (o14, signissue[15], o13);
    or (o15, signissue[16], o14);
    or (o16, signissue[17], o15);
    or (o17, signissue[18], o16);
    or (o18, signissue[19], o17);
    or (o19, signissue[20], o18);
    or (o20, signissue[21], o19);
    or (o21, signissue[22], o20);
    or (o22, signissue[23], o21);
    or (o23, signissue[24], o22);
    or (o24, signissue[25], o23);
    or (o25, signissue[26], o24);
    or (o26, signissue[27], o25);
    or (o27, signissue[28], o26);
    or (o28, signissue[29], o27);
    or (o29, signissue[30], o28);
    or (o30, signissue[31], o29); //30 says if there are any sign disagreements in upper 32 bits.

    xor (i0, A[31], B[31]); //if they are not equal, i0 is one. If equal, i0 is zero
    xor (i1, i0, regout[32]); //if i0 is 1 and regout is 0, i1 is 1. if i0 is 0 and regout 0, i1 zero. 

    or (i2, regout[32], regout[31], regout[30], regout[29], regout[28], regout[27], regout[26], regout[25], regout[24], regout[23], regout[22], regout[21], regout[20], regout[19], regout[18], regout[17], regout[16], regout[15], regout[14], regout[13], regout[12], regout[11], regout[10], regout[9], regout[8], regout[7], regout[6], regout[5], regout[4], regout[3], regout[2], regout[1]);
    and (i3, i2, i1);
    or (exception, i3, o30);

    //assign exception = o30;

endmodule