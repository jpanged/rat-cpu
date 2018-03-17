# Software Assignment 6

## Behavior Description

1. This program is designed to visualize an interrupt when triggered. The program takes an input, and will continue to get a new input until an interrupt is triggered. Once the interrupt is triggered, it will check to see if the input value has changed since the previous interrupt. If the value changed, the LEDS will show the new input value. If the input value did not change between two consecutive interrupts, the LEDS output will alternate displaying its value and nothing. This will occur until a different value is read from the input when the interrupt is triggered.
2. The second part of this software assignment acts like the first part in the sense that the program continually reads input values until an interrupt is triggered. When the interrupt is triggered, the program will output exactly what the input is showing. If however a second interrupt is called and the input value didn’t change, then the program will get stuck in a loop and continually output nothing (0x00) until a reset button is pushed (or in the case of RAT, the bit 0 of button is a ‘1’). When button(0) is ‘1’, then the program resets and starts over.

## Flow Chart
![alt text](https://i.imgur.com/10B0jjT.png)
![alt text](https://i.imgur.com/xNzejWi.png)
