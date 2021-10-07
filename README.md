# Assembly-Timer
<b>This code was used on the Intel 8051.<br></b>
This system stores the timer value in four different registers that also affect the value that is
displayed on the seven segment display. This continues to happen until all the values in the assigned registers are 
zero, when this happens an endless loop occurs showcasing the end of the program. The display values are temporarily 
assigned to a lookup table value using the current value as an index for the table. Multiplexing is done to light up each
section of the seven segment display.
