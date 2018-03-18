# Hardware Assignment 1
<font color="red"><a href="https://github.com/jpanged/rat-cpu/tree/master/hw1" class="btn">Source Code</a></font>

## Black Box
![alt text](https://i.imgur.com/tgZzCk0.png)

## Behavior Description

Our pwm_dac takes an 8-bit digital input along with a reset and clock signal and outputs a single bit PWM signal. The goal of this module is to combine our input along with the Basys3 clock in order to output a variable duty cycle, which emulates how analog signals work. Enabling reset will set the output to 0% duty cycle. Our pwm_dac also utilizes a resistor and a capacitor in series to create a low pass filter. This low pass filter takes in our pulse width modulation signal and outputs an analog signal containing only low frequencies and “filters” out or omits the high frequencies through the grounded capacitor.

## Specification

The input is in the form of 8 switches (bits) on the Basys3, and the reset signal is programed to the center tactile button. Because the input ranges from 0 to 255, every duty cycle is a fraction over 256, and the maximum duty cycle is 255/256, or 99.6%. When the input is set, the output will change on the rising clock edge. Reset is synchronous to bypass timing issues.

For our low pass filter, we put a 1.6kΩ resistor in series with a 100 nF capacitor. The capacitor end was set to ground, and the resistor end was connected to our PWM_DAC output.

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/V1hWBMGBrVU?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
