

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


(0001)                            || ; SW 2 Assignment 2 - Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || 
(0006)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0007)                            || ;- Port Constants
(0008)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0009)                       066  || .equ OUTPUT = 0x42 ; output port for values
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Memory Designation Constants
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || .dseg
(0014)                       000  || .org 0x00
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Main program
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       001  || .org  0x01 ; memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                     0x001  || main:
(0022)  CS-0x001  0x32030         || 		in   r0, 0x30 ; Grab data, place in r0
(0023)  CS-0x002  0x08019         || 		call check_if_gt128
(0024)                            || 
(0025)                     0x003  || check_if_gt128: ; Checks if data greater than 128
(0026)  CS-0x003  0x30080         || 		cmp  r0, 0x80 ; Compare with 128
(0027)  CS-0x004  0x0A041         || 		brcc  div_by4 ; If c=0, branch
(0028)  CS-0x005  0x08042         || 		breq  div_by4 ; If z=1, branch
(0029)  CS-0x006  0x08061         || 		call mult_by2
(0030)  CS-0x007  0x08070         || 		brn done
(0031)                            || 
(0032)                     0x008  || div_by4:
(0033)  CS-0x008  0x10001         || 		lsr r0 ; Divide by 2
(0034)  CS-0x009  0x18000         || 		clc ; Clear carry
(0035)  CS-0x00A  0x10001         || 		lsr r0 ; Divide by 2 again
(0036)  CS-0x00B  0x08070         || 		brn done
(0037)                            || 
(0038)                     0x00C  || mult_by2:
(0039)  CS-0x00C  0x18000         || 		clc ; Clear carry
(0040)  CS-0x00D  0x10000         || 		lsl r0 ; Multiply by 2
(0041)                            || 
(0042)                     0x00E  || done:
(0043)  CS-0x00E  0x34042         || 		out r0, OUTPUT
(0044)  CS-0x00F  0x08008         || 		brn main





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
CHECK_IF_GT128 0x003   (0025)  ||  0023 
DIV_BY4        0x008   (0032)  ||  0027 0028 
DONE           0x00E   (0042)  ||  0030 0036 
MAIN           0x001   (0021)  ||  0044 
MULT_BY2       0x00C   (0038)  ||  0029 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
OUTPUT         0x042   (0009)  ||  0043 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
