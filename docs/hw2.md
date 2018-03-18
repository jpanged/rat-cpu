# Hardware Assignment 2

## Black Box
![alt text](https://i.imgur.com/iwMCjnx.png)

## Behavior Description

Our speaker driver takes an 8-bit digital input along with a clock signal and outputs a single bit PWM signal. The goal of this module is to combine our input along with the Basys3 clock in order to output a 50% duty cycle square wave, which will allow a range of 2kHz. Because of this specification, the frequency will be limited to 3 octaves and will range from 1046Hz to 7902 Hz. The digital output pins from the PMOD pins on the Basys3 are restricted to 10-20 mA of current. To counteract for this specification, our speaker driver also utilizes an amplifier circuit, consisting of a resistor and a transistor in series to boost the current.

## Specification

The input is in the form of 8 switches (bits) on the Basys3 and a clock signal. Given the spec, our program can take switch inputs from binary values of 0 to 36. These inputs are mapped to preset frequencies given to us in the spec ranging from 1046 Hz to 7902 Hz, effectively covering 3 octaves of notes. When the input is set, the output will change on the rising clock edge.

Our clock is altered using clock divider code according to this input frequency. We find the period by dividing the input by 1, then divide that value by 10 ns to get the value for the clock divider.

For our amplifier circuit, we connected a 220Ω resistor to a 2N3904 transistor. 3.3 volts is supplied to the speaker, which is connected to the positive end of the transistor. Lastly, the negative terminal of the transistor is connected to ground.

## Demo
<iframe width="560" height="315" src="https://www.youtube.com/embed/E7abXAp9NCQ?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
