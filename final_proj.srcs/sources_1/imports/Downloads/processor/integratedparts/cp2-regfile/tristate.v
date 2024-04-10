module tristate(out, in, sel);
    input[31:0] in;
    output[31:0] out;
    input sel;

    assign out = sel ? in : 32'bz;


endmodule
