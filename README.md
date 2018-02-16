# Digital_system_design_assign3
We designed a timer to count downward from a set value to zero, then indicate zero had been reached by lighting an L.E.D. Our design was implemented using a Xilinx FPGA on a Digilent nexys-4 board. The timer had three inputs, set and start as well as a reset button. The features we implemented and the thinking behind our design decisions are as follows are as follows:
  - Time set to predetermined value (30 seconds) when set is pressed and clock is not running.
  - Timer starts running when start is pressed if not running.
  - Timer stops running when start is pressed if running.
  - Timer stops running when timer reaches zero.
  - If start is pressed while timer is at zero nothing occurs.
  - If set is pressed when timer has reached zero, the timer returns to preset value.
  - Timer displays 4 digits in hexadecimal.
    - We picked four with the intention of displaying minutes and seconds later on in decimal, however we did not have to execute this in our design, the four digits would allow us to have our preset high enough to count to nearly 70 minutes in hexadecimal
  - Far right digit displays 1/16th of a second in hexadecimal, the center digit displays seconds, and the left digit display number 16ths of seconds.
  - Set input ignored if timer is counting down.
    - We decided that if the customer wanted to restart the timer, they should do it by stopping the timer and hitting set and start rather than just hitting set and resuming the countdown from the preset value.
  - When zero is reached an L.E.D. is lit and remains lit till the time is set again
  - If reset is pressed at any time, counter becomes idle and time is set to zero, LED is off
