module no(out, in1);
    input[31:0] in1;
    output[31:0] out;
    wire in2;
    assign in2=1;

    xor p0(out[0], in1[0], in2);
    xor p1(out[1], in1[1], in2);
    xor p2(out[2], in1[2], in2);
    xor p3(out[3], in1[3], in2);
    xor p4(out[4], in1[4], in2);
    xor p5(out[5], in1[5], in2);
    xor p6(out[6], in1[6], in2);
    xor p7(out[7], in1[7], in2);

    xor p8(out[8], in1[8], in2);
    xor p9(out[9], in1[9], in2);
    xor p10(out[10], in1[10], in2);
    xor p11(out[11], in1[11], in2);
    xor p12(out[12], in1[12], in2);
    xor p13(out[13], in1[13], in2);
    xor p14(out[14], in1[14], in2);
    xor p15(out[15], in1[15], in2);

    xor p16(out[16], in1[16], in2);
    xor p17(out[17], in1[17], in2);
    xor p18(out[18], in1[18], in2);
    xor p19(out[19], in1[19], in2);

    xor p20(out[20], in1[20], in2);
    xor p21(out[21], in1[21], in2);
    xor p22(out[22], in1[22], in2);
    xor p23(out[23], in1[23], in2);
    xor p24(out[24], in1[24], in2);
    xor p25(out[25], in1[25], in2);
    xor p26(out[26], in1[26], in2);
    xor p27(out[27], in1[27], in2);

    xor p28(out[28], in1[28], in2);
    xor p29(out[29], in1[29], in2);
    xor p30(out[30], in1[30], in2);
    xor p31(out[31], in1[31], in2);

    
endmodule