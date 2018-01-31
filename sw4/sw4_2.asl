

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


(0001)                            || ; SW 4 Part 2
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
(0017)  CS-0x001  0x3209A         || 	in r0, inport ; Read data 1
(0018)  CS-0x002  0x3219A         || 	in r1, inport ; Read data 2
(0019)                            || 
(0020)                     0x003  || divide_by_second:
(0021)  CS-0x003  0x0200A         || 	sub r0, r1 ; Subtract data 1 by data 2
(0022)  CS-0x004  0x0A038         || 	brcs output ; Done when MSB underflows
(0023)                            || 	;breq output ; or when you reach 0
(0024)  CS-0x005  0x28301         || 	add r3, 0x01 ; Add 1 to count
(0025)  CS-0x006  0x0801B         || 	brne divide_by_second ; Repeat
(0026)                            || 
(0027)                            || 
(0028)                     0x007  || output:
(0029)  CS-0x007  0x34342         || 	out r3, outport
(0030)  CS-0x008  0x08008         || 	brn main





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
DIVIDE_BY_SECOND 0x003   (0020)  ||  0025 
MAIN           0x001   (0016)  ||  0030 
OUTPUT         0x007   (0028)  ||  0022 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0009)  ||  0017 0018 
OUTPORT        0x042   (0008)  ||  0029 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
