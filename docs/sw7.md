# Software Assignment 7

## Behavior Description

1. This program takes an 8-bit input and converts hexadecimal into a binary coded decimal format using division. It accomplishes this through the use of a subroutine that divides a number by 10. After the first division operator, the remainder is stored as the 1’s value while the quotient becomes the dividend. The divide operation is repeated. Now the remainder is stored as the 10’s value while the quotient becomes the 100’s value. All three values are outputted into separate outports.

2. This program takes 2 8-bit inputs and multiplies them together. It keeps track of the results up to 16 bits, with the high 8 and low 8 bits in separate registers. Our program accomplishes this through the use of a subroutine that adds 2 8-bit registers. We have 2 registers; one keeps track of the result, while the other keeps track of the overflow. In this manner we are able to store a 16 bit result. To multiply, we loop through this subroutine until the operation is completed. Results are outputted from these two registers to two separate outports.

## Flow Chart
![alt text](https://i.imgur.com/C2xLWWA.png)
![alt text](https://i.imgur.com/rNiDFSm.png)
