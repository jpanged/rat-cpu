# Hardware Assignment 4

## Black Box
![alt text](https://i.imgur.com/Do00eIH.png)
![alt text](https://i.imgur.com/drMYO3T.png?1)

## Behavior Description

This interrupt controller replaces our RAT 8 input button that functioned as a 1-bit interrupt. The interrupt controller has the functionality of taking in multiple sources of interrupts from different places and is a more realistic application. The interrupt controller is run on the rising edge of the clock and is reliant on 3 other 8-bit inputs: int_in, int_clr, and int_en. Int_in is an 8-bit input tied to the far left 8 switches on the Basys Board and this is where we can send the value we want to output onto our seven segment display. The 8-bit int_clr vector toggles when the program keeps searching for interrupts at a rate of two cycles (on and off) per second. The int_en is also an 8-bit input that controls which interrupts are enabled. Int_en corresponds to the other eight switches on the right side of the Basys3 board. The interrupt controller also has two outputs: int_out and int_status. The int_out is the signal that is fed into the interrupt input to the RAT MCU and int_status is the 8-bit vector that is fed into the in port of the RAT MCU.

## Specification

Hardware assignment four uses the prog_rom of an ASM that we wrote that tells the Basys3 board how to control multiple interrupts. Instead of having a single signal acting as an interrupt, we now have an interrupt controller that handles multiple sources of interrupts with the left eight switches on the board controlling its corresponding input bit order value. For instance, sw0 corresponds to whether or not the seven segment display will show sw8 value (which is the 0th bit of the input value). If the proper interrupt signals are enabled, the corresponding switch values will come together to form a decimal number that is shown on the seven segment. However as seen in our video, if you have an input of nine on the value (“00001001”) with only the 4th interrupt bit enabled (“00001000”), then the seven segment will only display decimal value eight instead of nine. Similarly if only the 1st interrupt bit is enabled (“00000001”) then the seven segment will only display decimal value one instead of eight or nine.

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/XJ0_yK-DGsw?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
