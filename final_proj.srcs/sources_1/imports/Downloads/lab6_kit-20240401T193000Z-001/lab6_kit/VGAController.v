`timescale 1 ns/ 100 ps
module VGAController(     
	input clk, 			// 100 MHz System Clock
	input reset, 		// Reset Signal
	output hSync, 		// H Sync Signal
	output vSync, 		// Veritcal Sync Signal
	output[3:0] VGA_R,  // Red Signal Bits
	output[3:0] VGA_G,  // Green Signal Bits
	output[3:0] VGA_B,  // Blue Signal Bits
	inout ps2_clk,
	inout ps2_data,
	output [15:0] LED, 
	input [3:0] SW);           //Switches
	
	// Lab Memory Files Location
	localparam FILES_PATH = "C:/Users/eal63/Downloads/lab6_kit-20240401T193000Z-001/lab6_kit/";

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

    //OUR CODE !!!!!!!!!!
    wire [7:0] rx_data;
    reg [7:0] data_out;
    wire read_data;
    Ps2Interface p1(.ps2_clk(ps2_clk),.ps2_data(ps2_data), .clk(clk), .rst(reset), .tx_data(8'b0),.write_data(1'b0),.rx_data(rx_data),.read_data(read_data),.busy() ,.err());
    always@(posedge read_data)begin
        data_out = rx_data;
    end
    
    reg[3:0]entercount = 0;
    reg[6:0]cursor = 33;
    reg orderready = 0;
    
    
    reg [7:0] id = 32;
    reg [7:0] sec = 32;
    reg [7:0] price1 = 32;
    reg [7:0] price2 = 32;
    reg [7:0] price3 = 32;
    reg [7:0] volume1 = 32;
    reg [7:0] volume2 = 32;
    reg [7:0] volume3 = 32;
    reg [7:0] type = 32;
    
    reg [7:0] ascii;
    reg [7:0] last_ascii;
    wire [7:0] asc;
     
    
    
    always @(posedge read_data)begin
        last_ascii<=ascii;
        ascii <= asc;
        if (ascii==10)begin
            entercount <= entercount+1;
            
            if(entercount==1)begin
                id=last_ascii;
                cursor <= 45;
            end
            if(entercount==2)begin
                sec=last_ascii;
                cursor <= 57;
            end
            if(entercount==3)begin
                price1 = last_ascii;
                cursor <= 58;
            end
            if(entercount==4)begin
                price2 = last_ascii;
                cursor <= 59;
            end
            if(entercount==5)begin
                price3 = last_ascii;
                cursor <= 69;
            end
            if(entercount==6)begin
                volume1 = last_ascii;
                cursor <= 70;
            end
            if(entercount==7)begin
                volume2 = last_ascii;
                cursor <= 71;
            end
            if(entercount==8)begin
                volume3 = last_ascii;
                cursor <= 81;
            end
            if (entercount==9)begin
                type = last_ascii;
            end
            
            if(entercount==10)begin
                cursor=33;
                orderready=1;
                id=32;
                sec=32;
                price1=32;
                price2=32;
                price3=32;
                volume1=32;
                volume2=32;
                volume3=32;
                type=32;
            end
        
        end   
    end
    
    
    
    
    //Ram for ASCII
	RAMvga #(
		.DEPTH(256), 		       // Set depth to contain every color		
		.DATA_WIDTH(8), 		       // Set data width according to the bits per color
		.ADDRESS_WIDTH(8),     // Set address width according to the color count
		.MEMFILE({FILES_PATH, "ascii.mem"}))  // Memory initialization
	ASCII(
		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
		.addr(data_out),					       // Keyboard Value
		.dataOut(asc),				           // Corresponding ascii
		.wEn(1'b0)); 						       // We're always reading
	
	
	//if ascii is 10, we have an enter -- store last_ascii to DMEM
	//Ram for data
	RAM data(
		.clk(clk), 							   	  
		.addr(8'b0),					               
		.dataIn(last_ascii),			          
		.wEn(ascii==10)); 						   

    //Ram for sprites
    wire cpixel;
//    reg [31:0] address;
    
    //Write everything on the screen
    always@(*)begin
        
    end
    
    wire [31:0] address;
    wire ascii_type,currentblock;
    wire [7:0] final_ascii, setvals;
    assign ascii_type = (colorAddr==1);
    assign currentblock = imgAddress == cursor;
    
    assign setvals = 55;
    
    assign final_ascii = ascii_type ? currentblock ? asc : setvals : colorAddr;
    assign address = (2500*(final_ascii -33)) + (x-(x/50)*50)+(50*(y-(y/50)*50));
    assign LED = x+y;
    
    
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
    
  
    //Top left for USERID
    reg [9:0] x1 = 0;    
    reg [9:0] y1 = 0;
    
    
	// Image Data to Map Pixel Location to Color Address
	localparam 
		PIXEL_COUNT = VIDEO_WIDTH*VIDEO_HEIGHT, 	             // Number of pixels on the screen
		PIXEL_ADDRESS_WIDTH = $clog2(PIXEL_COUNT) + 1,           // Use built in log2 command
		BITS_PER_COLOR = 12, 	  								 // Nexys A7 uses 12 bits/color
		PALETTE_COLOR_COUNT = 256, 								 // Number of Colors available
		PALETTE_ADDRESS_WIDTH = $clog2(PALETTE_COLOR_COUNT) + 1; // Use built in log2 Command

	wire[PIXEL_ADDRESS_WIDTH-1:0] imgAddress;  	 // Image address for the image data
	wire[PALETTE_ADDRESS_WIDTH-1:0] colorAddr; 	 // Color address for the color palette
	assign imgAddress = (x/50) + 13*(y/50);				 // Address calculated coordinate

	RAMvga #(		
		.DEPTH(PIXEL_COUNT), 				     // Set RAM depth to contain every pixel
		.DATA_WIDTH(PALETTE_ADDRESS_WIDTH),      // Set data width according to the color palette
		.ADDRESS_WIDTH(PIXEL_ADDRESS_WIDTH),     // Set address with according to the pixel count
		.MEMFILE({FILES_PATH, "image.mem"})) // Memory initialization
	ImageData(
		.clk(clk), 						 // Falling edge of the 100 MHz clk
		.addr(imgAddress),					 // Image data address
		.dataOut(colorAddr),				 // Color palette address
		.wEn(1'b0)); 						 // We're always reading

	// Color Palette to Map Color Address to 12-Bit Color
	wire[BITS_PER_COLOR-1:0] colorData; // 12-bit color data at current pixel

//	RAMvga #(
//		.DEPTH(PALETTE_COLOR_COUNT), 		       // Set depth to contain every color		
//		.DATA_WIDTH(BITS_PER_COLOR), 		       // Set data width according to the bits per color
//		.ADDRESS_WIDTH(PALETTE_ADDRESS_WIDTH),     // Set address width according to the color count
//		.MEMFILE({FILES_PATH, "colors.mem"}))  // Memory initialization
//	ColorPalette(
//		.clk(clk), 							   	   // Rising edge of the 100 MHz clk
//		.addr(colorAddr),					       // Address from the ImageData RAM
//		.dataOut(colorData),				       // Color at current pixel
//		.wEn(1'b0)); 						       // We're always reading

    assign colorData = 6'hffffff;

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