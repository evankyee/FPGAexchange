module P(p_out, p_in1, p_in2);
    input[7:0] p_in1, p_in2;
    output[7:0] p_out;

    or p0(p_out[0], p_in1[0], p_in2[0]);
    or p1(p_out[1], p_in1[1], p_in2[1]);
    or p2(p_out[2], p_in1[2], p_in2[2]);
    or p3(p_out[3], p_in1[3], p_in2[3]);
    or p4(p_out[4], p_in1[4], p_in2[4]);
    or p5(p_out[5], p_in1[5], p_in2[5]);
    or p6(p_out[6], p_in1[6], p_in2[6]);
    or p7(p_out[7], p_in1[7], p_in2[7]);
    
endmodule