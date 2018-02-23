

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
(0005)                            || ; Description:
(0006)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0007)                            || ;- Port Constants
(0008)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0009)                       065  || .equ highout = 0x41 ; Output for high 8 bits
(0010)                       066  || .equ lowout = 0x42 ; Output for low 8 bits
(0011)                       154  || .equ inport = 0x9A ; Input to take 8-bit value
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || ;- Main program
(0014)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0015)                            || .cseg
(0016)                       064  || .org  0x40 ; memory location of instruction data
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                     0x040  || start:
(0019)  CS-0x040  0x3209A         || 	in r0, inport ; Get value 1
(0020)  CS-0x041  0x3219A         || 	in r1, inport ; Get value 2
(0021)  CS-0x042  0x30000         || 	cmp r0, 0x00
(0022)  CS-0x043  0x0824A         || 	breq output
(0023)  CS-0x044  0x30100         || 	cmp r1, 0x00
(0024)  CS-0x045  0x0824A         || 	breq output
(0025)                            || 
(0026)                     0x046  || multiply: ; Multiplies two numbers while keeping track of overflow
(0027)  CS-0x046  0x08261         || 	call add_over
(0028)  CS-0x047  0x2C101         || 	sub r1, 0x01 ; Decrement counter
(0029)  CS-0x048  0x08233         || 	brne multiply ; Loop if multiplication not done
(0030)                            || 
(0031)                     0x049  || output: ; Output high 8 and low 8 to specified ports
(0032)  CS-0x049  0x34242         || 	out r2, lowout
(0033)  CS-0x04A  0x34341         || 	out r3, highout
(0034)                            || 
(0035)                     0x04B  || done:
(0036)  CS-0x04B  0x08200         || 	brn start ; Done
(0037)                            || 
(0038)                     0x04C  || add_over: ; Subroutine that adds while keeping track of overflow
(0039)  CS-0x04C  0x02200         || 	add r2, r0 ; Add value 1 to ongoing low 8 result
(0040)  CS-0x04D  0x2A300         || 	addc r3, 0x00 ; See if the operation overflowed. If so, increment high 8
(0041)  CS-0x04E  0x18002         || 	ret





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
ADD_OVER       0x04C   (0038)  ||  0027 
DONE           0x04B   (0035)  ||  
MULTIPLY       0x046   (0026)  ||  0029 
OUTPUT         0x049   (0031)  ||  0022 0024 
START          0x040   (0018)  ||  0036 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
HIGHOUT        0x041   (0009)  ||  0033 
INPORT         0x09A   (0011)  ||  0019 0020 
LOWOUT         0x042   (0010)  ||  0032 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
