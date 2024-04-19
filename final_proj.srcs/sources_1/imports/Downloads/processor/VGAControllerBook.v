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
    
    //assign aval = imgAddress==3 ? : imgAddress==4 ? : imgAddress==5 ? : imgAddress==7 ? imgAdress==8 ? : imgAddress==9 ? : imgAddress==12 ? : imgAddress==13 ? : imgAddress==14 ? : imgAddress==16 ? : imgAddress==17 ? : imgAddress==18 ? : ;
    
    //sec B
    
    //sec C
    
    //sec D
    
    //sec E
    
    //sec F
    
    //sec G
    
    //sec H

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