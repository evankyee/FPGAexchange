module sra8(out, in);
    input[31:0] in;
    output[31:0] out;

    assign out[31:24]=8'b0;
    assign out[23:0]={in[31],in[30],in[29],in[28],in[27],in[26],in[25],in[24],in[23],in[22],in[21],in[20],in[19],in[18],in[17],in[16],in[15],in[14],in[13],in[12],in[11],in[10],in[9],in[8]};
    

endmodule