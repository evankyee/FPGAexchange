module clockcount(count, clock, clr);
    input clock, clr;
    output[7:0] count;

    //counting to 32, but just in case ill make counter go up to 8 bits

    wire o0, o1, o2, o3, o4, o5, o6, o7, i0, i1, i2, i3, i4, i5, i6, i7;
    wire one;
    assign one = 1;

    //counter rationale, take tff which flips on clock edge if high input, so this is like constructing truth table where lsb flips every cycle, 2nd lsb flips every two cycles, etc... up to msb

    tffe tff0(o0, clock, one, clr);
    tffe tff1(o1, clock, i0, clr);
    tffe tff2(o2, clock, i1, clr);
    tffe tff3(o3, clock, i2, clr);
    tffe tff4(o4, clock, i3, clr);
    tffe tff5(o5, clock, i4, clr);
    tffe tff6(o6, clock, i5, clr);
    tffe tff7(o7, clock, i6, clr);



    and a0(i0, o0, one);
    and a1(i1, o1, i0);
    and a2(i2, o2, i1);
    and a3(i3, o3, i2);
    and a4(i4, o4, i3);
    and a5(i5, o5, i4);
    and a6(i6, o6, i5);
    and a7(i7, o7, i6);

    assign count = {o7, o6, o5, o4, o3, o2, o1, o0};

    

endmodule