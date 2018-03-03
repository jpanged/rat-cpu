; SW 8 Part 2
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
;
; r0 - Outputs nothing if more than to consecutive inputs
; r2 - Gets the button input
; r10 - Gets switches input
; r11 - Stored register retaining previous input
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ switches = 0x9A ; input to take 8-bit value
.equ leds = 0x42 ; output port for values
.equ button = 0x9B ; button(0) which is the "reset"
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x10 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	sei
	mov r0, 0x00 ; outputs 0 if consecutive value
	mov r11, 0x00 ; initialize zero in comparison (copy) register
main:
	in r10, switches ; Take value from switches
	brn main ; keeps getting input until manual interrupt is triggered

.org 0x20
isr:
	cmp r10, r11 ; see if value is same as before
	brne output ; output value if different
	breq nothing_loop ; go into nothing_loop until reset

nothing_loop:
	in r2, button ; take a input of button
	lsr r2 ; check bit 0 of button via carry flag
	brcs reset ; if the button(0) is 1 then restart
	out r0, leds ; outputs no LEDs when stuck in loop
	brn nothing_loop ; recurs in loop until reset

reset:
	mov r11, 0x00 ; reset program values
	retie ; starts over

output:
	mov r11, r10
	out r10, leds ; outputs value
	retie; starts over

.org 0x3FF
	brn isr
