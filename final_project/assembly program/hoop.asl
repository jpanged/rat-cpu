

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


(0001)                            || ; Final Project
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ;
(0007)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0008)                            || ;- Port Constants
(0009)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0010)                       129  || .equ sseg = 0x81
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                            || ;- Code
(0013)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0014)                            || .cseg
(0015)                       016  || .org  0x10 ; Memory location of instruction data
(0016)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0017)  CS-0x010  0x1A000         || 	sei
(0018)  CS-0x011  0x36000         ||     mov r0, 0x00
(0019)                     0x012  || main:
(0020)  CS-0x012  0x34081         || 	out r0, sseg
(0021)  CS-0x013  0x08090         || 	brn main ; Loop
(0022)                            || 
(0023)                       032  || .org 0x20
(0024)                     0x020  || isr:
(0025)  CS-0x020  0x28001         || 	add r0, 0x01
(0026)  CS-0x021  0x1A003         ||     retie
(0027)                            || 
(0028)                       1023  || .org 0x3FF
(0029)  CS-0x3FF  0x08100         || 	brn isr





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
ISR            0x020   (0024)  ||  0029 
MAIN           0x012   (0019)  ||  0021 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
SSEG           0x081   (0010)  ||  0020 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
