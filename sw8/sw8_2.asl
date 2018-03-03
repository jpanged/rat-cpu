

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


(0001)                            || ; SW 8 Part 2
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ;
(0007)                            || ; r0 -
(0008)                            || ; r2 - Keeps track of last output
(0009)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0010)                            || ;- Port Constants
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                       154  || .equ switches = 0x9A ; input to take 8-bit value
(0013)                       066  || .equ leds = 0x42 ; output port for values
(0014)                       155  || .equ btn = 0x9B
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Code
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       016  || .org  0x10 ; Memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)  CS-0x010  0x1A000         || 	sei
(0022)  CS-0x011  0x36200         ||     mov r2, 0x00
(0023)                     0x012  || main:
(0024)  CS-0x012  0x3219A         || 	in r1, switches ; Take value from switches
(0025)  CS-0x013  0x08090         || 	brn main ; Loop
(0026)                            || 
(0027)                       032  || .org 0x20
(0028)                     0x020  || isr:
(0029)  CS-0x020  0x04110         || 	cmp r1, r2 ; Is current input the same as previous output?
(0030)  CS-0x021  0x0811A         || 	breq consecutive ; If so, stop outputting!
(0031)  CS-0x022  0x08148         || 	brn output ; If not, output!
(0032)                            || 
(0033)                     0x023  || consecutive:
(0034)  CS-0x023  0x36200         ||     mov r2, 0x00
(0035)  CS-0x024  0x34242         ||     out r2, leds
(0036)  CS-0x025  0x3239B         ||     in r3, btn ; Get current btn input
(0037)  CS-0x026  0x10301         || 	lsr r3 ; Check btn(0)
(0038)  CS-0x027  0x0A119         ||     brcc consecutive
(0039)  CS-0x028  0x1A003         ||     retie
(0040)                            || 
(0041)                     0x029  || output:
(0042)  CS-0x029  0x04209         ||     mov r2, r1
(0043)  CS-0x02A  0x34242         || 	out r2, leds ; Output
(0044)  CS-0x02B  0x1A003         || 	retie
(0045)                            || 
(0046)                       1023  || .org 0x3FF
(0047)  CS-0x3FF  0x08100         || 	brn isr





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
CONSECUTIVE    0x023   (0033)  ||  0030 0038 
ISR            0x020   (0028)  ||  0047 
MAIN           0x012   (0023)  ||  0025 
OUTPUT         0x029   (0041)  ||  0031 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BTN            0x09B   (0014)  ||  0036 
LEDS           0x042   (0013)  ||  0035 0043 
SWITCHES       0x09A   (0012)  ||  0024 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
