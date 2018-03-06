; HW 4 Part 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
;
; r1 - takes in the switches input value
; r2 - takes in the interrupt switches value
; r3 - bit exor to blink led(0) twice in a sec
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ int_en = 0x42 ;
.equ int_clr = 0x41 ;
.equ switches = 0x20 ;
.equ int_status = 0x21 ;
.equ seg_id = 0x81 ;
.equ leds_id = 0x40 ;
.equ time_OUTSIDE_FOR_COUNT = 0xFF ;
.equ time_MIDDLE_FOR_COUNT = 0xFF ;
.equ time_INSIDE_FOR_COUNT= 0x60 ;
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Code
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x10 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	sei
main:
	in r1, switches ; gets switches input
	out r1, int_en ; outputs switches value
	exor r3, 0x01 ; toggles led(0) to get it to blink
	out r3, leds_id ; outputs the led(0) status
	call delay ; calls delay only once because led needs to blink twice in a second
	brn main ; starts over if no interrupt is called

.org 0x70
isr:
	in r2, int_status ; reads the interrupt value
	out r2, seg_id ; outputs interrupt value on sseg
	call delay ; calls four delays for a 1s total delay
	call delay
	call delay
	call delay
	retie ; starts over and resets interrupt

delay: ; delays for half a second per call
				MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
outside_for:    SUB     R29, 0x01

				MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
middle_for:     SUB     R28, 0x01

				MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
inside_for: 	SUB     R27, 0x01
				BRNE    inside_for

				OR      R28, 0x00               ;load flags for middle for counter
				BRNE    middle_for

				OR      R29, 0x00               ;load flags for outsde for counter value
				BRNE    outside_for
				RET
.org 0x3FF
	brn isr
