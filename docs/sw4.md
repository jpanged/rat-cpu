# Software Assignment 4

## Behavior Description

1. This program takes an unsigned 8-bit input from 0x9A and divides it by 3. It accomplishes this by subtracting 3 consecutively and adding 1 to a counter until the input reaches 0 or below. The resulting number in the counter is the output divided result, sent to 0x42.

2. This program builds on the previous, but dynamically extends it to divide two numbers of your choosing. It accomplishes this by taking in two unsigned 8-bit inputs from 0x9A and storing them in two separate registers. The second number is subtracted consecutively from the first, and 1 added to a count register until the first number reaches 0 or below. The resulting number in the counter is the result of division of the first input by the second. Output is sent to 0x42. For a case where the user is trying to divide by 0, the program will automatically branch and output 0.




## Flow Chart
![alt text](https://i.imgur.com/FxZxT8F.png)
