; SW 8 Part 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description: 
;
; r0 - 
; r1 - 
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ inport = 0x9A ; input to take 8-bit value
.equ outport = 0x42 ; output port for values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x40 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
start:
	in r0, inport ; Take value in
	mov r1, 0x00 ; Reset the counter
	call div_by_10
	mov r2, r0 ; Stores the 1's values
	mov r0, r1
	mov r1, 0x00 ; Reset the counter
	call div_by_10
	mov r3, r0 ; Stores the 10's values
	mov r4, r1 ; Stores the 1's values

done: ; Output all values
	out r4, hundredout
	out r3, tenout
	out r2, oneout
	brn start ; Done

div_by_10:
	cmp r0, 0x0A
	brcs less_than_10

	sub r0, 0x0A ; Subtract 10
	add r1, 0x01 ; Add 1 to count
	cmp r0, 0x0A ; See if value less than 10
	brcc div_by_10 ; Done when MSB underflows
	ret

less_than_10:
	ret
