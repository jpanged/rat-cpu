# RAT Assignment 4

## Black Box
![alt text](https://i.imgur.com/X1wfKlt.png)

## Behavior Description

The rat_alu module takes in two 8-bit inputs with the option of a carry in, as well as a 4-bit select signal. The select signal input tells us which of 15 different arithmetic operations to use on the two 8-bit inputs. As a result, the ALU outputs the final answer given the specifications, as well as a carry flag in the case of underflow or overflow and z flag should the result be a zero.

Our ALU can perform the following operations: add, addc, sub, subc, cmp, and, or, exor, test, lsl, lsr, rol, ror, asr, and mov. Given the select signal, we use case statements to perform the specific operation on the inputs.

For example, given a is 0x35, b is 0x13, c_in is 0, and sel is 0x02, then the sum is 0x22 with c_flag and z_flag both equal to zero for the subtract operation.

## Context

The arithmetic logic unit (ALU), like the name implies, exists to perform simple operations on two inputs. Its functionality allows our computer to do basic calculations and manipulate numbers in a variety of different ways. The ALU's basic operations can be combined to do more complex things. For example, adding multiple times allows you to essentially multiply numbers, while subtracting consecutively allows you to divide with a remainder.
