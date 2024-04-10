module cla32(S, isNotEqual, isLessThan, ovf, Cout, A, B, Pin, Gin, Cin);
    
    input[31:0] A, B, Pin, Gin;
    input Cin;
    output isNotEqual, isLessThan, ovf, Cout;
    output[31:0] S;
    wire one;
    assign one = 1;

    

    wire G0, G1, G2, G3;
    wire P0, P1, P2, P3;
    wire ch0, ch1, ch2, ch3; 
    wire c8, c16, c24, c32;

    assign Cout= c32;


    cla block1(.S(S[7:0]), .Cout(ch0), .G(G0), .P(P0), .Pin(Pin[7:0]), .Gin(Gin[7:0]), .A(A[7:0]), .B(B[7:0]), .Cin(Cin));
    cla block2(.S(S[15:8]), .Cout(ch1), .G(G1), .P(P1), .Pin(Pin[15:8]), .Gin(Gin[15:8]), .A(A[15:8]), .B(B[15:8]), .Cin(c8));
    cla block3(.S(S[23:16]), .Cout(ch2), .G(G2), .P(P2), .Pin(Pin[23:16]), .Gin(Gin[23:16]), .A(A[23:16]), .B(B[23:16]), .Cin(c16));
    cla block4(.S(S[31:24]), .Cout(ch3), .G(G3), .P(P3), .Pin(Pin[31:24]), .Gin(Gin[31:24]), .A(A[31:24]), .B(B[31:24]), .Cin(c24));


    // c8 calculation
    and l1(y1, P0, Cin);
    or c8_calc(c8, G0, y1);

    // c16 calculation
    and l2(y2, P1, P0, Cin);
    and l3(y3, P1, G0);
    or c16_calc(c16, G1, y2, y3);

    // c24 calculation
    and l4(y4, P2, G1);
    and l5(y5, P2, P1, G0);
    and l6(y6, P2, P1, P0, Cin);
    or c24_calc(c24, G2, y4, y5, y6);

    // c32 calculation
    and l7(y7, P3, G2);
    and l8(y8, P3, P2, G1);
    and l9(y9, P3, P2, P1, G0);
    and l10(y10, P3, P2, P1, P0, Cin);
    or c32_calc(c32, G3, y7, y8, y9, y10);

    
    wire subovf, temp, addovf, finovf;
    
    xor over(subovf, c32, c24);
   

    assign ovf=finovf;//subtraction

    xor almostovf(temp, c32, S[31]);
    xor cmonpls(addovf, temp, one); //if oppposite switch above addovf to temp.
    
    
    assign finovf= addovf;


    //isnotequal check if all bits equal to zero of output
    
    
    xor ab0(ne0, A[0], B[0]);
    xor ab1(ne1, A[1], B[1]);
    xor ab2(ne2, A[2], B[2]);
    xor ab3(ne3, A[3], B[3]);
    xor ab4(ne4, A[4], B[4]);
    xor ab5(ne5, A[5], B[5]);
    xor ab6(ne6, A[6], B[6]);
    xor ab7(ne7, A[7], B[7]);
    xor ab8(ne8, A[8], B[8]);
    xor ab9(ne9, A[9], B[9]);
    xor ab10(ne10, A[10], B[10]);
    xor ab11(ne11, A[11], B[11]);
    xor ab12(ne12, A[12], B[12]);
    xor ab13(ne13, A[13], B[13]);
    xor ab14(ne14, A[14], B[14]);
    xor ab15(ne15, A[15], B[15]);
    xor ab16(ne16, A[16], B[16]);
    xor ab17(ne17, A[17], B[17]);
    xor ab18(ne18, A[18], B[18]);
    xor ab19(ne19, A[19], B[19]);
    xor ab20(ne20, A[20], B[20]);
    xor ab21(ne21, A[21], B[21]);
    xor ab22(ne22, A[22], B[22]);
    xor ab23(ne23, A[23], B[23]);
    xor ab24(ne24, A[24], B[24]);
    xor ab25(ne25, A[25], B[25]);
    xor ab26(ne26, A[26], B[26]);
    xor ab27(ne27, A[27], B[27]);
    xor ab28(ne28, A[28], B[28]);
    xor ab29(ne29, A[29], B[29]);
    xor ab30(ne30, A[30], B[30]);
    xor ab31(ne31, A[31], B[31]);

    wire isNE, isLT;

    assign isLessThan=Cin? isLT : Cin;
    assign isNotEqual=Cin? isNE : Cin;

    or ne(isNE, ne0, ne1, ne2, ne3, ne4, ne5, ne6, ne7, ne8, ne9, ne10, ne11, ne12, ne13, ne14, ne15, ne16, ne17, ne18, ne19, ne20, ne21, ne22, ne23, ne24, ne25, ne26, ne27, ne28, ne29, ne30, ne31, ovf);
    or lt(isLT, S[31], ovf);



    //islessthan


    
endmodule  