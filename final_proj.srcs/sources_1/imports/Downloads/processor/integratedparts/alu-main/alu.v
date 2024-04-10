module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

    output [31:0] data_result;
    output isNotEqual, isLessThan, overflow;

    // add your code here:
    wire[31:0] o0, o1, o2, o3, o4, o5, o6, o7; 
    

    wire t, oo, ooo;
    assign t=0; 
    wire[31:0] one;
    assign one[31:1]=31'b0;
    assign one[0]=1;
    wire [31:0] p2, p3, pin, gin;

    and_32 and32(o2, data_operandA, data_operandB);
    or_32 or32(o3, data_operandA, data_operandB);

    and_32 Nand32(p2, data_operandA, y0);
    or_32 Nor32(p3, data_operandA, y0);

    mux_2 NPin(pin, ctrl_ALUopcode[0], o3, p3);
    mux_2 NGin(gin, ctrl_ALUopcode[0], o2, p2);

    wire testLT, testNE;
    wire cout;

    sll sll(o4, ctrl_shiftamt, data_operandA);
    sra sra(o5, ctrl_shiftamt, data_operandA);
    cla32 cla32(.S(o0), .isNotEqual(testNE), .isLessThan(testLT), .ovf(c32), .Cout(cout), .A(data_operandA), .B(y0), .Pin(pin), .Gin(gin), .Cin(ctrl_ALUopcode[0]));

    //writing out the neccessary steps to subtract (feels like doubling CPU time just for subtraction...could we do it manually for adding 1 in twos comp?)
    
    wire[31:0] negA, notB, y0, negB;
    no no(notB, data_operandB);
    mux_2 addsub(.out(y0), .select(ctrl_ALUopcode[0]), .in0(data_operandB), .in1(notB));

    //okay this doesnt seem the most effecient but at least this seems to work (but the subtraction has to wait for the addition of 1bit on twos comp.)
    //now the overflow for subtraction doesn't rly work though.
    
    overflowcalc ovf(oo, data_operandA[31], data_operandB[31], o0[31]);

    //figure this out


    
    

    mux_8 control(.out(data_result), .select(ctrl_ALUopcode[2:0]), .in0(o0), .in1(o0), .in2(o2), .in3(o3), .in4(o4), .in5(o5), .in6(o6), .in7(o7));
    //for sll, we need shift1, shift2, shift4, shift8, shift16



    wire subovf, temp, addovf, finovf, c32, ovf4add;

    ovfsub pls(subovf, data_operandA[31], data_operandB[31], o0[31]);

    ovfadd plsadd(ovf4add, data_operandA[31], data_operandB[31], o0[31]);

    assign overflow=finovf;//subtraction

    xor almostovf(temp, c32, o0[31]);
    xor cmonpls(addovf, temp, one); //if oppposite switch above addovf to temp.

    and plusovf(plswork, c32, cout);
    assign finovf=ctrl_ALUopcode[0]? subovf : ovf4add;

    
    
    xor ab0(ne0, data_operandA[0], data_operandB[0]);
    xor ab1(ne1, data_operandA[1], data_operandB[1]);
    xor ab2(ne2, data_operandA[2], data_operandB[2]);
    xor ab3(ne3, data_operandA[3], data_operandB[3]);
    xor ab4(ne4, data_operandA[4], data_operandB[4]);
    xor ab5(ne5, data_operandA[5], data_operandB[5]);
    xor ab6(ne6, data_operandA[6], data_operandB[6]);
    xor ab7(ne7, data_operandA[7], data_operandB[7]);
    xor ab8(ne8, data_operandA[8], data_operandB[8]);
    xor ab9(ne9, data_operandA[9], data_operandB[9]);
    xor ab10(ne10, data_operandA[10], data_operandB[10]);
    xor ab11(ne11, data_operandA[11], data_operandB[11]);
    xor ab12(ne12, data_operandA[12], data_operandB[12]);
    xor ab13(ne13, data_operandA[13], data_operandB[13]);
    xor ab14(ne14, data_operandA[14], data_operandB[14]);
    xor ab15(ne15, data_operandA[15], data_operandB[15]);
    xor ab16(ne16, data_operandA[16], data_operandB[16]);
    xor ab17(ne17, data_operandA[17], data_operandB[17]);
    xor ab18(ne18, data_operandA[18], data_operandB[18]);
    xor ab19(ne19, data_operandA[19], data_operandB[19]);
    xor ab20(ne20, data_operandA[20], data_operandB[20]);
    xor ab21(ne21, data_operandA[21], data_operandB[21]);
    xor ab22(ne22, data_operandA[22], data_operandB[22]);
    xor ab23(ne23, data_operandA[23], data_operandB[23]);
    xor ab24(ne24, data_operandA[24], data_operandB[24]);
    xor ab25(ne25, data_operandA[25], data_operandB[25]);
    xor ab26(ne26, data_operandA[26], data_operandB[26]);
    xor ab27(ne27, data_operandA[27], data_operandB[27]);
    xor ab28(ne28, data_operandA[28], data_operandB[28]);
    xor ab29(ne29, data_operandA[29], data_operandB[29]);
    xor ab30(ne30, data_operandA[30], data_operandB[30]);
    xor ab31(ne31, data_operandA[31], data_operandB[31]);

    //not equal x outputs, add overflow.

    wire isNE, isLT;
    or ne(isNE, ne0, ne1, ne2, ne3, ne4, ne5, ne6, ne7, ne8, ne9, ne10, ne11, ne12, ne13, ne14, ne15, ne16, ne17, ne18, ne19, ne20, ne21, ne22, ne23, ne24, ne25, ne26, ne27, ne28, ne29, ne30, ne31, overflow);


    wire finNE, finLT;

    //Bmsb0 and Amsb1, then LT also
    //
    wire Na, Nb, AltB, AmtB;
    xor notb(Nb, data_operandB[31], one);
    xor nota(Na, data_operandA[31], one);

    and AposBneg(AmtB, data_operandA[31], Nb); //B negative and A positive, then not LT

    xor AnegBpos(AltB, AmtB, one); //NOT(B negative and A positive)

    and NEout(finNE, isNE, AltB);
    and LTout(finLT, isLT, AltB);
    assign isNotEqual=ctrl_ALUopcode[0]? isNE : ctrl_ALUopcode[0];

    xor lt(isLT, o0[31], overflow); //with negatives does this change overflow LT calc?
    assign isLessThan=ctrl_ALUopcode[0]? isLT : ctrl_ALUopcode[0];


endmodule