

List FileKey 
----------------------------------------------------------------------
C1      C2      C3      C4    || C5
--------------------------------------------------------------
C1:  Address (decimal) of instruction in source file. 
C2:  Segment (code or data) and address (in code or data segment) 
       of inforation associated with current linte. Note that not all
       source lines will contain information in this field.  
C3:  Opcode bits (this field only appears for valid instructions.
C4:  Data field; lists data for labels and assorted directives. 
C5:  Raw line from source code.
----------------------------------------------------------------------


(0001)                            || ; SW 5 Part 2
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ; 
(0007)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0008)                            || ;- Port Constants
(0009)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0010)                       066  || .equ outport = 0x42 ; output port for values
(0011)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || ;- Main program
(0014)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0015)                            || .cseg
(0016)                       001  || .org  0x01 ; memory location of instruction data
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                     0x001  || main:
(0019)                            || 	; Registers for data input
(0020)  CS-0x001  0x36000         || 	mov r0, 0x00 ; Count register
(0021)  CS-0x002  0x36120         || 	mov r1, 0x20 ; Current location in scratch ram
(0022)  CS-0x003  0x36200         || 	mov r2, 0x00 ; Temp stores input for writing to scratch ram
(0023)                            || 	; Registers for bubble sort
(0024)  CS-0x004  0x36300         || 	mov r3, 0x00 ; Current location + 1
(0025)  CS-0x005  0x36400         || 	mov r4, 0x00 ; Bubble sort first value
(0026)  CS-0x006  0x36500         || 	mov r5, 0x00 ; Bubble sort second value
(0027)  CS-0x007  0x36600         || 	mov r6, 0x00 ; Used for bubble sort loop
(0028)                            || 
(0029)                     0x008  || data_in: ; Takes 10 data inputs and stores them in an array
(0030)  CS-0x008  0x3229A         || 	in r2, inport ; Data in
(0031)  CS-0x009  0x0420B         || 	st r2, (r1) ; Writes data to array
(0032)                            || 
(0033)  CS-0x00A  0x28101         || 	add r1, 0x01 ; Increment scratch ram location
(0034)                            || 
(0035)  CS-0x00B  0x28001         || 	add r0, 0x01 ; Increment counter
(0036)  CS-0x00C  0x3000A         || 	cmp r0, 0x0A ; Is the count equal to 10?
(0037)  CS-0x00D  0x08043         || 	brne data_in ; Loop until you get to the last number
(0038)                            || 
(0039)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0040)                            || 
(0041)                     0x00E  || bubble_prep: ; Gets registers ready for bubble sort
(0042)  CS-0x00E  0x36000         || 	mov r0, 0x00 ; Reset count register
(0043)  CS-0x00F  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0044)  CS-0x010  0x04309         || 	mov r3, r1 ; Copy current location
(0045)  CS-0x011  0x28301         || 	add r3, 0x01 ; Calculates location + 1 in array
(0046)                            || 
(0047)                     0x012  || bubble_loop:
(0048)  CS-0x012  0x36609         || 	mov r6, 0x09 ; Initialize loop counter
(0049)                            || 
(0050)                     0x013  || bubble_sort:
(0051)                            || 	; Get current 2 values from array
(0052)  CS-0x013  0x0440A         || 	ld r4, (r1) ; Grab current value in array
(0053)  CS-0x014  0x0451A         || 	ld r5, (r3) ; Grab next value in array
(0054)                            || 
(0055)                            || 	; See if current 2 values need to be swapped
(0056)  CS-0x015  0x04428         || 	cmp r4, r5 ; Check if order needs to be swapped
(0057)  CS-0x016  0x0A129         || 	brcc swap ; Swap if necessary
(0058)                            || 
(0059)                     0x017  || sort_check:
(0060)  CS-0x017  0x28101         || 	add r1, 0x01 ; Next location in array
(0061)  CS-0x018  0x28301         || 	add r3, 0x01 ; Next location + 1
(0062)                            || 
(0063)                            || 	; Check bubble sort loop conditions
(0064)  CS-0x019  0x28001         || 	add r0, 0x01 ; Increment count for loop
(0065)  CS-0x01A  0x30009         || 	cmp r0, 0x09 ; See if you've completed 1 pass
(0066)  CS-0x01B  0x0809B         || 	brne bubble_sort ; If not, sort next 2 in array
(0067)                            || 
(0068)                            || 	; Prep for nested loop
(0069)  CS-0x01C  0x36000         || 	mov r0, 0x00 ; Reset count register
(0070)  CS-0x01D  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0071)  CS-0x01E  0x04309         || 	mov r3, r1 ; Copy current location
(0072)  CS-0x01F  0x28301         || 	add r3, 0x01 ; Calculates location + 1 in array
(0073)                            || 
(0074)                            || 	; Keeps track of nested loop to do 9 passes for bubble sort
(0075)  CS-0x020  0x2C601         || 	sub r6, 0x01
(0076)  CS-0x021  0x0809B         || 	brne bubble_sort
(0077)                            || 
(0078)                            || 	; Preps for output
(0079)  CS-0x022  0x36000         || 	mov r0, 0x00 ; Reset count register
(0080)  CS-0x023  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0081)  CS-0x024  0x08140         || 	brn output ; If so, go and start outputting
(0082)                            || 
(0083)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0084)                            || 
(0085)                     0x025  || swap: ; Switches values for bubble sort if second is smaller
(0086)  CS-0x025  0x0441B         || 	st r4, (r3)
(0087)  CS-0x026  0x0450B         || 	st r5, (r1)
(0088)  CS-0x027  0x080B8         || 	brn sort_check ; Continue loop for sorting
(0089)                            || 
(0090)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0091)                            || 
(0092)                     0x028  || output:
(0093)  CS-0x028  0x0420A         || 	ld r2, (r1)
(0094)  CS-0x029  0x34242         || 	out r2, outport
(0095)  CS-0x02A  0x28101         || 	add r1, 0x01 ; Increment current location in array
(0096)  CS-0x02B  0x28001         || 	add r0, 0x01 ; Increment counter
(0097)  CS-0x02C  0x3000A         || 	cmp r0, 0x0A ; See if you've outputted everything in the array
(0098)  CS-0x02D  0x08143         || 	brne output ; Loop if no
(0099)  CS-0x02E  0x08008         || 	brn main ; Program done if yes, go and restart





Symbol Table Key 
----------------------------------------------------------------------
C1             C2     C3      ||  C4+
-------------  ----   ----        -------
C1:  name of symbol
C2:  the value of symbol 
C3:  source code line number where symbol defined
C4+: source code line number of where symbol is referenced 
----------------------------------------------------------------------


-- Labels
------------------------------------------------------------ 
BUBBLE_LOOP    0x012   (0047)  ||  
BUBBLE_PREP    0x00E   (0041)  ||  
BUBBLE_SORT    0x013   (0050)  ||  0066 0076 
DATA_IN        0x008   (0029)  ||  0037 
MAIN           0x001   (0018)  ||  0099 
OUTPUT         0x028   (0092)  ||  0081 0098 
SORT_CHECK     0x017   (0059)  ||  0088 
SWAP           0x025   (0085)  ||  0057 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0011)  ||  0030 
OUTPORT        0x042   (0010)  ||  0094 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
