
## Behavior Description

1. Part one of software assignment two consisted of taking an eight-bit unsigned value input from a port. Then we checked to see whether or not the input was greater than or equal to decimal 128. To do this, we compared the input with 0x80 (128 decimal) using the CMP operator. To to satisfy the outcome, the CMP will either cause the c flag to output 0, or the z flag will output 1. If it satisfies either condition, it will branch the code to a divide by 4 function. This is done by shifting all bits to the right four times, and by clearing the carry once in between the two shifts. If the value is less than 128, then program calls a function that multiplies the input by two. This is done by shifting one bit to the left. The final result is then outputted to another port.

2. Part two of software assignment two had two decisions instead of just one in the first part. First, an eight-bit unsigned value input is assigned to a port. The program then checks if the input is odd, which is done by shifting all bits to the right and seeing if the carry equals 1. If the input is odd, decimal 17 is added to the input, and then divided by two by shifting one bit to the right. In the input is not odd, the original input is then shifted to the right one more time. If the carry is 0, then we know that the input is a multiple of four. From there, we take the input and flip all the bits by using EXOR on the input and “11111111”. If the carry turns out to be 1, then the original input is even, but not a multiple of 4. With that, we subtract the input by 1 using SUB. All three of the possible paths, whichever the program follows, will then output the result to another port.


## Flow Chart
![alt text](https://i.imgur.com/C9SINDE.png)
