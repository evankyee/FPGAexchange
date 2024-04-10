module ovfsub(ovf,A,B,S);

    input A,B,S;
    output ovf;
    wire w1,w2,w3,w4,w5;
    wire one;
    assign one = 1;


    xor no1(w1, A, one);
    xor no2(w2, B, one);
    xor no3(w4, S, one);

    and and1(w3,w1,B,S);
    and and2(w5,A,w2,w4);

    or or1(ovf,w3,w5);

endmodule