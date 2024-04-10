module sra(out, shift, in);
    input[31:0] in;
    input[4:0] shift;
    output[31:0] out;

    wire[31:0] w0, w1, w2, w3, w4, w5;
    wire[31:0] m0, m1, m2, m3, m4, m5;

    sra16 right16(w0, in);
    mux_2 shift16(m0, shift[4], in, w0);

    sra8 right8(w1, m0);
    mux_2 shift8(m1, shift[3], m0, w1);

    sra4 right4(w2, m1);
    mux_2 shift4(m2, shift[2], m1, w2);

    sra2 right2(w3, m2);
    mux_2 shift2(m3, shift[1], m2, w3);

    sra1 right1(w4, m3);
    mux_2 shift1(m4, shift[0], m3, w4);


    assign out = m4;
    

endmodule