# RAT Assignment 8

## Black Box
![alt text](https://i.imgur.com/U1SG6SA.png)

## Behavior Description

For this assignment, we expanded our RAT_MCU and RAT_Wrapper from RAT 7. For the RAT_MCU, we added SHAD_Z and SHAD_C modules will are in use when interrupts are triggered. In addition, we added muxes to the existing c and z-flag modules so that both modules can receive either flag inputs from the ALU or the corresponding shadow flag modules. As for the RAT_Wrapper, we added the one shot debouncer module given to us, and implemented the seven segment display module by Mealy. Similar to what we did in RAT 6 and 7, we ran a test case from PolyLearn. We first assembled the ASM files and then routed them in our MCU’s prog_rom. From there, we could see the proper result on the Basys 3 board. The explanation on how the Basys3 should properly output was describe in the beginning of the phase three test case. The verification section will explain in more detail our use of the Basys3 board shows that our entire RAT CPU is working properly.

## Context

Interrupts allow us to tell our computer to handle something immediately. If the computer is in the middle of something, an interrupt will force the computer to save its current state, handle the interrupt, then resume where it left off. This functionality is helpful for applications such as our final project, where a shot through the basketball hoop is interpreted as an interrupt by our computer. This means that the computer doesn't waste resources continually polling and checking for an input from the sensor on the hoop. It simply outputs the current shot value and then increments it if an interrupt is detected.

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/IZ5pdW3bju0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
