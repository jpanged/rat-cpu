# RAT Assignment 2

## Black Box
![alt text](https://i.imgur.com/s7pO2Zp.png)

![alt text](https://github.com/jpanged/rat-cpu/blob/master/rat2/rat2%20Black%20Box.png)

## Behavior Description

Our program counter takes a 10-bit digital input along with a program counter load, program counter increment, reset and clock signal. The input to the program counter is dependent upon the output of our 4:1 mux. The inputs to the mux include a 10-bit FROM_IMMED signal to input mux select # 0, a 10-bit FROM _STACK signal to the input mux select #1, a hex value of 0x3FF to input mux select #2, and a 10-bit ‘0’ vector going into mux select line #3 of the mux. The output of the mux is dependent upon the 2-bit signal from PC_MUX_SEL.
