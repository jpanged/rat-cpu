# Final Project: Basketball Shot Detector

## Introduction
Our final project is a basketball hoop that detects when a shot is made using a Google Cloud hoop and basketball. We mounted a Sharp GP2Y0A41SK0F distance measuring sensor right below the rim of the hoop. Using an Arduino Nano essentially as a sensor debouncer, we wrote code to determine what constitutes a valid shot through the hoop. This is accomplished in a couple steps. We determined which distance ranges in front of the sensor we got when the ball was right in front of the sensor versus at the far end of the rim. If that condition was met, we then checked how long the sensor was triggered. We threw the ball through the hoop numerous times in multiple conditions to get sample data on how long it would take the ball to fall through, then checked the minimum and maximum of these ranges to confirm a shot.

If a shot is confirmed, we send a digital output from the Arduino into a PMOD port of the Basys. Our RAT MCU treats this input signal as an interrupt signal, which goes into a one shot component to register the signal. This confirmed interrupt signal is then sent into the CPU, and our ISR branch in the Assembly code increments a counter that displays on the seven segment display. Additionally, the digital output is used to light up 2 LEDs mounted on the front of the basketball hoop for visual confirmation of a shot. Finally, for good measure, we also confirm the shot with an audio output through a small speaker which plays a Mario themed sound. The seven segment display keep incrementing with every shot until the middle reset button is pressed on the Basys board, which resets the counter to zero. The seven segment display currently allows values up to 99 to be outputted, meaning users can make up to 255 shots before needing to reset the counter.

The sensor is checked on the Arduino according to a baud rate of 9600. A confirmed shot is in front of the sensor approximately between 4 cm and 16 cm. A confirmed shot approximately lasts between 87 and 747 loop cycles according to our sample of data. Limitations to a confirmed shot include false positives when the net gets in the way of the sensor or the rim gets hit without the ball going in. The former happens infrequently while the latter is more of an issue. In addition, the sensor can only detect shots right in front of it. While we thought this would be an issue for balls going in at the left and right edges of the rim, it ended up not really being an issue at all. In real world situations, the ball rarely goes straight in from the left or right. It usually clips the left or right of the rim which ricochets it back towards the middle, which then registers as a shot. As a result, this ended up not being a big limitation to our project.

Any users who are interested in learning more about distance sensors and working with interrupts on the RAT MCU might look into our project, as it uses interrupts in a fun way while integrating some interesting hardware components.

## Operation
Once connected properly, general operation of our hoop detector is simple. Throw a basketball or other object through the hoop, and you will see the LEDs light up, speaker play a Mario tone, and seven segment display increment if the shot is made. Our program is currently written to support the Google Cloud basketball based on its dimensions. Smaller objects may not register properly if they are thrown on the far side of the sensor. When the user is ready to reset the device, they just need to press the middle reset button on the Basys board to zero the counter. If the ball misses the hoop, nothing happens.

Two boards are used for the scope of this project: an Arduino Nano and a Basys 3 board. The Basys gets power from the external micro USB port connected to a USB port on a computer and the Arduino is powered externally from three AA batteries. The Arduino supports three additional peripherals: a Piezo buzzer, Sharp distance sensor, and LEDs. Another feature of our circuit is the implementation of two switches designed to turn on/off the Arduino and the buzzer. Communication between the Arduino and Basys is initiated through a 1-bit signal sent out from the D2 digital output pin on the Arduino and into the JA1 PMOD pin into the Basys.

## Peripheral Details
Like mentioned previously, the Sharp GP2Y0A41SK0F is an additional peripheral that we used for our project. It is a distance measuring sensor unit that outputs a voltage corresponding to the distance it detects. Once this data goes into the Arduino, quick math is performed to determine the distance in centimeters. It has a short measuring cycle of 16.5 ms, range of 4 to 30 cm, and outputs an analog signal. It has an operating voltage range of 4.5 to 5.5 volts. For the purposes of our project, we’re using its distance sensing capabilities to register a confirmed shot through the basketball hoop based on a specific distance range as well as time the sensor is activated.

In addition, we used the piezo buzzer from a previous hardware assignment and a couple LEDs. The buzzer isn’t new, but the LEDs are. To hook it up, we connected  the cathode to ground and the anode in series with a 1000 ohm resistor and then to the digital output of the Arduino. Our AA external power source and buzzer are both connected to switches, which allow us to turn the Arduino on as well as the buzzer off.

## Software Design
For our VHDL, we made modifications to our RAT wrapper routing and added a new component into the wrapper. We added a new component called “game_clock.vhd”. As seen in figure 1, “Game_clock.vhd” is the module that handles the processing of our interrupt, or in common terms our “one shot.” “Game_clock.vhd” takes in inputs “interrupt_temp” and “clk” and has an output “interrupt.” This module has two processes: a synchronous clock process and a combinational process. As seen in figure 1, the combinational process contains an fsm that changes state when an interrupt is received. Once an interrupt is received, the signal stays high for two clock cycles (or two fsm states), and then the interrupt is reset on the fourth (last) state. As a one-shot catch-all, the fsm will not return to the first fsm state until the actual received interrupt signal goes back to zero. This prevents our score counter from incrementing at random times and intervals. Also the reason for interrupt to be set high for two clock cycles is because you want the interrupt to be seen through one fetch and one execute. If the interrupt just stays high for one clock cycle, the interrupt may reset and start looking at a fetch state, ultimately causing interrupt reading issues. As for the synchronous process, it just ensures that the fsm reads instructions and moves on the rising clock edge.

As you can see in the above black box diagram, we have the “arduino_in” input in the “RAT_wrapper” physically connected to the PMOD JA1 pin on the Basys board. This input gets an interrupt signal via wire connection from an Arduino Nano on a breadboard. The “arduino_in” sends a signal to the “interrupt_temp” input of “game_clock.vhd.” In “game_clock.vhd,” the module will process the interrupt with the one shot we created. Once processed, the interrupt output of the “game_clock.vhd” will be sent to the “int_mcu” input of the cpu. The “RAT_cpu” component will handle the interrupt following the specifications we wrote in our Assembly program. The assembly program will be talked about in detail later. Once the component knows what to do with the interrupt, data is sent out of the output “out_port” and into the “alu_val” input of the seven segment display. Lastly, we used Mealy’s seven segment display to output the proper value (score) count via the correct “disp_en” and “segments” outputs which are then routed to the “digit” and “seg” outputs of the “Rat_wrapper.” These outputs are then reflected onto the actual display of the Basys 3 seven segment display.

As seen in figure 4, we wrote a simple assembly program that initializes interrupt and resets the score count register at the start of the program. The assembly file will continually output the register value (score holder) until an interrupt is triggered. When an interrupt is triggered, a value of 0x01 is added to the register, and then the program returns back to the main code where it continues to output the register value until another interrupt is triggered. Adding a value of one to the register is our way of incrementing the score by one point when a basket is made. The prog_rom generated from the assembly file is placed into the “RAT_cpu.”

## Further Development
One thing we worked on was designed a printed circuit board (PCB) that connects the Arduino and all its peripherals and housed in an empty Altoids tin. Because of the project’s time constraints, we weren’t able to get it working for the deadline. Despite this, we believe we are close and could complete this with more time. Working on a PCB from scratch really showed us some of the challenges associated with hardware work. We suddenly had so many more considerations because of the physical limitations.

Finally, we worked on a static project website to organize all the work we did this quarter. While it is still a work in progress, we are aiming to have a page for each RAT, hardware, and software assignment with more information about what we did.