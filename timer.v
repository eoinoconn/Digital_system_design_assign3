`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:42 03/01/2016 
// Design Name: 
// Module Name:    Timer 
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
module timer(
    input clk,
    input set, // load is set after clean up
    input start, // run is start after clean up
    input rst,
    output reg [15:0] Q, // Q is the count
    output reg T
    );

	localparam value = 16'd30;
	reg [15:0] nextQ;
	
	pulse #(.WIDTH(19), .cycle(19'd312500)) timer_pulse (.clk(clk), .rst(rst), .pulsig(pulsig));
	
	cleanup cleanup_set(.sig(set), .clk(clk), .rst(rst), .sigout(load));
	cleanup cleanup_start(.sig(start), .clk(clk), .rst(rst), .sigout(run));
	state start_state(.statein(run), .clk(clk), .rst(rst), .stateout(run_state), .T(T));
	
	// multiplexer for count down, set time to starting value or stay the same
	always @ (load, run_state, pulsig, Q, T)
		if ((load & ~run_state) || (load & T))
		  begin
			nextQ = value; // set time to starting value
			end
		else if (run_state & pulsig & ~T)
		begin
			nextQ = Q - 16'd1; // count down
		end
		else
			nextQ = Q; // stay the same
		
	// register
	always @ (posedge clk or posedge rst) // all happens on clock edge
		if (rst) Q <= 16'b0;
		else Q <= nextQ;
	
	// multiplexer for overflow
	always @ (Q)
		if((Q==16'd0)) // if running and timer is 0
			T = 1'b1; // set T to 1 (light green LED)
		else
			T = 1'b0;
	
endmodule