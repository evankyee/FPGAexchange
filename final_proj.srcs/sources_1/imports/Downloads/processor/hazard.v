module hazard(stall, dmembypass, bypassA, bypassB, bexB, bypass5, FDirout, DXirout, XMirout, MWirout, rtype3, itype3, jitype3, jiitype3, rtype5, itype5, jitype5, jiitype5, rtype, itype, jitype, jiitype);

    input[31:0] FDirout, DXirout, XMirout, MWirout;
    output[1:0] bypassA, bypassB;
    output stall, dmembypass, bypass5;

    wire [4:0] FDrs1, FDrs2, DXrd, XMrd, DXrs1, MWrd, DXrs2;
    wire[4:0] FDopcode, DXopcode, XMopcode, MWopcode;

    assign FDopcode = FDirout[31:27];
    assign DXopcode = DXirout[31:27];
    assign XMopcode = XMirout[31:27];
    assign MWopcode = MWirout[31:27];

    input rtype3, itype3, jitype3, jiitype3, rtype5, itype5, jitype5, jiitype5, rtype, itype, jitype, jiitype;

    //IMPLEMENTING HAZARDS AND BYPASS LOGIC


    //STALL
    wire DXIRload, FDIRstore;
    assign DXIRload=(DXopcode==5'b01000);
    assign FDIRstore=(FDopcode==5'b00111);

    assign FDrs1=FDirout[21:17];
    assign FDrs2=FDirout[16:12];
    assign DXrd=DXirout[26:22];
    assign DXrs1=DXirout[21:17];
    assign DXrs2=DXirout[16:12];
    assign XMrd=XMirout[26:22];
    assign MWrd=MWirout[26:22];


    assign stall = DXIRload & ((itype|rtype) & ((FDrs1==DXrd) | ((FDrs2 == DXrd) & (~FDIRstore))) | (jiitype & (FDirout[26:22] == DXrd))
                    | ((FDopcode==5'b00010 | FDopcode==5'b00110) & (DXrd==FDrs1 || DXrd==FDirout[26:22])));



    //BYPASS


    assign bypassA = ((aluAxm | aluAxm2 | aluAxm3 | aluAxm4)&XMirout!=32'b00000000000000000000000000000000)? 2'b00: (((aluAmw | aluAmw2 | aluAmw3 | aluAmw4)&MWirout!=32'b00000000000000000000000000000000)?2'b01:2'b10);
    
    assign bypassB = ((aluBxm | aluBxm2 | aluBxm3 | aluBxm5)&XMirout!=32'b00000000000000000000000000000000)? 2'b00: (((aluBmw | aluBmw2 | aluBmw3 | aluBxm5)&MWirout!=32'b00000000000000000000000000000000)?2'b01:2'b10);

    output[1:0] bexB;

    assign bexB = (aluBxm4) ? 2'b11 : ((aluBmw4) ? 2'b10: 2'b00);



    //BEX TAKES FROM TARGET NOT THE FUCKING XMO OR MWO
    //aluBxm4 | aluBxm5

    //aluBmw4 | aluBmw5

    //alubypass
    wire aluAxm, aluAmw, aluBxm, aluBmw;

    assign aluAxm = (DXopcode==5'b00000 | DXopcode==5'b00101) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrs1==XMrd) & (DXrs1!=5'b00000);
    assign aluAmw = (DXopcode==5'b00000 | DXopcode==5'b00101) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrs1==MWrd) & (DXrs1!=5'b00000);

    assign aluBxm = (DXopcode==5'b00000 | DXopcode==5'b00101) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrs2==XMrd) & (DXrs2!=5'b00000);
    assign aluBmw = (DXopcode==5'b00000 | DXopcode==5'b00101) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrs2==MWrd) & (DXrs2!=5'b00000);


    //jumping bypass
    wire aluAxm2, aluAmw2, aluBxm2, aluBmw2, aluAxm3, aluAmw3, aluBxm3, aluBmw3;

    assign aluBxm3=(DXopcode==5'b00100) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrd==XMrd) & (DXrd!=5'b00000); //jr rd! bypassing B
    assign aluBmw3=(DXopcode==5'b00100) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrd==MWrd) & (DXrd!=5'b00000);

    //bne and blt
    assign aluBxm2 = (DXopcode==5'b00010 | DXopcode==5'b00110) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrd == XMrd) & (DXrd!=5'b00000);
    assign aluBmw2 = (DXopcode==5'b00010 | DXopcode==5'b00110) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrd == MWrd) & (DXrd!=5'b00000);

    assign aluAxm2=(DXopcode==5'b00010 | DXopcode==5'b00110) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrs1 == XMrd) & (DXrs1!=5'b00000);
    assign aluAmw2=(DXopcode==5'b00010 | DXopcode==5'b00110) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrs1 == MWrd) & (DXrs1!=5'b00000);


    //bex (examining setx first then if we are writing to r30)
    assign aluBxm4 = (DXopcode==5'b10110) & (XMopcode==5'b10101) & (XMirout[26:0]!=27'b000000000000000000000000000);
    assign aluBmw4 = (DXopcode==5'b10110) & (MWopcode==5'b10101) & (MWirout[26:0]!=27'b000000000000000000000000000); //BOTH FROM SETX

    assign aluBxm5 = (DXopcode==5'b10110) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (XMrd==5'b11110);
    assign aluBmw5 = (DXopcode==5'b10110) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (XMrd==5'b11110); //BOTH FROM WRITING TO r30

    //consider what happens if we throw excpetions in X stage!!!




    //swlw bypass

    assign aluAxm3= (DXopcode == 5'b00111) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrs1 == XMrd); //sw
    assign aluAmw3 = (DXopcode == 5'b00111) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrs1 == MWrd);

    assign aluAxm4= (DXopcode == 5'b01000) & (XMopcode==5'b00000 | XMopcode==5'b00101) & (DXrs1 == XMrd); //lw
    assign aluAmw4 = (DXopcode == 5'b01000) & (MWopcode==5'b00000 | MWopcode==5'b00101 | MWopcode==5'b01000) & (DXrs1 == MWrd);


    //if lw then we need to make sure we grab that value

    









    //membypass
    wire XMstore = (XMopcode==5'b00111);
    assign dmembypass = (XMstore & XMrd==MWrd & XMrd!=5'b00000);
    






    //TODO



endmodule