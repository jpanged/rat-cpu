# Software Assignment 1

## Behavior Description

Our first program is supposed to take in three different inputs from a specified port, add them together, and send the output to another specified port. The data is 8-bit unsigned integers, the input port is 0x30, and the output port is 0x40.

The second program we worked on essentially returns the negative of the input in 2’s complement form. To accomplish this, we took input through port 0x30 as an 8-bit signed value. We inverted this input using an EXOR operation, added 1, and then outputted the value to port 0x40.

## Flow Chart
![alt text](https://i.imgur.com/6ZcYzPz.png?1)
