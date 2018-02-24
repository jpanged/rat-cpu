

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


(0001)                            || ; SW 7 Part 2
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description: This program takes 2 8-bit inputs and multiplies them together.
(0006)                            || ;				It keeps track of the results up to 16 bits, with the high 8
(0007)                            || ;				and low 8 bits in separate registers. 
(0008)                            || ;
(0009)                            || ; r0 - value 1
(0010)                            || ; r1 - value 2 (count)
(0011)                            || ; r2 - low 8 bits (ongoing result)
(0012)                            || ; r3 - high 8 bits
(0013)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0014)                            || ;- Port Constants
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                       065  || .equ highout = 0x41 ; Output for high 8 bits
(0017)                       066  || .equ lowout = 0x42 ; Output for low 8 bits
(0018)                       154  || .equ inport = 0x9A ; Input to take 8-bit value
(0019)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0020)                            || ;- Main program
(0021)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0022)                            || .cseg
(0023)                       064  || .org  0x40 ; memory location of instruction data
(0024)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0025)                     0x040  || start:
(0026)  CS-0x040  0x3209A         || 	in r0, inport ; Get value 1
(0027)  CS-0x041  0x3219A         || 	in r1, inport ; Get value 2
(0028)                            || 	; reset registers
(0029)  CS-0x042  0x36200         || 	mov r2, 0x00
(0030)  CS-0x043  0x36300         || 	mov r3, 0x00
(0031)                            || 	; Check if either input is zero
(0032)  CS-0x044  0x30000         || 	cmp r0, 0x00
(0033)  CS-0x045  0x0825A         || 	breq output
(0034)  CS-0x046  0x30100         || 	cmp r1, 0x00
(0035)  CS-0x047  0x0825A         || 	breq output
(0036)                            || 
(0037)                     0x048  || multiply: ; Multiplies two numbers while keeping track of overflow
(0038)  CS-0x048  0x08271         || 	call add_over
(0039)  CS-0x049  0x2C101         || 	sub r1, 0x01 ; Decrement counter
(0040)  CS-0x04A  0x08243         || 	brne multiply ; Loop if multiplication not done
(0041)                            || 
(0042)                     0x04B  || output: ; Output high 8 and low 8 to specified ports
(0043)  CS-0x04B  0x34242         || 	out r2, lowout
(0044)  CS-0x04C  0x34341         || 	out r3, highout
(0045)                            || 
(0046)                     0x04D  || done:
(0047)  CS-0x04D  0x08200         || 	brn start ; Done
(0048)                            || 
(0049)                     0x04E  || add_over: ; Subroutine that adds while keeping track of overflow
(0050)  CS-0x04E  0x02200         || 	add r2, r0 ; Add value 1 to ongoing low 8 result
(0051)  CS-0x04F  0x2A300         || 	addc r3, 0x00 ; See if the operation overflowed. If so, increment high 8
(0052)  CS-0x050  0x18002         || 	ret





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
ADD_OVER       0x04E   (0049)  ||  0038 
DONE           0x04D   (0046)  ||  
MULTIPLY       0x048   (0037)  ||  0040 
OUTPUT         0x04B   (0042)  ||  0033 0035 
START          0x040   (0025)  ||  0047 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
HIGHOUT        0x041   (0016)  ||  0044 
INPORT         0x09A   (0018)  ||  0026 0027 
LOWOUT         0x042   (0017)  ||  0043 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
