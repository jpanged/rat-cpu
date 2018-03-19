# RAT Assignment 5

## Black Box
![alt text](https://i.imgur.com/OEdc9qU.png)
![alt text](https://i.imgur.com/HnkB0TX.png)

## Behavior Description

This assignment had a couple parts. The first was creating the Control Unit for the RAT CPU, which essentially acts as the brain for the CPU, the brain of a computer. We implemented this component with an FSM, with a goal to direct signals to the right components at the right time in order to complete different instructions. These signals were based on the control signal table we were given, and various states were created to emulate the behavior we wanted. We used a value of ‘0’ if a signal for a given instruction was not applicable.

The second part of this assignment was the RAT MCU. This microcontroller essentially acts as a wrapper for all the VHDL components we have created so far in the course: program counter, reg_file, alu, control unit, and prog_rom(generated from Assembly code),. As such, the RAT MCU is consisted of port maps that connects the five modules together and to the inputs and outputs of the MCU itself. The purpose of the RAT MCU is to take a given instruction and execute it with the components it has. The full MCU should be able to execute the instructions listed in the Assembler manual, but ours in its current state only has to support a few of those, specifically IN, MOV, EXOR, OUT, and BRN. Our MCU also has an addition of c and z-flag modules that get their information from the ALU and outputs the proper flag to the control unit.

## Context

If the CPU is the brain of a computer, the control unit is the brain of our small microcontroller. It acts as the conductor of an orchestra, telling each part of the computer what to do at what time. In practice, a control unit talks directly with our other components by sending signals based on the specified opcode from the prog_rom.

The rat_mcu wraps up all the components made so far sans the scratchpad memory. By bundling everything together, we can run a very limited number of instructions. This was a good checkpoint in the project for us to see basic functionality.
