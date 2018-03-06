

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
(0020)                       192  || .equ time_INSIDE_FOR_COUNT= 0xC0 ;
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
(0033)  CS-0x015  0x083A9         || 	call delay ; calls delay only once because led needs to blink twice in a second
(0034)  CS-0x016  0x08088         || 	brn main ; starts over if no interrupt is called
(0035)                            || 
(0036)                       112  || .org 0x70
(0037)                     0x070  || isr:
(0038)  CS-0x070  0x32221         || 	in r2, int_status ; reads the interrupt value
(0039)  CS-0x071  0x34281         || 	out r2, seg_id ; outputs interrupt value on sseg
(0040)  CS-0x072  0x083A9         || 	call delay ; calls two delays for a 1s total delay
(0041)  CS-0x073  0x083A9         || 	call delay
(0042)  CS-0x074  0x1A003         || 	retie ; starts over and resets interrupt
(0043)                            || 
(0044)                     0x075  || delay: ; delays for half a second per call
(0045)  CS-0x075  0x37DFF         || 				MOV     R29, time_OUTSIDE_FOR_COUNT  ;set outside for loop count
(0046)  CS-0x076  0x2DD01  0x076  || outside_for:    SUB     R29, 0x01
(0047)                            || 
(0048)  CS-0x077  0x37CFF         || 				MOV     R28, time_MIDDLE_FOR_COUNT   ;set middle for loop count
(0049)  CS-0x078  0x2DC01  0x078  || middle_for:     SUB     R28, 0x01
(0050)                            || 
(0051)  CS-0x079  0x37BC0         || 				MOV     R27, time_INSIDE_FOR_COUNT   ;set inside for loop count
(0052)  CS-0x07A  0x2DB01  0x07A  || inside_for: 	SUB     R27, 0x01
(0053)  CS-0x07B  0x083D3         || 				BRNE    inside_for
(0054)                            || 
(0055)  CS-0x07C  0x23C00         || 				OR      R28, 0x00               ;load flags for middle for counter
(0056)  CS-0x07D  0x083C3         || 				BRNE    middle_for
(0057)                            || 
(0058)  CS-0x07E  0x23D00         || 				OR      R29, 0x00               ;load flags for outsde for counter value
(0059)  CS-0x07F  0x083B3         || 				BRNE    outside_for
(0060)  CS-0x080  0x18002         || 				RET
(0061)                       1023  || .org 0x3FF
(0062)  CS-0x3FF  0x08380         || 	brn isr





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
DELAY          0x075   (0044)  ||  0033 0040 0041 
INSIDE_FOR     0x07A   (0052)  ||  0053 
ISR            0x070   (0037)  ||  0062 
MAIN           0x011   (0028)  ||  0034 
MIDDLE_FOR     0x078   (0049)  ||  0056 
OUTSIDE_FOR    0x076   (0046)  ||  0059 


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
TIME_INSIDE_FOR_COUNT 0x0C0   (0020)  ||  0051 
TIME_MIDDLE_FOR_COUNT 0x0FF   (0019)  ||  0048 
TIME_OUTSIDE_FOR_COUNT 0x0FF   (0018)  ||  0045 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
