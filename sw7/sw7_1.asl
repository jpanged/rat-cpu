

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


(0001)                            || ; SW 7 Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ; r0 - keeps track of the remainder (becomes the next "place")
(0007)                            || ; r1 - keeps track of the result (use to find next digit)
(0008)                            || ; r2 - stores the 1's place
(0009)                            || ; r3 - stores the 10's place
(0010)                            || ; r4 - stores the 100's place
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                            || ;- Port Constants
(0013)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0014)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0015)                            || .equ 100out = 0x41 ; output port for values
            syntax error
            syntax error
            syntax error

(0016)                            || .equ 10out = 0x42 ; output port for values
            syntax error
            syntax error
            syntax error

(0017)                            || .equ 1out = 0x43 ; output port for values
            syntax error
            syntax error
            syntax error

(0018)                            || 
(0019)                            || 
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                            || ;- Code
(0022)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0023)                            || .cseg
(0024)                       064  || .org  0x40 ; Memory location of instruction data
(0025)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0026)                     0x040  || start:
(0027)  CS-0x040  0x3209A         || 	in r0, inport ; Take value in
(0028)  CS-0x041  0x36100         || 	mov r1, 0x00 ; Reset the counter
(0029)  CS-0x042  0x08251         || 	call div_by_10
(0030)  CS-0x043  0x04201         || 	mov r2, r0 ; Stores the 1's values
(0031)  CS-0x044  0x04009         || 	mov r0, r1
(0032)  CS-0x045  0x36100         || 	mov r1, 0x00 ; Reset the counter
(0033)  CS-0x046  0x08251         || 	call div_by_10
(0034)  CS-0x047  0x04301         || 	mov r3, r0 ; Stores the 10's values
(0035)  CS-0x048  0x04409         || 	mov r4, r1 ; Stores the 1's values
(0036)                            || 
(0037)                            || 
(0038)                     0x049  || done:
(0039)                            || 	out r4, 100out
            syntax error

(0040)                            || 	out r3, 10out
            syntax error

(0041)                            || 	out r2, 1out
            syntax error

(0042)  CS-0x049  0x08200         || 	brn start ; Done
(0043)                            || 
(0044)                     0x04A  || div_by_10:
(0045)  CS-0x04A  0x2C00A         || 	sub r0, 0x0A ; Subtract 10
(0046)  CS-0x04B  0x28101         || 	add r1, 0x01 ; Add 1 to count
(0047)  CS-0x04C  0x3000A         || 	cmp r0, 0x0A ; See if value less than 10
(0048)  CS-0x04D  0x0A251         || 	brcc div_by_10 ; Done when MSB underflows
(0049)  CS-0x04E  0x18002         || 	ret





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
DIV_BY_10      0x04A   (0044)  ||  0029 0033 0048 
DONE           0x049   (0038)  ||  
START          0x040   (0026)  ||  0042 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0014)  ||  0027 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
