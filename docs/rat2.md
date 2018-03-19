# RAT Assignment 2

## Black Box
![alt text](https://i.imgur.com/s7pO2Zp.png)

## Behavior Description

Our program counter takes a 10-bit digital input along with a program counter load, program counter increment, reset and clock signal. The input to the program counter is dependent upon the output of our 4:1 mux. The inputs to the mux include a 10-bit FROM_IMMED signal to input mux select # 0, a 10-bit FROM _STACK signal to the input mux select #1, a hex value of 0x3FF to input mux select #2, and a 10-bit ‘0’ vector going into mux select line #3 of the mux. The output of the mux is dependent upon the 2-bit signal from PC_MUX_SEL. The output of the pc_wrapper is the next line the computer will run.

## Context
The purpose of a program counter is for the computer to keep track of where it is in a program sequence. Each line of an instruction in an Assembly program is given a number. When going through a program, this is the component that tells the computer where to find what to do next. This is usually the next instruction in a sequence (from_immed), but can also be a line in the program you want to return to after branching from something else (from_stack), or when you want to deal with an interrupt (0x3FF).

Once the computer knows which line to run next, the pc_count is usually taken in by the prog_rom, which will then determine which instruction (by opcode) to fetch and execute based on the line number. Additionally, the pc_count may be stored by the scratch ram if the program needs to return to the current line in the future (e.g. branching).
