

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
(0005)                            || ;
(0006)                            || ; r0 - Outputs nothing if more than to consecutive inputs
(0007)                            || ; r2 - Gets the button input
(0008)                            || ; r10 - Gets switches input
(0009)                            || ; r11 - Stored register retaining previous input
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Port Constants
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                       154  || .equ switches = 0x9A ; input to take 8-bit value
(0014)                       066  || .equ leds = 0x42 ; output port for values
(0015)                       155  || .equ button = 0x9B ; button(0) which is the "reset"
(0016)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0017)                            || ;- Code
(0018)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0019)                            || .cseg
(0020)                       016  || .org  0x10 ; Memory location of instruction data
(0021)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0022)  CS-0x010  0x1A000         || 	sei
(0023)  CS-0x011  0x36000         || 	mov r0, 0x00 ; outputs 0 if consecutive value
(0024)  CS-0x012  0x36B00         || 	mov r11, 0x00 ; initialize zero in comparison (copy) register
(0025)                     0x013  || main:
(0026)  CS-0x013  0x32A9A         || 	in r10, switches ; Take value from switches
(0027)  CS-0x014  0x08098         || 	brn main ; keeps getting input until manual interrupt is triggered
(0028)                            || 
(0029)                       032  || .org 0x20
(0030)                     0x020  || isr:
(0031)  CS-0x020  0x04A58         || 	cmp r10, r11 ; see if value is same as before
(0032)  CS-0x021  0x08153         || 	brne output ; output value if different
(0033)  CS-0x022  0x0811A         || 	breq nothing_loop ; go into nothing_loop until reset
(0034)                            || 
(0035)                     0x023  || nothing_loop:
(0036)  CS-0x023  0x3229B         || 	in r2, button ; take a input of button
(0037)  CS-0x024  0x10201         || 	lsr r2 ; check bit 0 of button via carry flag
(0038)  CS-0x025  0x0A140         || 	brcs reset ; if the button(0) is 1 then restart
(0039)  CS-0x026  0x34042         || 	out r0, leds ; outputs no LEDs when stuck in loop
(0040)  CS-0x027  0x08118         || 	brn nothing_loop ; recurs in loop until reset
(0041)                            || 
(0042)                     0x028  || reset:
(0043)  CS-0x028  0x36B00         || 	mov r11, 0x00 ; reset program values
(0044)  CS-0x029  0x1A003         || 	retie ; starts over
(0045)                            || 
(0046)                     0x02A  || output:
(0047)  CS-0x02A  0x04B51         || 	mov r11, r10
(0048)  CS-0x02B  0x34A42         || 	out r10, leds ; outputs value
(0049)  CS-0x02C  0x1A003         || 	retie; starts over
(0050)                            || 
(0051)                       1023  || .org 0x3FF
(0052)  CS-0x3FF  0x08100         || 	brn isr





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
ISR            0x020   (0030)  ||  0052 
MAIN           0x013   (0025)  ||  0027 
NOTHING_LOOP   0x023   (0035)  ||  0033 0040 
OUTPUT         0x02A   (0046)  ||  0032 
RESET          0x028   (0042)  ||  0038 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BUTTON         0x09B   (0015)  ||  0036 
LEDS           0x042   (0014)  ||  0039 0048 
SWITCHES       0x09A   (0013)  ||  0026 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
