

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
(0005)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0006)                            || ;- Port Constants
(0007)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0008)                       066  || .equ outport = 0x42 ; output port for values
(0009)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Main program
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || .cseg
(0014)                       001  || .org  0x01 ; memory location of instruction data
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                     0x001  || main:
(0017)                            || 	; Registers for data input
(0018)  CS-0x001  0x36000         || 	mov r0, 0x00 ; Count register
(0019)  CS-0x002  0x36120         || 	mov r1, 0x20 ; Current location in scratch ram
(0020)  CS-0x003  0x36200         || 	mov r2, 0x00 ; Temp stores input for writing to scratch ram
(0021)                            || 	; Registers for bubble sort
(0022)  CS-0x004  0x36300         || 	mov r3, 0x00 ; Current location + 1
(0023)  CS-0x005  0x36400         || 	mov r4, 0x00 ; Bubble sort first value
(0024)  CS-0x006  0x36500         || 	mov r5, 0x00 ; Bubble sort second value
(0025)  CS-0x007  0x36600         || 	mov r6, 0x00 ; Used for bubble sort loop
(0026)                            || 
(0027)                     0x008  || data_in: ; Takes 10 data inputs and stores them in an array
(0028)  CS-0x008  0x3229A         || 	in r2, inport ; Data in
(0029)  CS-0x009  0x0420B         || 	st r2, (r1) ; Writes data to array
(0030)                            || 
(0031)  CS-0x00A  0x28101         || 	add r1, 0x01 ; Increment scratch ram location
(0032)                            || 
(0033)  CS-0x00B  0x28001         || 	add r0, 0x01 ; Increment counter
(0034)  CS-0x00C  0x3000A         || 	cmp r0, 0x0A ; Is the count equal to 10?
(0035)                            || 
(0036)  CS-0x00D  0x08043         || 	brne data_in ; Loop until you get to the last number
(0037)                            || 
(0038)                     0x00E  || bubble_prep: ; Gets registers ready for bubble sort
(0039)  CS-0x00E  0x36000         || 	mov r0, 0x00 ; Reset count register
(0040)  CS-0x00F  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0041)  CS-0x010  0x04309         || 	mov r3, r1 ; Copy current location
(0042)  CS-0x011  0x28301         || 	add r3, 0x01 ; Calculates location + 1 in array
(0043)                            || 
(0044)                     0x012  || bubble_loop:
(0045)  CS-0x012  0x36609         || 	mov r6, 0x09 ; Initialize loop counter
(0046)                            || 
(0047)                     0x013  || bubble_sort:
(0048)                            || 	; Get current 2 values from array
(0049)  CS-0x013  0x0440A         || 	ld r4, (r1) ; Grab current value in array
(0050)  CS-0x014  0x0451A         || 	ld r5, (r3) ; Grab next value in array
(0051)                            || 
(0052)                            || 	; See if current 2 values need to be swapped
(0053)  CS-0x015  0x04428         || 	cmp r4, r5 ; Check if order needs to be swapped
(0054)  CS-0x016  0x0A129         || 	brcc swap ; Swap if necessary
(0055)                            || 
(0056)                     0x017  || sort_check:
(0057)  CS-0x017  0x28101         || 	add r1, 0x01 ; Next location in array
(0058)  CS-0x018  0x28301         || 	add r3, 0x01 ; Next location + 1
(0059)                            || 
(0060)                            || 	; Check bubble sort loop conditions
(0061)  CS-0x019  0x28001         || 	add r0, 0x01 ; Increment count for loop
(0062)  CS-0x01A  0x30009         || 	cmp r0, 0x09 ; See if you've looped n-1 (9) times
(0063)  CS-0x01B  0x0809B         || 	brne bubble_sort ; If not, sort next 2 in array
(0064)                            || 
(0065)                            || 	; Nested loop to do 9 passes of bubble sort
(0066)                            || 	
(0067)                            || 	; Following 4 lines are duplicated code
(0068)  CS-0x01C  0x36000         || 	mov r0, 0x00 ; Reset count register
(0069)  CS-0x01D  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0070)  CS-0x01E  0x04309         || 	mov r3, r1 ; Copy current location
(0071)  CS-0x01F  0x28301         || 	add r3, 0x01 ; Calculates location + 1 in array
(0072)                            || 
(0073)  CS-0x020  0x2C601         || 	sub r6, 0x01
(0074)  CS-0x021  0x0809B         || 	brne bubble_sort
(0075)                            || 
(0076)                            || 	; Preps for output
(0077)  CS-0x022  0x36000         || 	mov r0, 0x00 ; Reset count register
(0078)  CS-0x023  0x36120         || 	mov r1, 0x20 ; Reset to first location in array
(0079)  CS-0x024  0x08140         || 	brn output ; If so, go and start outputting
(0080)                            || 
(0081)                     0x025  || swap: ; Switches values for bubble sort if second is smaller
(0082)  CS-0x025  0x0441B         || 	st r4, (r3)
(0083)  CS-0x026  0x0450B         || 	st r5, (r1)
(0084)  CS-0x027  0x080B8         || 	brn sort_check ; Continue loop for sorting
(0085)                            || 
(0086)                     0x028  || output:
(0087)  CS-0x028  0x0420A         || 	ld r2, (r1)
(0088)  CS-0x029  0x34242         || 	out r2, outport
(0089)  CS-0x02A  0x28101         || 	add r1, 0x01 ; Increment current location in array
(0090)  CS-0x02B  0x28001         || 	add r0, 0x01 ; Increment counter
(0091)  CS-0x02C  0x3000A         || 	cmp r0, 0x0A ; See if you've outputted everything in the array
(0092)  CS-0x02D  0x08143         || 	brne output ; Loop if no
(0093)  CS-0x02E  0x08008         || 	brn main ; Program done if yes, go and restart





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
BUBBLE_LOOP    0x012   (0044)  ||  
BUBBLE_PREP    0x00E   (0038)  ||  
BUBBLE_SORT    0x013   (0047)  ||  0063 0074 
DATA_IN        0x008   (0027)  ||  0036 
MAIN           0x001   (0016)  ||  0093 
OUTPUT         0x028   (0086)  ||  0079 0092 
SORT_CHECK     0x017   (0056)  ||  0084 
SWAP           0x025   (0081)  ||  0054 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0009)  ||  0028 
OUTPORT        0x042   (0008)  ||  0088 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
