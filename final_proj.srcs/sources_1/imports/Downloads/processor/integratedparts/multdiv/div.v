module div(out, signA, signB, clock, ctrldiv, reset, ready, exception); //B is thing being divided, A is divisor!!!, flipped in multdiv file. 
    //if enable is 1, restart multiplication and set it equal to zero.


    input clock, ctrldiv, reset;
    output ready, exception;
    input [31:0] signA, signB;
    output [31:0] out;
    wire clear;
    wire[7:0] count;
    wire[64:0] combined;
    wire one = 1;
    wire zero = 0;
    //A is what we are multiplying (iteratively adding and subtracting)

    wire[31:0] A, B, flipA, flipB;
    mux_2 Apick(A, signA[31], signA, flipA);
    mux_2 Bpick(B, signB[31], signB, flipB);
    alu Asub(combined[63:32], signA, subctrl, addctrl, flipA, aNE, aLT, aOVF);
    alu Bsub(combined[63:32], signB, subctrl, addctrl, flipB, aNE, aLT, aOVF);
    

    //my counter made with tffs
    clockcount counte(count, clock, ctrldiv);

    wire[64:0] regout, regin;
    //making a 65 bit wire and giving lower bits equal to B
    assign combined[31:0]=B; //out dividend (LOWER BITS OF REG)
    
    assign combined[64:32] = 33'b0; //upper 33 all zero (WE ARE IGNORING THE 65 BIT, NO NEED FOR IT MSB=combined[63])

    //see if we are ctrldiv (which resets division)
    //assign regin=ctrldiv? combined : fin;
    mux65_2 regcmon(regin, ctrldiv, fin, combined);

    //this is the bit that tracks if we have cycled 32 (need to go through n cycles for division)
    wire done = count[5];

    //65 bit register
    //out, clock, ctrl_reset, data, ctrlen, writeen
    reg65 cmon(regout, clock, reset, regin, one, ~done);
    wire aNE, aLT, aOVF, sNE, sLT, sOVF;

    //lets do trial subtraction
    wire[64:0] RQlshift;
    leftshift RQshift(RQlshift, regout);
    wire [31:0] upperdiv, lowerdiv;
    //splitting regout after shifting into lower and upper half (IGNORING bit 65).
    assign upperdiv=RQlshift[63:32];
    assign lowerdiv=RQlshift[31:0];

    //ALU control signals
    wire[4:0] addctrl, subctrl;
    assign subctrl[0]=1;
    assign subctrl[4:1] = 4'b0;
    assign addctrl = 5'b0;

     //data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow
    alu subber(upperdiv, A, subctrl, addctrl, trialsub, sNE, sLT, sOVF);
    wire[31:0] trialsub; //check if negative!!

    //assigning LSB of Q based on trialsub MSB
    wire Qresult;
    assign Qresult=trialsub[31]? zero : one;
    wire[31:0] lowerfin;
    assign lowerfin[31:1] = lowerdiv[31:1];
    assign lowerfin[0] = Qresult;

    //restoring based on MSB

    wire[31:0] restoreornot;
    wire[64:0] fin;
    mux_2 restore(restoreornot, trialsub[31], trialsub, upperdiv);
    assign fin[63:32] = restoreornot;
    assign fin[31:0] = lowerfin;

    //sign handling of output:
    wire samesign;
    wire[31:0] negout, validout;
    xor (samesign, signA[31], signB[31]);
    mux_2 outsel(validout, samesign, regout[31:0], negout);
    //if different signs, negate output

    alu subber2(combined[63:32], regout[31:0], subctrl, addctrl, negout, aNE, aLT, aOVF);

    assign ready = done;
    wire Azero;
    or (Azero, A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[8], A[9], A[10], A[11], A[12], A[13], A[14], A[15], A[16], A[17], A[18], A[19], A[20], A[21], A[22], A[23], A[24], A[25], A[26], A[27], A[28], A[29], A[30], A[31]);

    mux_2 assignout(out, Azero, combined[63:32], validout);
    assign exception = ~Azero; //why isnt this working what the fuck.

endmodule