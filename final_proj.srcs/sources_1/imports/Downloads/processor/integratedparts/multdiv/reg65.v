module reg65(out, clock, ctrl_reset, data, ctrlen, writeen);

    input clock, ctrlen, ctrl_reset, writeen;
	input [64:0] data;
    output[64:0] out;


    wire enable;
    and en(enable, ctrlen, writeen);

    dffe_ref dff0(.q(out[0]), .d(data[0]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff1(.q(out[1]), .d(data[1]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff2(.q(out[2]), .d(data[2]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff3(.q(out[3]), .d(data[3]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff4(.q(out[4]), .d(data[4]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff5(.q(out[5]), .d(data[5]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff6(.q(out[6]), .d(data[6]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff7(.q(out[7]), .d(data[7]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff8(.q(out[8]), .d(data[8]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff9(.q(out[9]), .d(data[9]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff10(.q(out[10]), .d(data[10]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff11(.q(out[11]), .d(data[11]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff12(.q(out[12]), .d(data[12]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff13(.q(out[13]), .d(data[13]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff14(.q(out[14]), .d(data[14]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff15(.q(out[15]), .d(data[15]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff16(.q(out[16]), .d(data[16]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff17(.q(out[17]), .d(data[17]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff18(.q(out[18]), .d(data[18]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff19(.q(out[19]), .d(data[19]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff20(.q(out[20]), .d(data[20]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff21(.q(out[21]), .d(data[21]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff22(.q(out[22]), .d(data[22]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff23(.q(out[23]), .d(data[23]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff24(.q(out[24]), .d(data[24]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff25(.q(out[25]), .d(data[25]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff26(.q(out[26]), .d(data[26]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff27(.q(out[27]), .d(data[27]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff28(.q(out[28]), .d(data[28]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff29(.q(out[29]), .d(data[29]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff30(.q(out[30]), .d(data[30]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff31(.q(out[31]), .d(data[31]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff32(.q(out[32]), .d(data[32]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff33(.q(out[33]), .d(data[33]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff34(.q(out[34]), .d(data[34]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff35(.q(out[35]), .d(data[35]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff36(.q(out[36]), .d(data[36]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff37(.q(out[37]), .d(data[37]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff38(.q(out[38]), .d(data[38]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff39(.q(out[39]), .d(data[39]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff40(.q(out[40]), .d(data[40]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff41(.q(out[41]), .d(data[41]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff42(.q(out[42]), .d(data[42]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff43(.q(out[43]), .d(data[43]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff44(.q(out[44]), .d(data[44]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff45(.q(out[45]), .d(data[45]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff46(.q(out[46]), .d(data[46]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff47(.q(out[47]), .d(data[47]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff48(.q(out[48]), .d(data[48]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff49(.q(out[49]), .d(data[49]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff50(.q(out[50]), .d(data[50]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff51(.q(out[51]), .d(data[51]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff52(.q(out[52]), .d(data[52]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff53(.q(out[53]), .d(data[53]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff54(.q(out[54]), .d(data[54]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff55(.q(out[55]), .d(data[55]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff56(.q(out[56]), .d(data[56]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff57(.q(out[57]), .d(data[57]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff58(.q(out[58]), .d(data[58]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff59(.q(out[59]), .d(data[59]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff60(.q(out[60]), .d(data[60]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff61(.q(out[61]), .d(data[61]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff62(.q(out[62]), .d(data[62]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff63(.q(out[63]), .d(data[63]), .clk(clock), .en(enable), .clr(ctrl_reset));
    dffe_ref dff64(.q(out[64]), .d(data[64]), .clk(clock), .en(enable), .clr(ctrl_reset));



endmodule