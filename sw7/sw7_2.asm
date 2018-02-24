; SW 7 Part 2
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description: This program takes 2 8-bit inputs and multiplies them together.
;				It keeps track of the results up to 16 bits, with the high 8
;				and low 8 bits in separate registers. 
;
; r0 - value 1
; r1 - value 2 (count)
; r2 - low 8 bits (ongoing result)
; r3 - high 8 bits
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ highout = 0x41 ; Output for high 8 bits
.equ lowout = 0x42 ; Output for low 8 bits
.equ inport = 0x9A ; Input to take 8-bit value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x40 ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
start:
	in r0, inport ; Get value 1
	in r1, inport ; Get value 2
	; reset registers
	mov r2, 0x00
	mov r3, 0x00
	; Check if either input is zero
	cmp r0, 0x00
	breq output
	cmp r1, 0x00
	breq output

multiply: ; Multiplies two numbers while keeping track of overflow
	call add_over
	sub r1, 0x01 ; Decrement counter
	brne multiply ; Loop if multiplication not done

output: ; Output high 8 and low 8 to specified ports
	out r2, lowout
	out r3, highout

done:
	brn start ; Done

add_over: ; Subroutine that adds while keeping track of overflow
	add r2, r0 ; Add value 1 to ongoing low 8 result
	addc r3, 0x00 ; See if the operation overflowed. If so, increment high 8
	ret
