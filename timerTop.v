//////////////////////////////////////////////////////////////////////////////////
// Company:       UCD School of Electrical and Electronic Engineering
// Engineer:      Eoin OConnell, Ronan Burke
// Project:       Timer assignment
// Target Device: XC7A100T-csg324 on Digilent Nexys 4 board
// Description:   Top-level module for timer design.
//                Defines top-level input and output signals.
//                Instantiates clock and reset generator block, for 5 MHz clock
//                Instantiates timer and display modules
//  Modified: 22 March 2016
//////////////////////////////////////////////////////////////////////////////////
module timer_top(
        input clk100,        // 100 MHz clock from oscillator on board
        input rstPBn,        // reset signal, active low, from CPU RESET pushbutton
        input btnR,          // start signal, active high, from BTNR pushbutton
        input btnL,          // set signal, active high, from BTNL pushbutton
        output [7:0] digit,  // digit controls - active low (3 on left, 0 on right)
        output [7:0] segment, // segment controls - active low (a b c d e f g dp)
        output alarm
        );

// ===========================================================================
// Interconnecting Signals
    wire clk5;              // 5 MHz clock signal, buffered
    wire reset;             // internal reset signal, active high
    wire [15:0] timeVal;    // output from timer, to be displayed - adjust width as needed
    wire [15:0] qwire;
    
    
// ===========================================================================
// Instantiate clock and reset generator, connect to signals
    clockReset  clkGen (
            .clk100 (clk100),       // inpit clock at 100 MHz
            .rstPBn (rstPBn),       // input reset, active low
            .clk5   (clk5),         // output clock, 5 MHz
            .reset  (reset) );      // output reset, active high
            
// ===========================================================================
            // Here we instantiate the timer, connect the signals
    timer timer1 (
            .clk(clk5),
            .set(btnL),
            .start(btnR),
            .rst(reset),
            .Q(qwire),
            .T(alarm));
            
// ==================================================================================
// Here we instantiate our display module.
   display display1 (.clk(clk5), .rst(reset), 
         .count(qwire),     // input value to be displayed
         .dis_dig(digit),  // digit outputs - only using rightmost 5 digits
         .pattern(segment));  // segment outputs
      
endmodule
