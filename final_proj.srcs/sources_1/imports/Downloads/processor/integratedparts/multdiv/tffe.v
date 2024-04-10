module tffe(out, clock, in, clr);
    input clock, in, clr;
    output out;
    wire one;
    assign one = 1;
    wire A, notA, notin;

    wire j, k, l;

    xor no(notA, A, one);
    xor no1(notin, in, one);

    and a1(j, A, notin);
    and a0(k, notA, in);

    or o(l, j, k);

    assign out=A;

    dffe_ref dff(A, l, clock, one, clr);

endmodule