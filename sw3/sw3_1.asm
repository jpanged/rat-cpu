; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ outport = 0x42 ; output port for values
.equ inport = 0x9A ; input to take 8-bit value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x01 ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main:
	in r0, inport
	mov r10, 0x04
	mov r1, 0x00
	
split_bits:
	clc
	lsr r0
	lsr r1
	sub r10, 0x01
	brne split_bits
	
shift_register:
	lsr r1
	lsr r1
	lsr r1
	lsr r1

	mov r2, r1
	sub r0, 0x01

multiply:
	add r2, r1
	sub r0, 0x01
	brne multiply

	out r2, outport
	brn main
