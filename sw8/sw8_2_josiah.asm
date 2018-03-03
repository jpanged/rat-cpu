; SW 8 Part 2
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description:
;
; r0 -
; r2 - Keeps track of last output
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ switches = 0x9A ; input to take 8-bit value
.equ leds = 0x42 ; output port for values
.equ btn = 0x9B
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x10 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	sei
    mov r2, 0x00
main:
	in r1, switches ; Take value from switches
	brn main ; Loop

.org 0x20
isr:
	cmp r1, r2 ; Is current input the same as previous output?
	breq consecutive ; If so, stop outputting!
	brn output ; If not, output!

consecutive:
    mov r2, 0x00
    out r2, leds
    in r3, btn ; Get current btn input
	lsr r3 ; Check btn(0)
    brcc consecutive
    retie

output:
    mov r2, r1
	out r2, leds ; Output
	retie

.org 0x3FF
	brn isr
