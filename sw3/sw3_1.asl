

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
(0016)  CS-0x004  0x36200         || 	mov r2, 0x00 ; Initialize R2
(0017)                            || 
(0018)                     0x005  || split_bits:
(0019)  CS-0x005  0x18000         || 	clc
(0020)  CS-0x006  0x10001         || 	lsr r0
(0021)  CS-0x007  0x10101         || 	lsr r1
(0022)  CS-0x008  0x2CA01         || 	sub r10, 0x01
(0023)  CS-0x009  0x0802B         || 	brne split_bits
(0024)                            || 
(0025)                     0x00A  || shift_register:
(0026)  CS-0x00A  0x10101         || 	lsr r1
(0027)  CS-0x00B  0x10101         || 	lsr r1
(0028)  CS-0x00C  0x10101         || 	lsr r1
(0029)  CS-0x00D  0x10101         || 	lsr r1
(0030)                            || 
(0031)                     0x00E  || check_if_zero:
(0032)  CS-0x00E  0x30000         || 	cmp r0, 0x00
(0033)  CS-0x00F  0x080BA         || 	breq output
(0034)  CS-0x010  0x30100         || 	cmp r1, 0x00
(0035)  CS-0x011  0x080BA         || 	breq output
(0036)                            || 
(0037)                     0x012  || duplicate_register_for_sum:
(0038)  CS-0x012  0x04209         || 	mov r2, r1
(0039)  CS-0x013  0x2C001         || 	sub r0, 0x01
(0040)                            || 
(0041)                     0x014  || multiply:
(0042)  CS-0x014  0x02208         || 	add r2, r1
(0043)  CS-0x015  0x2C001         || 	sub r0, 0x01
(0044)  CS-0x016  0x080A3         || 	brne multiply
(0045)                            || 
(0046)                     0x017  || output:
(0047)  CS-0x017  0x34242         || 	out r2, outport
(0048)  CS-0x018  0x08008         || 	brn main





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
CHECK_IF_ZERO  0x00E   (0031)  ||  
DUPLICATE_REGISTER_FOR_SUM 0x012   (0037)  ||  
MAIN           0x001   (0012)  ||  0048 
MULTIPLY       0x014   (0041)  ||  0044 
OUTPUT         0x017   (0046)  ||  0033 0035 
SHIFT_REGISTER 0x00A   (0025)  ||  
SPLIT_BITS     0x005   (0018)  ||  0023 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0005)  ||  0013 
OUTPORT        0x042   (0004)  ||  0047 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
