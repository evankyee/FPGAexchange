module doublereg32 (
    outIR,
    outPC,
	clock,
	ctrl_reset,
	dataIR,
    dataPC,
    irEN, pcEN //write enable
);

    input clock, irEN, ctrl_reset, pcEN;
	input [31:0] dataIR, dataPC;
    output[31:0] outIR, outPC;

    reg32 ir(outIR, clock, ctrl_reset, dataIR, irEN, irEN);
    reg32 pc(outPC, clock, ctrl_reset, dataPC, pcEN, pcEN);


endmodule