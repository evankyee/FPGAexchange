`timescale 1 ns/ 100 ps
module VGAControllerBook(     
	input clk, 			// 100 MHz System Clock
	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,
	input[31:0] buyA,
	input[31:0] buyB,
	input[31:0] buyC,
	input[31:0] buyD,
	input[31:0] buyE,
	input[31:0] buyF,
	input[31:0] buyG,
	input[31:0] buyH,
	input[31:0] sellA,
	input[31:0] sellB,
	input[31:0] sellC,
	input[31:0] sellD,
	input[31:0] sellE,
	input[31:0] sellF,
	input[31:0] sellG,
	input[31:0] sellH
	);  
	
	// Lab Memory Files Location
	localparam FILES_PATH = "C:/Users/eal63/Desktop/FPGAexchange/final_proj.srcs/sources_1/imports/Downloads/lab6_kit-20240401T193000Z-001/lab6_kit/";

	// Clock divider 100 MHz -> 25 MHz
	wire clk25; // 25MHz clock

	reg[1:0] pixCounter = 0;      // Pixel counter to divide the clock
    assign clk25 = pixCounter[1]; // Set the clock high whenever the second bit (2) is high
	always @(posedge clk) begin
		pixCounter <= pixCounter + 1; // Since the reg is only 3 bits, it will reset every 8 cycles
	end

	// VGA Timing Generation for a Standard VGA Screen
	localparam 
		VIDEO_WIDTH = 640,  // Standard VGA Width
		VIDEO_HEIGHT = 480; // Standard VGA Height

	wire active, screenEnd;
	wire[9:0] x;
	wire[8:0] y;
	
	VGATimingGenerator #(
		.HEIGHT(VIDEO_HEIGHT), // Use the standard VGA Values
		.WIDTH(VIDEO_WIDTH))
	Display( 
		.clk25(clk25),  	   // 25MHz Pixel Clock
		.reset(reset),		   // Reset Signal
		.screenEnd(screenEnd), // High for one cycle when between two frames
		.active(active),	   // High when drawing pixels
		.hSync(hSync),  	   // Set Generated H Signal
		.vSync(vSync),		   // Set Generated V Signal
		.x(x), 				   // X Coordinate (from left)
		.y(y)); 			   // Y Coordinate (from top)	   


    //Ram for sprites
    wire cpixel;
    
    wire [31:0] address;
    wire [3:0] var_in;
    wire [7:0] final_ascii, setvals, aval, bval,cval,dval,eval,fval,gval,hval;
    //check if its a variable field
    assign var_in = (colorAddr < 9) ? colorAddr : 0;
    

    //sec A
    wire[7:0] apbh,apbt,apbo,avbh,avbt,avbo,apsh,apst,apso,avsh,avst,avso;
    bitmath apriceb(buyA[23:12],apbh,apbt,apbo);
    bitmath avolb(buyA[11:0],avbh,avbt,avbo);
    bitmath aprices(sellA[23:12],apsh,apst,apso);
    bitmath avols(sellA[11:0],avsh,avst,avso);
    assign aval = imgAddress==3 ? (apbh+48): imgAddress==4 ? (apbt+48): imgAddress==5 ? (apbo+48) : imgAddress==7 ? (avbh+48) : imgAddress==8 ? (avbt+48): imgAddress==9 ? (avbo+48): imgAddress==12 ? (apsh+48): imgAddress==13 ? (apst+48): imgAddress==14 ? (apso+48) : imgAddress==16 ? (avsh+48): imgAddress==17 ? (avst+48): imgAddress==18 ? (avso+48): 32;
    
    //sec B
    wire[7:0] bpbh,bpbt,bpbo,bvbh,bvbt,bvbo,bpsh,bpst,bpso,bvsh,bvst,bvso;
    bitmath bpriceb(buyB[23:12],bpbh,bpbt,bpbo);
    bitmath bvolb(buyB[11:0],bvbh,bvbt,bvbo);
    bitmath bprices(sellB[23:12],bpsh,bpst,bpso);
    bitmath bvols(sellB[11:0],bvsh,bvst,bvso);
    assign bval = imgAddress==23 ? (bpbh+48): imgAddress==24 ? (bpbt+48): imgAddress==25 ? (bpbo+48) : imgAddress==27 ? (bvbh+48) : imgAddress==28 ? (bvbt+48): imgAddress==29 ? (bvbo+48): imgAddress==32 ? (bpsh+48): imgAddress==33 ? (bpst+48): imgAddress==34 ? (bpso+48) : imgAddress==36 ? (bvsh+48): imgAddress==37 ? (bvst+48): imgAddress==38 ? (bvso+48): 32;
    
    //sec C
    wire[7:0] cpbh,cpbt,cpbo,cvbh,cvbt,cvbo,cpsh,cpst,cpso,cvsh,cvst,cvso;
    bitmath cpriceb(buyC[23:12],cpbh,cpbt,cpbo);
    bitmath cvolb(buyC[11:0],cvbh,cvbt,cvbo);
    bitmath cprices(sellC[23:12],cpsh,cpst,cpso);
    bitmath cvols(sellC[11:0],cvsh,cvst,cvso);
    assign cval = imgAddress==43 ? (cpbh+48): imgAddress==44 ? (cpbt+48): imgAddress==45 ? (cpbo+48) : imgAddress==47 ? (cvbh+48) : imgAddress==48 ? (cvbt+48): imgAddress==49 ? (cvbo+48): imgAddress==52 ? (cpsh+48): imgAddress==53 ? (cpst+48): imgAddress==54 ? (cpso+48) : imgAddress==56 ? (cvsh+48): imgAddress==57 ? (cvst+48): imgAddress==58 ? (cvso+48): 32;
    
    //sec D
    wire[7:0] dpbh,dpbt,dpbo,dvbh,dvbt,dvbo,dpsh,dpst,dpso,dvsh,dvst,dvso;
    bitmath dpriceb(buyD[23:12],dpbh,dpbt,dpbo);
    bitmath dvolb(buyD[11:0],dvbh,dvbt,dvbo);
    bitmath dprices(sellD[23:12],dpsh,dpst,dpso);
    bitmath dvols(sellD[11:0],dvsh,dvst,dvso);
    assign dval = imgAddress==63 ? (dpbh+48): imgAddress==64 ? (dpbt+48): imgAddress==65 ? (dpbo+48) : imgAddress==67 ? (dvbh+48) : imgAddress==68 ? (dvbt+48): imgAddress==69 ? (dvbo+48): imgAddress==72 ? (dpsh+48): imgAddress==73 ? (dpst+48): imgAddress==74 ? (dpso+48) : imgAddress==76 ? (dvsh+48): imgAddress==77 ? (dvst+48): imgAddress==78 ? (dvso+48): 32;
    
    
    //sec E
    wire[7:0] epbh,epbt,epbo,evbh,evbt,evbo,epsh,epst,epso,evsh,evst,evso;
    bitmath epriceb(buyE[23:12],epbh,epbt,epbo);
    bitmath evolb(buyE[11:0],evbh,evbt,evbo);
    bitmath eprices(sellE[23:12],epsh,epst,epso);
    bitmath evols(sellE[11:0],evsh,evst,evso);
    assign eval = imgAddress==83 ? (epbh+48): imgAddress==84 ? (epbt+48): imgAddress==85 ? (epbo+48) : imgAddress==87 ? (evbh+48) : imgAddress==88 ? (evbt+48): imgAddress==89 ? (evbo+48): imgAddress==92 ? (epsh+48): imgAddress==93 ? (epst+48): imgAddress==94 ? (epso+48) : imgAddress==96 ? (evsh+48): imgAddress==97 ? (evst+48): imgAddress==98 ? (evso+48): 32;
    
    
    //sec F
    wire[7:0] fpbh,fpbt,fpbo,fvbh,fvbt,fvbo,fpsh,fpst,fpso,fvsh,fvst,fvso;
    bitmath fpriceb(buyF[23:12],fpbh,fpbt,fpbo);
    bitmath fvolb(buyF[11:0],fvbh,fvbt,fvbo);
    bitmath fprices(sellF[23:12],fpsh,fpst,fpso);
    bitmath fvols(sellF[11:0],fvsh,fvst,fvso);
    assign fval = imgAddress==103 ? (fpbh+48): imgAddress==104 ? (fpbt+48): imgAddress==105 ? (fpbo+48) : imgAddress==107 ? (fvbh+48) : imgAddress==108 ? (fvbt+48): imgAddress==109 ? (fvbo+48): imgAddress==112 ? (fpsh+48): imgAddress==113 ? (fpst+48): imgAddress==114 ? (fpso+48) : imgAddress==116 ? (fvsh+48): imgAddress==117 ? (fvst+48): imgAddress==118 ? (fvso+48): 32;
        
    //sec G
    wire[7:0] gpbh,gpbt,gpbo,gvbh,gvbt,gvbo,gpsh,gpst,gpso,gvsh,gvst,gvso;
    bitmath gpriceb(buyG[23:12],gpbh,gpbt,gpbo);
    bitmath gvolb(buyG[11:0],gvbh,gvbt,gvbo);
    bitmath gprices(sellG[23:12],gpsh,gpst,gpso);
    bitmath gvols(sellG[11:0],gvsh,gvst,gvso);
    assign gval = imgAddress==123 ? (gpbh+48): imgAddress==124 ? (gpbt+48): imgAddress==125 ? (gpbo+48) : imgAddress==127 ? (gvbh+48) : imgAddress==128 ? (gvbt+48): imgAddress==129 ? (gvbo+48): imgAddress==132 ? (gpsh+48): imgAddress==133 ? (gpst+48): imgAddress==134 ? (gpso+48) : imgAddress==136 ? (gvsh+48): imgAddress==137 ? (gvst+48): imgAddress==138 ? (gvso+48): 32;
        
    //sec H
    wire[7:0] hpbh,hpbt,hpbo,hvbh,hvbt,hvbo,hpsh,hpst,hpso,hvsh,hvst,hvso;
    bitmath hpriceb(buyH[23:12],hpbh,hpbt,hpbo);
    bitmath hvolb(buyH[11:0],hvbh,hvbt,hvbo);
    bitmath hprices(sellH[23:12],hpsh,hpst,hpso);
    bitmath hvols(sellH[11:0],hvsh,hvst,hvso);
    assign hval = imgAddress==143 ? (hpbh+48): imgAddress==144 ? (hpbt+48): imgAddress==145 ? (hpbo+48) : imgAddress==147 ? (hvbh+48) : imgAddress==148 ? (hvbt+48): imgAddress==149 ? (hvbo+48): imgAddress==152 ? (hpsh+48): imgAddress==153 ? (hpst+48): imgAddress==154 ? (hpso+48) : imgAddress==156 ? (hvsh+48): imgAddress==157 ? (hvst+48): imgAddress==158 ? (hvso+48): 32;
    
    
    assign setvals = var_in==1 ? aval : var_in==2 ? bval : var_in==3 ? cval : var_in==4 ? dval : var_in==5 ? eval : var_in==6 ? fval : var_in==7 ? gval : var_in==8 ? hval : 32;
   
    //either background or our register values
    assign final_ascii = (var_in!=0) ? setvals : colorAddr;
    assign address = (2500*(final_ascii -33)) + (x-(x/32)*32)+(50*(y-(y/64)*64));
    
    
	RAMvga #(
		.DEPTH(235000), 		       // Set depth to contain every color		
		.DATA_WIDTH(1), 		       // Set data width according to the bits per color
		.ADDRESS_WIDTH(32),     // Set address width according to the color count
		.MEMFILE({FILES_PATH, "sprites.mem"}))  // Memory initialization
	Sprites(
		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
		.addr(address),					       // Address from the ImageData RAM
		.dataOut(cpixel),				       // Color at current pixel
		.wEn(1'b0)); 						       // We're always reading
    

    
	// Image Data to Map Pixel Location to Color Address
	localparam 
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command

	wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr; 	 // Color address for the color palette
	assign imgAddress = (x/32) + 20*(y/64);				 // Address calculated coordinate


	RAMvga #(		
		.DEPTH(PIXEL_COUNT), 				     // Set RAM depth to contain every pixel
		.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
		.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
		.MEMFILE({FILES_PATH, "book.mem"})) // Memory initialization
	ImageData(
		.clk(clk), 						 // Falling edge of the 100 MHz clk
		.addr(imgAddress),					 // Image data address
		.dataOut(colorAddr),				 // Color palette address
		.wEn(1'b0)); 						 // We're always reading

	// Color Palette to Map Color Address to 12-Bit Color
	wire[BITS_PER_COLOR-1:0] colorData; // 12-bit color data at current pixel
    assign colorData = 12'hffffff;

	// Assign to output color from register if active
	wire[BITS_PER_COLOR-1:0] colorOut, colorOut2; 			  // Output color 
	assign colorOut = active ? colorData : 12'd0; // When not active, output black
    
    //12 d 0 should be output from sprite mem
    wire nonbackground;
    assign nonbackground = (colorAddr!=0);
    assign colorOut2 = nonbackground ? cpixel ? 12'd0 : colorOut : colorOut;

	// Quickly assign the output colors to their channels using concatenation
	assign {VGA_R, VGA_G, VGA_B} = colorOut2;

endmodule