; SW 5 Part 2
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang
; Description:
; 
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
	; Registers for data input
	mov r0, 0x00 ; Count register
	mov r1, 0x20 ; Current location in scratch ram
	mov r2, 0x00 ; Temp stores input for writing to scratch ram
	; Registers for bubble sort
	mov r3, 0x00 ; Current location + 1
	mov r4, 0x00 ; Bubble sort first value
	mov r5, 0x00 ; Bubble sort second value
	mov r6, 0x00 ; Used for bubble sort loop

data_in: ; Takes 10 data inputs and stores them in an array
	in r2, inport ; Data in
	st r2, (r1) ; Writes data to array

	add r1, 0x01 ; Increment scratch ram location

	add r0, 0x01 ; Increment counter
	cmp r0, 0x0A ; Is the count equal to 10?
	brne data_in ; Loop until you get to the last number

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

bubble_prep: ; Gets registers ready for bubble sort
	mov r0, 0x00 ; Reset count register
	mov r1, 0x20 ; Reset to first location in array
	mov r3, r1 ; Copy current location
	add r3, 0x01 ; Calculates location + 1 in array

bubble_loop:
	mov r6, 0x09 ; Initialize loop counter

bubble_sort:
	; Get current 2 values from array
	ld r4, (r1) ; Grab current value in array
	ld r5, (r3) ; Grab next value in array

	; See if current 2 values need to be swapped
	cmp r4, r5 ; Check if order needs to be swapped
	brcc swap ; Swap if necessary

sort_check:
	add r1, 0x01 ; Next location in array
	add r3, 0x01 ; Next location + 1

	; Check bubble sort loop conditions
	add r0, 0x01 ; Increment count for loop
	cmp r0, 0x09 ; See if you've completed 1 pass
	brne bubble_sort ; If not, sort next 2 in array

	; Prep for nested loop
	mov r0, 0x00 ; Reset count register
	mov r1, 0x20 ; Reset to first location in array
	mov r3, r1 ; Copy current location
	add r3, 0x01 ; Calculates location + 1 in array

	; Keeps track of nested loop to do 9 passes for bubble sort
	sub r6, 0x01
	brne bubble_sort

	; Preps for output
	mov r0, 0x00 ; Reset count register
	mov r1, 0x20 ; Reset to first location in array
	brn output ; If so, go and start outputting

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

swap: ; Switches values for bubble sort if second is smaller
	st r4, (r3)
	st r5, (r1)
	brn sort_check ; Continue loop for sorting

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

output:
	ld r2, (r1)
	out r2, outport
	add r1, 0x01 ; Increment current location in array
	add r0, 0x01 ; Increment counter
	cmp r0, 0x0A ; See if you've outputted everything in the array
	brne output ; Loop if no
	brn main ; Program done if yes, go and restart
