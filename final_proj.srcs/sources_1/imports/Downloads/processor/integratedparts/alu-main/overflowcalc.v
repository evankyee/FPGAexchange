module overflowcalc(overflow, Amsb, Bmsb, Smsb);

    input Amsb, Bmsb, Smsb;
    output overflow;
    wire one = 1;

    

    wire Anot, Bnot, Snot;

    wire w0, w1, w2, w3, w4;


    xor noA(Anot, Amsb, one);
    xor noB(Bnot, Bmsb, one);
    xor noS(Snot, Smsb, one);

    and ovfP(w0, Anot, Bnot, Smsb);
    and ovfN(w1, Amsb, Bmsb, Snot);

    or ovfl(overflow, w0, w1);
    
endmodule