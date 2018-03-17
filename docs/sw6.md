# Software Assignment 6

## Behavior Description

1. This program takes values in from the user until 0xFF is received as an input. These values are stored sequentially in the stack. Once 0xFF is read in, the program starts outputting the stack values one by one starting from the last value stored (first in last out). Although the stack can store 3-bit hex values, the program only allows you to store 2-bit hex values since that is the limitation of our registers. Another limitation is that our program behaves weirdly if 0xFF is the initial input. It will loop 256 times until the count register hits 0x00.

2. This program takes values in from the user until 0xFF is read in. These values are stored sequentially in the stack. Once 0xFF is read in, the program starts outputting the stack values one by one starting from the first value stored (first in first out). To accomplish this for multiple loops of the program, we make sure to reset the stack pointer in the initialization phase. Although the stack can store 3-bit hex values, the program only allows you to store 2-bit hex values since that is the limitation of our registers. Another limitation is that our program behaves weirdly if 0xFF is the initial input. It will loop 256 times until the count register hits 0x00.

## Flow Chart
![alt text](https://i.imgur.com/NT9Ba4U.png)
