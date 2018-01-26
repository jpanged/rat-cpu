

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


(0001)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0002)                            || ;- Port Constants
(0003)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0004)                       066  || .equ outport = 0x42 ; output port for values
(0005)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0006)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0007)                            || ;- Main program
(0008)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0009)                            || .cseg
(0010)                       001  || .org  0x01 ; memory location of instruction data
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                     0x001  || main:
(0013)  CS-0x001  0x3209A         || 	in r0, inport
(0014)  CS-0x002  0x36A04         || 	mov r10, 0x04
(0015)  CS-0x003  0x36100         || 	mov r1, 0x00
(0016)                            || 	
(0017)                     0x004  || split_bits:
(0018)  CS-0x004  0x18000         || 	clc
(0019)  CS-0x005  0x10001         || 	lsr r0
(0020)  CS-0x006  0x10101         || 	lsr r1
(0021)  CS-0x007  0x2CA01         || 	sub r10, 0x01
(0022)  CS-0x008  0x08023         || 	brne split_bits
(0023)                            || 	
(0024)                     0x009  || shift_register:
(0025)  CS-0x009  0x10101         || 	lsr r1
(0026)  CS-0x00A  0x10101         || 	lsr r1
(0027)  CS-0x00B  0x10101         || 	lsr r1
(0028)  CS-0x00C  0x10101         || 	lsr r1
(0029)                            || 
(0030)  CS-0x00D  0x04209         || 	mov r2, r1
(0031)  CS-0x00E  0x2C001         || 	sub r0, 0x01
(0032)                            || 
(0033)                     0x00F  || multiply:
(0034)  CS-0x00F  0x02208         || 	add r2, r1
(0035)  CS-0x010  0x2C001         || 	sub r0, 0x01
(0036)  CS-0x011  0x0807B         || 	brne multiply
(0037)                            || 
(0038)  CS-0x012  0x34242         || 	out r2, outport
(0039)  CS-0x013  0x08008         || 	brn main





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
MAIN           0x001   (0012)  ||  0039 
MULTIPLY       0x00F   (0033)  ||  0036 
SHIFT_REGISTER 0x009   (0024)  ||  
SPLIT_BITS     0x004   (0017)  ||  0022 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0005)  ||  0013 
OUTPORT        0x042   (0004)  ||  0038 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
