.equ sseg = 0x81 ; find out what the data port id is for sseg display (alu_val)

.cseg
.org 0x10

		sei			 ; initialize interrupts
		mov r0, 0x3C ; sets counter to 60 seconds
main:
		out r0, sseg ; output seven seg value
		brn main 	 ; repeat if no interrupt is triggered

.org 0x20
isr:
		sub r0, 0x01 ; decrement counter 1
		brcs thing	 ; go to new branch if counter reaches 0
		retie 		 ; go back to seven seg output

thing:
		mov r0, 0x3C ; reset counter value back to 60 seconds
		retie		 ; go back to seven seg output

.org 0x3FF
		brn isr