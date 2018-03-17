# Software Assignment 3

## Behavior Description

1. This program takes in an 8-bit unsigned value from port 0x9A, divides the 8-bit input values into 2 separate 4-bit unsigned values. Then, the program multiplies the upper and lower 4-bits together and sends the output to port 0x42.

2. The program takes in an 8-bit value from port 0x9A, and creates a 0.5 second delay before outputting the value to port 0x42. For a 0.5 second delay on a 50 MHz clock, we needed to complete 12,500,000 instructions in the program. Incorporating nested loops within the program allows the desired number of instructions to be executed in a more efficient way.



## Flow Chart
![alt text](https://i.imgur.com/yrDXvm0.png)
