# Hardware Assignment 3

## Black Box
![alt text](https://i.imgur.com/Do00eIH.png)
![alt text](https://i.imgur.com/drMYO3T.png?1)

## Behavior description

This keypad driver has 12 buttons, 0-9, *, and #. Pressing each button displays its corresponding value on the seven segment display. The asterisk (*) displays a capital “A” while the pound (#) displays a lowercase “b.” Only one button can be pressed at a time. When the button is pressed, our FSM figures out exactly which button was pressed and outputs an 8-bit signal that corresponds to the seven segment input. As long as the button is pressed, the value will be output on the display.

## Specification

Our keypad driver analyzes a single button press, and first translates that button press into a corresponding column value (active-low sequence). For instance, if the column input is recognized as “011”, that means that the button pressed is either values ‘1’, ‘4’, ‘7’, or ‘*’. If columns is “110”, then the button pressed is either ‘3’, ‘6’, ‘9’, or ‘#’. The driver runs to determine the keypad button press on the rising edge of a clock (synchronous). The column input is determined based on when one of the column lines has no voltage, since all three columns are connected to power (hence the columns being active-low). Once a column is recognized, the rows (output) are sequentially one at a time. At each row, the driver re-checks to see if one of the columns is triggered (meaning have a ‘0’ in its three-bit input). If columns results in “111”, the driver will scan the next row. Finally on a given row when the columns input has a ‘0’ in it, then you are use the columns input and rows output to determine the button pressed on the keypad, and output that value to the seven segment display. If the key pressed is ‘*’, then the seven segment display outputs an ‘A’. If the key pressed is ‘#’, then the seven segment display outputs a ‘b’. The driver will immediately display the key pressed on the seven segment display as long as a key is physically being depressed. If no button was pressed, nothing will output on the seven segment display.
