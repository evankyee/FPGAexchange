module or_32(out, in1, in2);
    input[31:0] in1, in2;
    output[31:0] out;

    or p0(out[0], in1[0], in2[0]);
    or p1(out[1], in1[1], in2[1]);
    or p2(out[2], in1[2], in2[2]);
    or p3(out[3], in1[3], in2[3]);
    or p4(out[4], in1[4], in2[4]);
    or p5(out[5], in1[5], in2[5]);
    or p6(out[6], in1[6], in2[6]);
    or p7(out[7], in1[7], in2[7]);

    or p8(out[8], in1[8], in2[8]);
    or p9(out[9], in1[9], in2[9]);
    or p10(out[10], in1[10], in2[10]);
    or p11(out[11], in1[11], in2[11]);
    or p12(out[12], in1[12], in2[12]);
    or p13(out[13], in1[13], in2[13]);
    or p14(out[14], in1[14], in2[14]);
    or p15(out[15], in1[15], in2[15]);

    or p16(out[16], in1[16], in2[16]);
    or p17(out[17], in1[17], in2[17]);
    or p18(out[18], in1[18], in2[18]);
    or p19(out[19], in1[19], in2[19]);

    or p20(out[20], in1[20], in2[20]);
    or p21(out[21], in1[21], in2[21]);
    or p22(out[22], in1[22], in2[22]);
    or p23(out[23], in1[23], in2[23]);
    or p24(out[24], in1[24], in2[24]);
    or p25(out[25], in1[25], in2[25]);
    or p26(out[26], in1[26], in2[26]);
    or p27(out[27], in1[27], in2[27]);

    or p28(out[28], in1[28], in2[28]);
    or p29(out[29], in1[29], in2[29]);
    or p30(out[30], in1[30], in2[30]);
    or p31(out[31], in1[31], in2[31]);

    
endmodule