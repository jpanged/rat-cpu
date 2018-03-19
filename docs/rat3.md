# RAT Assignment 3

## Black Box
![alt text](https://i.imgur.com/jVeVp5F.png)
![alt text](https://i.imgur.com/2Pv27ze.png)

## Behavior Description

We have 2 components for this assignment: A register file and scratchpad memory.

The register file (a 32x8 dual port RAM) takes in an 8-bit data signal input, 2 5-bit address inputs (ADRX and ADRY), a 1-bit write signal input, and a clock signal. This program has two 8-bit outputs, DX_OUT and DY_OUT, respectively. The X address is specific to the write and read functions, while the Y address is limited to reading only. The register file is read asynchronously (independent of clock) and is written to synchronously (on the rising edge of each clock cycle).

The scratch RAM takes a 10-bit data signal input, an 8-bit address input, a 1-bit write signal input, and a clock signal. This program has a 10-bit output, DATA_OUT. If SCR_WE is high (‘1’) then the 10-bit data from the input is sent to the output of this program. Just like the register file above, the scratch RAM is read asynchronously (independent of clock) and is written to synchronously (on the rising edge of each clock cycle).

## Context

A register file in our computer stores information that can accessed and modified. Like variables in a higher level language, we can write Assembly code which modifies a specific register by assigning values, performing arithmetic operations on existing values, and even copying values, among other things. By providing the register address, this component will give you the value currently stored there.

Scratchpad memory is generally used to temporarily store data the computer is currently working on. This can be calculations done by the ALU, data referred to by the stack pointer, or instruction locations pushed by the program counter. Data can be up to 10 bits wide according to our architecture and 256 locations deep.
