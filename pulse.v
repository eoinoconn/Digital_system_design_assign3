`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:33 03/01/2016 
// Design Name: 
// Module Name:    Pulse 
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
module pulse(
	input clk,
	input rst,
	output reg pulsig
    );

	parameter WIDTH = 16;
	parameter cycle = 16'd65535;
	
	reg [WIDTH-1:0] Q, nextQ;

	// multiplexer to count up or set to zero
	always @ (Q, pulsig)
		if (pulsig)
			nextQ = 1'b0; // reset count
		else
			nextQ = Q + 1'b1; // count up 1

	// register
	always @ (posedge clk or posedge rst) // all happens on clock edge
		if (rst) Q <= 1'b0;
		else Q <= nextQ;

	// combinational logic to check if the count equals the cycle
	always @ (Q or rst)
		if (rst) pulsig = 1'b0;
		else if(Q == cycle) pulsig = 1'b1;
		else pulsig = 1'b0; 

endmodule
