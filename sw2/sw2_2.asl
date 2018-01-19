

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
(0009)                       066  || .equ OUTPUT = 0x42 ; Output port for values
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Memory Designation Constants
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || .dseg
(0014)                       000  || .org 0x00
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Main program
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       001  || .org  0x01 ; Memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                     0x001  || main:
(0022)  CS-0x001  0x32030         ||       in   r0, 0x30 ; Grab data & place in r0
(0023)  CS-0x002  0x04101         ||       mov r1, r0 ; Do checks on r1, original number is r0
(0024)                            || 
(0025)  CS-0x003  0x18000         ||       clc ; Clear carry
(0026)  CS-0x004  0x10101         ||       lsr r1 ; Right shift
(0027)  CS-0x005  0x0A060         ||       brcs is_odd ; If c=1, data is odd
(0028)  CS-0x006  0x18000         ||       clc ; Clear carry
(0029)  CS-0x007  0x10101         ||       lsr r1 ; Right shift
(0030)  CS-0x008  0x0A051         ||       brcc invert_bits ; If c=0, data is divisible by 4
(0031)  CS-0x009  0x08080         ||       brn is_even ; Data is even but not divisble by 4
(0032)                            || 
(0033)                     0x00A  || invert_bits:
(0034)  CS-0x00A  0x240FF         ||       exor r0, 0xFF ; Invert the input bits
(0035)  CS-0x00B  0x08090         ||       brn done
(0036)                            || 
(0037)                     0x00C  || is_odd:
(0038)  CS-0x00C  0x28011         ||       add r0, 0x11 ; Add 17
(0039)  CS-0x00D  0x18000         ||       clc ; Clear carry
(0040)  CS-0x00E  0x10001         ||       lsr r0 ; Right shift divides by 2
(0041)  CS-0x00F  0x08090         ||       brn done
(0042)                            || 
(0043)                     0x010  || is_even:
(0044)  CS-0x010  0x2C001         ||       sub r0, 0x01 ; Subtract 1
(0045)  CS-0x011  0x08090         ||       brn done
(0046)                            || 
(0047)                     0x012  || done:
(0048)  CS-0x012  0x34042         ||       out r0, OUTPUT
(0049)  CS-0x013  0x08008         ||       brn main





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
DONE           0x012   (0047)  ||  0035 0041 0045 
INVERT_BITS    0x00A   (0033)  ||  0030 
IS_EVEN        0x010   (0043)  ||  0031 
IS_ODD         0x00C   (0037)  ||  0027 
MAIN           0x001   (0021)  ||  0049 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
OUTPUT         0x042   (0009)  ||  0048 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
