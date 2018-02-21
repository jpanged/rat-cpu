; CPE 233 Winter 2018
; Hardware Assignment 3
; Example Use Code
; This code takes in two user inputs (one digit each time from a standard keypad).
; Each time an input is taken in, two checks are done to ensure the button pressed
; is not asterisk or pound. If one or both inputs are asterisk or pound, then the
; program will output the assigned invalid value 0xFF. If neither are, then it will
; output their proper sum.
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ input = 0x20 ; input takes a keypad value
.equ output = 0x40 ; outputs the sum or error
.equ asterisk = 0x10 ; value we assign to asterisk
.equ pound = 0x11 ; value we assign to pound key
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x01 ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main:
		in r0, input ; takes in a single digit from keypad (one button press)
		cmp r0, asterisk ; sees if button pressed is asterisk
		breq invalid ; branches to output invalid value
		cmp r0, pound ; sees if button pressed is pound
		breq invalid ; branches to output invalid value
		in r1, input ;assign value from in_port to r0
		cmp r1, asterisk ; sees if button pressed is asterisk
		breq invalid ; branches to output invalid value
		cmp r1, pound ; sees if button pressed is pound
		breq invalid ; branches to output invalid value
		add r1, r0 ; sum the two value digits
		out r1, output ; outputs the sum
		brn main ; restarts for new calculation

invalid:
		mov r2, 0xFF ; Invalid display assigned value 0xFF
		out r2, output ; outputs invalid result
		brn main ; restarts for new calculation
