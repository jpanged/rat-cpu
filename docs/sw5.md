# Software Assignment 5

## Behavior Description

1. This program holds the first thirteen values of the fibonacci sequence (starting with 1) stored in the scratch ram via data byte (.db). The program then cycles through all the numbers to conduct ten different calculations of the difference between a value and three values after that in the sequence. This is done by loading the corresponding values into separate registers, then subtracting one from another, and finally outputting the difference. Another register is made to increment by one so that the program knows to restart after 10 calculations.

2. This program takes in an array of ten hexadecimal values one by one. Once all ten inputs have been read and written into the program, the assembler sorts the array using the bubble sort method. This is accomplished by comparing the current value (starts at beginning of array) and the value right next to it. It either stays the same or switches if the first comes after the second. It iterates by comparing each value by the one right after it. Bubble sort is complete after n-1 passes. In our case, this is 9 passes. After the sorting, the assembler outputs the array one at a time starting from the first value to the last. At this point, the output should be a sorted version of the inputs.

## Flow Chart
![alt text](https://i.imgur.com/DRJJMSm.png)
