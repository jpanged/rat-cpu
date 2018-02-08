; SW 5 Part 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ outport = 0x42 ; output port for values
.equ inport = 0x9A ; input to take 8-bit value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.dseg
.org 0x20 ; Where to start Fibonacci array in scratchpad

fibonacci:
	.db 0x01, 0x01, 0x02, 0x03, 0x05
	.db 0x08, 0x0D, 0x15, 0x22, 0x37
	.db 0x59, 0x90, 0xE9
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x40 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main:
	; Initialize all registers
	mov r0, 0x00 ; Count register
	mov r1, 0x20 ; Location of current Fibonacci #, initialized to where .dseg begins
	mov r2, 0x00 ; Value of current Fibonnaci
	mov r3, 0x00 ; Location of Fibonacci # 3 spots away
	mov r4, 0x00 ; Value of Fibonacci # 3 spots away, also holds subtraction result

fibonacci_diff:
	mov r3, r1 ; Copies location of current Fibonacci #
	add r3, 0x03 ; Gets location of Fibonacci # 3 spots away

	ld r2, (r1) ; Grab current Fibonacci value
	ld r4, (r3) ; Grab Fibonacci value 3 away

	sub r4, r2 ; Calculate the difference

	out r4, outport ; Output result

	add r1, 0x01 ; Increment current Fibonacci #
	
	add r0, 0x01 ; Increment counter
	cmp r0, 0x0A ; Is the count equal to 10?

	brne fibonacci_diff ; Loop until you get to the last number

output:
	brn main ; Done
