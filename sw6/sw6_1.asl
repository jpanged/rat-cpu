

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


(0001)                            || ; SW 6 Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ; r0: Temp storage for pushing
(0007)                            || ; r1: Temp storage for popping
(0008)                            || ; r2: Counter for SP
(0009)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0010)                            || ;- Port Constants
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                       066  || .equ outport = 0x42 ; output port for values
(0013)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0014)                            || 
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Code
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       064  || .org  0x40 ; Memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                     0x040  || main:
(0022)  CS-0x040  0x3209A         || 	in r0, inport ; Take value in
(0023)  CS-0x041  0x300FF         || 	cmp r0, 0xFF ; Check if it's FF
(0024)  CS-0x042  0x08232         || 	breq is_ff ; If so, start outputting from stack
(0025)                            || 
(0026)                     0x043  || store:
(0027)  CS-0x043  0x12001         || 	push r0 ; Store value on the stack
(0028)  CS-0x044  0x28201         || 	add r2, 0x01
(0029)  CS-0x045  0x08200         || 	brn main ; Loop
(0030)                            || 
(0031)                     0x046  || is_ff:
(0032)  CS-0x046  0x12102         || 	pop r1 ; Get top value from stack
(0033)  CS-0x047  0x34142         || 	out r1, outport
(0034)  CS-0x048  0x2C201         || 	sub r2, 0x01
(0035)  CS-0x049  0x30200         || 	cmp r2, 0x00
(0036)  CS-0x04A  0x08233         || 	brne is_ff
(0037)                            || 
(0038)                     0x04B  || output:
(0039)  CS-0x04B  0x08200         || 	brn main ; Done





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
IS_FF          0x046   (0031)  ||  0024 0036 
MAIN           0x040   (0021)  ||  0029 0039 
OUTPUT         0x04B   (0038)  ||  
STORE          0x043   (0026)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0013)  ||  0022 
OUTPORT        0x042   (0012)  ||  0033 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
