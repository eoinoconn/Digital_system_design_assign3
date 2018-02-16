`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:42 03/01/2016 
// Design Name: 
// Module Name:    State 
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
 
module state(
	input statein,
	input clk,
	input rst,
	input T,
	output reg stateout
	);
	
	reg sig;   
	
	// multiplexer
	always @ (statein, stateout, T)
		if ((statein & !stateout)) // if start is pressed and timer is not running
			sig = 1; // set to 1
		else if ((statein & stateout) || (T)) // if start is pressed and timer is running or time up
			sig = 0; // set to 0
		else
			sig = stateout; // stay the same			
		
	// register
	always @ (posedge clk or posedge rst) // all happens on clock edge
		if (rst) stateout <= 1'b0;
		else stateout <= sig;

endmodule