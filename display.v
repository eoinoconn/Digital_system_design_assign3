`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:24 03/08/2016 
// Design Name: 
// Module Name:    Display 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module display(
    input clk,
    input rst,
    input [15:0] count,
	output reg [7:0] pattern,
	output reg [7:0] dis_dig
    );

	reg [1:0] nextC, sum;
	reg [3:0] dis_num;
	wire pulsig;

	pulse #(.WIDTH(5'd16), .cycle(13'd5000)) display_pulse (.clk(clk), .rst(rst), .pulsig(pulsig));
	
	//Register to change value of sum
	always @ (posedge clk or posedge rst)
		if (rst) sum <= 2'b0;
		else sum <= nextC;

	// Multiplexor to select next count value
	always @ (sum, pulsig)
		if((sum == 2'b11)&&(pulsig)) nextC = 2'b00;
		else if (pulsig) nextC = sum + 2'b01;
		else nextC = sum;
		
	//Multiplexer to select display value
	always @ (count, sum)
		case(sum)
			2'b00:	dis_num = count[15-:4];
			2'b01:	dis_num = count[11-:4];
			2'b10:	dis_num = count[7-:4];
			2'b11:	dis_num = count[3-:4];
		endcase
	//Multiplxer to toggle active display digits, active low
	always @ (sum)
		case(sum)
			2'b00:	dis_dig = 8'b11110111;
			2'b01:	dis_dig = 8'b11111011;
			2'b10:	dis_dig = 8'b11111101;
			2'b11:	dis_dig = 8'b11111110;
		endcase
	
	// look-up table to convert 4-bit value to 7-segment pattern (0 = on)
    always @ (dis_num)
        case(dis_num)
         4'h0:  pattern = 8'b00000011;  // display 0 - all segments on except G
         4'h1:  pattern = 8'b10011111;  // display 1 - segments B and C on
         4'h2:  pattern = 8'b00100101;
         4'h3:  pattern = 8'b00001101;
         4'h4:  pattern = 8'b10011001;
         4'h5:  pattern = 8'b01001001;
         4'h6:  pattern = 8'b01000001;
         4'h7:  pattern = 8'b00011111;
         4'h8:  pattern = 8'b00000001;
         4'h9:  pattern = 8'b00001001;
         4'hA:  pattern = 8'b00010001;
         4'hB:  pattern = 8'b11000001;
         4'hC:  pattern = 8'b01100011;
         4'hD:  pattern = 8'b10000101;
         4'hE:  pattern = 8'b01100001;
         4'hF:  pattern = 8'b01110001;  // display F
    endcase  // no need for default, as all possibilities covered

endmodule
