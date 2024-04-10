module reg32 (
    output[31:0] out,
	input clk,
	input controlres,
	input[31:0] dat,
    input ctrlen, 
    input writeen);


    wire enable;
    and en(enable, ctrlen, writeen);

    dffe_ref dff0(.q(out[0]), .d(dat[0]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff1(.q(out[1]), .d(dat[1]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff2(.q(out[2]), .d(dat[2]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff3(.q(out[3]), .d(dat[3]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff4(.q(out[4]), .d(dat[4]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff5(.q(out[5]), .d(dat[5]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff6(.q(out[6]), .d(dat[6]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff7(.q(out[7]), .d(dat[7]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff8(.q(out[8]), .d(dat[8]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff9(.q(out[9]), .d(dat[9]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff10(.q(out[10]), .d(dat[10]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff11(.q(out[11]), .d(dat[11]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff12(.q(out[12]), .d(dat[12]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff13(.q(out[13]), .d(dat[13]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff14(.q(out[14]), .d(dat[14]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff15(.q(out[15]), .d(dat[15]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff16(.q(out[16]), .d(dat[16]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff17(.q(out[17]), .d(dat[17]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff18(.q(out[18]), .d(dat[18]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff19(.q(out[19]), .d(dat[19]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff20(.q(out[20]), .d(dat[20]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff21(.q(out[21]), .d(dat[21]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff22(.q(out[22]), .d(dat[22]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff23(.q(out[23]), .d(dat[23]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff24(.q(out[24]), .d(dat[24]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff25(.q(out[25]), .d(dat[25]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff26(.q(out[26]), .d(dat[26]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff27(.q(out[27]), .d(dat[27]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff28(.q(out[28]), .d(dat[28]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff29(.q(out[29]), .d(dat[29]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff30(.q(out[30]), .d(dat[30]), .clk(clk), .en(enable), .clr(controlres));
    dffe_ref dff31(.q(out[31]), .d(dat[31]), .clk(clk), .en(enable), .clr(controlres));


	// add your code here


endmodule
