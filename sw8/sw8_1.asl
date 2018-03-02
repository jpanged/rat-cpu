

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


(0001)                            || ; SW 8 Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; Description:
(0006)                            || ;
(0007)                            || ; r0 - Keeps track of current LED state: 0x00 = off, 0x01 = on
(0008)                            || ; r1 - Gets values from switches
(0009)                            || ; r2 - Current output (either switches or off)
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Port Constants
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                       154  || .equ switches = 0x9A ; input to take 8-bit value
(0014)                       066  || .equ leds = 0x42 ; output port for values
(0015)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0016)                            || ;- Code
(0017)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0018)                            || .cseg
(0019)                       016  || .org  0x10 ; Memory location of instruction data
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)  CS-0x010  0x1A000         || 	sei
(0022)  CS-0x011  0x36000         || 	mov r0, 0x00
(0023)  CS-0x012  0x36200         || 	mov r2, 0x00
(0024)                     0x013  || main:
(0025)  CS-0x013  0x3219A         || 	in r1, switches ; Take value from switches
(0026)  CS-0x014  0x08098         || 	brn main ; Loop
(0027)                            || 
(0028)                       032  || .org 0x20
(0029)                     0x020  || isr:
(0030)  CS-0x020  0x30000         || 	cmp r0, 0x00
(0031)  CS-0x021  0x0811A         || 	breq on_out
(0032)  CS-0x022  0x08130         || 	brn off_out
(0033)                            || 
(0034)                     0x023  || on_out: 
(0035)  CS-0x023  0x36001         || 	mov r0, 0x01
(0036)  CS-0x024  0x04209         || 	mov r2, r1
(0037)  CS-0x025  0x08148         || 	brn output
(0038)                            || 
(0039)                     0x026  || off_out: 
(0040)  CS-0x026  0x36000         || 	mov r0, 0x00
(0041)  CS-0x027  0x36200         || 	mov r2, 0x00
(0042)  CS-0x028  0x08148         || 	brn output
(0043)                            || 
(0044)                     0x029  || output:
(0045)  CS-0x029  0x34242         || 	out r2, leds ; Output
(0046)  CS-0x02A  0x1A003         || 	retie
(0047)                            || 
(0048)                       1023  || .org 0x3FF
(0049)  CS-0x3FF  0x08100         || 	brn isr





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
ISR            0x020   (0029)  ||  0049 
MAIN           0x013   (0024)  ||  0026 
OFF_OUT        0x026   (0039)  ||  0032 
ON_OUT         0x023   (0034)  ||  0031 
OUTPUT         0x029   (0044)  ||  0037 0042 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
LEDS           0x042   (0014)  ||  0045 
SWITCHES       0x09A   (0013)  ||  0025 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
