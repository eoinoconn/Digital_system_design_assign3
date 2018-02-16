`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:42 03/01/2016 
// Design Name: 
// Module Name:    Cleanup 
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
 
module cleanup(
    input sig,
	 input clk,
    input rst,
    output reg sigout
    );
	
	reg sig1, sig2, signext1;
	
	pulse #(.WIDTH(5'd16), .cycle(8'd165)) cleanup_pulse (.clk(clk), .rst(rst), .pulsig(pulsig));
	
	// multiplexor
	always @ (pulsig, sig, sig1)
		if (pulsig == 1) signext1 = sig;
		else signext1 = sig1;
		
	// register
	always @ (posedge clk or posedge rst) // all happens on clock edge
		if (rst) sig1 <= 1'b0;
		else sig1 <= signext1;
	
	// register
	always @ (posedge clk or posedge rst) // all happens on clock edge
		if (rst) sig2 <= 1'b0;
		else sig2 <= sig1;

	// combinational logic for edge detection
	always @ (sig1, sig2)
		if (sig1 & ~sig2) // if set1 and set2 are different
			sigout = 1'b1; // output 1
		else
			sigout = 1'b0; // otherwise output 0


	
endmodule