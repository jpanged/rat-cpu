; CPE 233 Winter 2018
; Hardware Assignment 2
; Example Use Code
; This code takes in a user value, delays for half a second then
; outputs the value. Users can specify the frequency they want to
; set the speaker driver, and this RAT program will send that to 
; our hardware component

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ out_port = 0x42 ; output port for values
.equ in_port = 0x9A ; input to take 8-bit value
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x01 ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main:
			in r0, in_port ;assign value from in_port to r0
			mov r5, r0 ; Input low note value
			mov r1, 0x60   ;initialize delay_1 loop counter
outer_loop:	
			mov r2, 0xFE   ;initialize delay_2 loop counter
middle_loop:
			mov r3, 0xFF   ;initialize delay_3 loop counter

inner_loop:	sub r3, 0x01   ;subtract 1 from r3
			brne inner_loop

			sub r2, 0x01   ;subtract 1 from r2
			brne middle_loop

			sub r1, 0x01    ;subtract 1 from r1
			brne outer_loop   

			out r0, out_port ; send value from r0 to out_port
			brn main
