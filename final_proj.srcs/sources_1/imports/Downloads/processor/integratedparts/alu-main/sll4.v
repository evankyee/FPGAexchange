module sll4(out, in);
    input[31:0] in;
    output[31:0] out;

    assign out[3:0]=0;
    assign out[31:4]=in[27:0];

endmodule