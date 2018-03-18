---
layout: default
---

# RAT CPU
This repository contains all the parts that make up the RAT CPU as well, software programs written in Assembly, and our final project where we built a basketball shot detector that runs on this computer.

## Overview
Over the course of 10 weeks, our group learned about the different parts of a typical computer system and began implementing each of those parts. The RAT CPU is a basic computer that runs in VHDL on a Basys 3 FPGA development board. This computer runs a basic set of commands in RAT Assembly, as indicated in the [RAT Assembler Manual][manual-link]. In addition to creating components for our computer, we spent time learning how to write programs in Assembly that could run on the computer we were building. These were tested in RAT Sim, simulation software that could run our code while the full computer was still being developed.

This project culminated in our final project, where we decided to take an existing basketball hoop and use a sensor with our RAT CPU in order to detect shots. Through this was project, we were able to learn how to interface with our computer in a more concrete sense and how to write programs for it.

## RAT CPU Architecture
This is the RAT architecture diagram that shows all the components of the RAT CPU and how they are connected.
![alt text][rat-architecture]

## Components
*Below is an outline of each part of this project. Click on each component to see what we did!*

### RAT MCU
* rat1 - Intro to Architecture & Assembly Language Programming (+ Reverse Engineering)
* [rat2 - Program Counter](https://jpanged.github.io/rat-cpu/rat2) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat2))
* [rat3 - Memory Fundamentals (Register File & Scratch RAM)](https://jpanged.github.io/rat-cpu/rat3) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat3))
* [rat4 - Arithmetic Logic Unit (ALU)](https://jpanged.github.io/rat-cpu/rat4) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat4))
* [rat5 - Control Unit & RAT MCU](https://jpanged.github.io/rat-cpu/rat5) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat5))
* [rat6 - RAT Wrapper](https://jpanged.github.io/rat-cpu/rat6) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat6))
* [rat7 - Stack Pointer](https://jpanged.github.io/rat-cpu/rat7) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat7))
* [rat8 - Interrupts](https://jpanged.github.io/rat-cpu/rat8) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/rat8))

### Software
* [sw1 - Intro](https://jpanged.github.io/rat-cpu/sw1) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw1))
* [sw2 - Conditional Statements](https://jpanged.github.io/rat-cpu/sw2) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw2))
* [sw3 - Loops](https://jpanged.github.io/rat-cpu/sw3) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw3))
* [sw4 - Division](https://jpanged.github.io/rat-cpu/sw4) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw4))
* [sw5 - Arrays](https://jpanged.github.io/rat-cpu/sw5) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw5))
* [sw6 - Stack](https://jpanged.github.io/rat-cpu/sw6) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw6))
* [sw7 - Subroutines](https://jpanged.github.io/rat-cpu/sw7) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw7))
* [sw8 - Interrupts](https://jpanged.github.io/rat-cpu/sw8) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/sw8))

### Hardware
* hw1 - [PWM RC DAC](https://jpanged.github.io/rat-cpu/hw1) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/hw1))
* hw2 - [Speaker Driver](https://jpanged.github.io/rat-cpu/hw2) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/hw2))
* hw3 - [Keypad Driver](https://jpanged.github.io/rat-cpu/hw3) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/hw3))
* hw4 - [Interrupt Controller](https://jpanged.github.io/rat-cpu/hw4) ([*Source*](https://github.com/jpanged/rat-cpu/tree/master/hw4))

### Final Project
* [final_project - Basketball Shot Detector](https://jpanged.github.io/rat-cpu/final_project)

## Demos
We created video demos for some of our project's components, which can be found [here.](https://jpanged.github.io/rat-cpu/demos)

<!-- Links -->
[rat-architecture]: https://i.imgur.com/mDBrb0T.jpg "RAT Architecture"
[manual-link]: https://drive.google.com/open?id=1VU7gsbydXKgvxlIF617siI2qLKeLrev5
