module decoder(out, in, en);
    output[31:0] out;
    input[4:0] in;
    input en;

    assign out = en << in;

endmodule