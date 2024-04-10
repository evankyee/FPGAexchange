module cla(S, Cout, G, P, Pin, Gin, A, B, Cin);
    
    input[7:0] A, B, Pin, Gin;
    input Cin;

    output G, P, Cout;
    output[7:0] S;

    wire w0, w1, w2, w3, w4, w5, w6;
    wire w7, w8;

    wire c1, c2, c3, c4, c5, c6, c7, c8;

    wire s0, s1, s2, s3, s4, s5, s6, s7;

    //we have all the little g's and little p's from our Pin and Gin inputs that come from our AND and OR function.

    and P0(P, Pin[0], Pin[1], Pin[2], Pin[3], Pin[4], Pin[5], Pin[6], Pin[7]);

    and f0(w0, Pin[1], Pin[2], Pin[3], Pin[4], Pin[5], Pin[6], Pin[7], Gin[0]);
    and f1(w1, Pin[2], Pin[3], Pin[4], Pin[5], Pin[6], Pin[7], Gin[1]);
    and f2(w2, Pin[3], Pin[4], Pin[5], Pin[6], Pin[7], Gin[2]);
    and f3(w3, Pin[4], Pin[5], Pin[6], Pin[7], Gin[3]);
    and f4(w4, Pin[5], Pin[6], Pin[7], Gin[4]);
    and f5(w5, Pin[6], Pin[7], Gin[5]);
    and f6(w6, Pin[7], Gin[6]);

    or G0(G, Gin[7], w0, w1, w2, w3, w4, w5, w6);

    //c8 ?? with the big P and G, or am i doing this wrong somehow

    //should i just do the individual outputs right now?
    //
    wire m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16, m17, m18, m19, m20, m21, m22, m23, m24, m25, m26, m27, m28, m29, m30, m31, m32, m33, m34, m35;

    //c1
    and tc1_1(m0, Pin[0], Cin);
    or cc1(c1, m0, Gin[0]);

    //c2
    and tc2_1(m1, Pin[1], Pin[0], Cin);
    and tc2_2(m2, Pin[1], Gin[0]);
    or cc2(c2, Gin[1], m1, m2);

    // c3
    and tc3_1(m3, Pin[2], Pin[1], Pin[0], Cin);
    and tc3_2(m4, Pin[2], Pin[1], Gin[0]);
    and tc3_3(m5, Pin[2], Gin[1]);
    or cc3(c3, Gin[2], m3, m4, m5);

    // c4
    and tc4_1(m6, Pin[3], Pin[2], Pin[1], Pin[0], Cin);
    and tc4_2(m7, Pin[3], Pin[2], Pin[1], Gin[0]);
    and tc4_3(m8, Pin[3], Pin[2], Gin[1]);
    and tc4_4(m9, Pin[3], Gin[2]);
    or cc4(c4, Gin[3], m6, m7, m8, m9);

    // c5
    and tc5_1(m10, Pin[4], Pin[3], Pin[2], Pin[1], Pin[0], Cin);
    and tc5_2(m11, Pin[4], Pin[3], Pin[2], Pin[1], Gin[0]);
    and tc5_3(m12, Pin[4], Pin[3], Pin[2], Gin[1]);
    and tc5_4(m13, Pin[4], Pin[3], Gin[2]);
    and tc5_5(m14, Pin[4], Gin[3]);
    or cc5(c5, Gin[4], m10, m11, m12, m13, m14);

    // c6
    and tc6_1(m15, Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Pin[0], Cin);
    and tc6_2(m16, Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Gin[0]);
    and tc6_3(m17, Pin[5], Pin[4], Pin[3], Pin[2], Gin[1]);
    and tc6_4(m18, Pin[5], Pin[4], Pin[3], Gin[2]);
    and tc6_5(m19, Pin[5], Pin[4], Gin[3]);
    and tc6_6(m20, Pin[5], Gin[4]);
    or cc6(c6, Gin[5], m15, m16, m17, m18, m19, m20);

    // c7
    and tc7_1(m21, Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Pin[0], Cin);
    and tc7_2(m22, Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Gin[0]);
    and tc7_3(m23, Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Gin[1]);
    and tc7_4(m24, Pin[6], Pin[5], Pin[4], Pin[3], Gin[2]);
    and tc7_5(m25, Pin[6], Pin[5], Pin[4], Gin[3]);
    and tc7_6(m26, Pin[6], Pin[5], Gin[4]);
    and tc7_7(m27, Pin[6], Gin[5]);
    or cc7(c7, Gin[6], m21, m22, m23, m24, m25, m26, m27);

    // c8
    and tc8_1(m28, Pin[7], Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Pin[0], Cin);
    and tc8_2(m29, Pin[7], Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Pin[1], Gin[0]);
    and tc8_3(m30, Pin[7], Pin[6], Pin[5], Pin[4], Pin[3], Pin[2], Gin[1]);
    and tc8_4(m31, Pin[7], Pin[6], Pin[5], Pin[4], Pin[3], Gin[2]);
    and tc8_5(m32, Pin[7], Pin[6], Pin[5], Pin[4], Gin[3]);
    and tc8_6(m33, Pin[7], Pin[6], Pin[5], Gin[4]);
    and tc8_7(m34, Pin[7], Pin[6], Gin[5]);
    and tc8_8(m35, Pin[7], Gin[6]);
    or cc8(c8, Gin[7], m28, m29, m30, m31, m32, m33, m34, m35);


    xor out1(s0, A[0], B[0], Cin);
    xor out2(s1, A[1], B[1], c1);
    xor out3(s2, A[2], B[2], c2);
    xor out4(s3, A[3], B[3], c3);
    xor out5(s4, A[4], B[4], c4);
    xor out6(s5, A[5], B[5], c5);
    xor out7(s6, A[6], B[6], c6);
    xor out8(s7, A[7], B[7], c7);

    assign S = {s7, s6, s5, s4, s3, s2, s1, s0};
    assign Cout = c8;

endmodule 