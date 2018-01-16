

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


(0001)                            || ; SW 1 Assignment 1 - Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ;
(0006)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0007)                            || ;- Port Constants
(0008)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0009)                       064  || .equ OUTPUTPORT = 0x40 ; output port for values
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Memory Designation Constants
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || .dseg
(0014)                       032  || .org 0x20
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Main program
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       001  || .org  0x01 ; memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                     0x001  || main_loop:
(0022)  CS-0x001  0x36100         || 			mov r1, 0x00		  ; resets the sum register to 0
(0023)  CS-0x002  0x32030         || 		   in  r0, 0x30 		  ; grab data, place in r0
(0024)  CS-0x003  0x02100         || 		   add r1, r0   		  ; sum data both registers and store in r1
(0025)  CS-0x004  0x32030         || 		   in  r0, 0x30 		  ; grab data, place in r0
(0026)  CS-0x005  0x02100         || 		   add r1, r0   		  ; sum data both registers and store in r1
(0027)  CS-0x006  0x32030         || 		   in  r0, 0x30 		  ; grab data, place in r0
(0028)  CS-0x007  0x02100         || 		   add r1, r0   		  ; sum data both registers and store in r1
(0029)  CS-0x008  0x34140         || 		   out r1, OUTPUTPORT  ; output the result of r1
(0030)  CS-0x009  0x08008         || 		   brn main_loop	     ; restarts the cycle





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
MAIN_LOOP      0x001   (0021)  ||  0030 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
OUTPUTPORT     0x040   (0009)  ||  0029 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
