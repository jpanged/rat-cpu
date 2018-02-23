; SW 7 Part 2
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description:
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ outport = 0x42 ; output port for values
.equ inport = 0x9A ; input to take 8-bit value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x40 ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
start:
	; Initialize registers and reset stack pointer
	mov r2, 0xFF
	mov r3, 0xFF
	mov r4, 0x00
	wsp r4

input:
	in r0, inport ; Take value in
	cmp r0, 0xFF ; Check if it's FF
	breq is_ff ; If so, start outputting from stack

store:
	push r0 ; Store value on the stack
	sub r2, 0x01
	brn input ; Loop

is_ff:
	ld r1, (r3) ; Get bottom value from stack
	out r1, outport
	sub r3, 0x01
	cmp r3, r2
	brne is_ff

done:
	brn start ; Done
