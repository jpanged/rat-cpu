

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


(0001)                            || ; HW 4 Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ;
(0006)                            || ; r1 - takes in the switches input value
(0007)                            || ; r2 - takes in the interrupt switches value
(0008)                            || ; r3 - bit exor to blink led(0) twice in a sec
(0009)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0010)                            || ;- Port Constants
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                       066  || .equ int_en = 0x42 ;
(0013)                       065  || .equ int_clr = 0x41 ;
(0014)                       032  || .equ switches = 0x20 ;
(0015)                       033  || .equ int_status = 0x21 ;
(0016)                       129  || .equ seg_id = 0x81 ;
(0017)                       064  || .equ leds_id = 0x40 ;
(0018)                       255  || .equ time_OUTSIDE_FOR_COUNT = 0xFF ;
(0019)                       255  || .equ time_MIDDLE_FOR_COUNT = 0xFF ;
(0020)                       096  || .equ time_INSIDE_FOR_COUNT= 0x60 ;
(0021)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0022)                            || ;- Code
(0023)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0024)                            || .cseg
(0025)                       016  || .org  0x10 ; Memory location of instruction data
(0026)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0027)  CS-0x010  0x1A000         || 	sei
(0028)                     0x011  || main:
(0029)  CS-0x011  0x32120         || 	in r1, switches ; gets switches input
(0030)  CS-0x012  0x34142         || 	out r1, int_en ; outputs switches value
(0031)  CS-0x013  0x24301         || 	exor r3, 0x01 ; toggles led(0) to get it to blink
(0032)  CS-0x014  0x34340         || 	out r3, leds_id ; outputs the led(0) status
(0033)                            || ;	call delay ; calls delay only once because led needs to blink twice in a second
(0034)  CS-0x015  0x08088         || 	brn main ; starts over if no interrupt is called
(0035)                            || 
(0036)                       032  || .org 0x20
(0037)                     0x020  || isr:
(0038)  CS-0x020  0x32221         || 	in r2, int_status ; reads the interrupt value
(0039)  CS-0x021  0x34281         || 	out r2, seg_id ; outputs interrupt value on sseg
(0040)                            || ;	call delay ; calls four delays for a 1s total delay
(0041)                            || ;	call delay
(0042)                            || ;	call delay
(0043)                            || ;	call delay
(0044)  CS-0x022  0x1A003         || 	retie ; starts over and resets interrupt
(0045)                            || 
(0046)                            || ;delay: ; delays for half a second per call
(0047)                            || ;				MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0048)                            || ;outside_for:    SUB     R29, 0x01
(0049)                            || ;
(0050)                            || ;				MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0051)                            || ;middle_for:     SUB     R28, 0x01
(0052)                            || ;
(0053)                            || ;				MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0054)                            || ;inside_for: 	SUB     R27, 0x01
(0055)                            || ;				BRNE    inside_for
(0056)                            || ;
(0057)                            || ;				OR      R28, 0x00               ;load flags for middle for counter
(0058)                            || ;				BRNE    middle_for
(0059)                            || ;
(0060)                            || ;				OR      R29, 0x00               ;load flags for outsde for counter value
(0061)                            || ;				BRNE    outside_for
(0062)                            || ;				RET
(0063)                       1023  || .org 0x3FF
(0064)  CS-0x3FF  0x08100         || 	brn isr





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
ISR            0x020   (0037)  ||  0064 
MAIN           0x011   (0028)  ||  0034 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INT_CLR        0x041   (0013)  ||  
INT_EN         0x042   (0012)  ||  0030 
INT_STATUS     0x021   (0015)  ||  0038 
LEDS_ID        0x040   (0017)  ||  0032 
SEG_ID         0x081   (0016)  ||  0039 
SWITCHES       0x020   (0014)  ||  0029 
TIME_INSIDE_FOR_COUNT 0x060   (0020)  ||  
TIME_MIDDLE_FOR_COUNT 0x0FF   (0019)  ||  
TIME_OUTSIDE_FOR_COUNT 0x0FF   (0018)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
