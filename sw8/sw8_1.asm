; SW 8 Part 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description:
;
; r0 - Keeps track of current LED state: 0x00 = off, 0x01 = on
; r1 - Gets values from switches
; r2 - Current output (either switches or off)
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ switches = 0x9A ; input to take 8-bit value
.equ leds = 0x42 ; output port for values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x10 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	sei
	mov r0, 0x00
	mov r2, 0x00
main:
	in r1, switches ; Take value from switches
	brn main ; Loop

.org 0x20
isr:
	cmp r0, 0x00
	breq on_out
	brn off_out

on_out: 
	mov r0, 0x01
	mov r2, r1
	brn output

off_out: 
	mov r0, 0x00
	mov r2, 0x00
	brn output

output:
	out r2, leds ; Output
	retie

.org 0x3FF
	brn isr
