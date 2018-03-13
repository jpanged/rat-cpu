

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


(0001)                       129  || .equ sseg = 0x81 ; find out what the data port id is for sseg display (alu_val)
(0002)                            || 
(0003)                            || .cseg
(0004)                       016  || .org 0x10
(0005)                            || 
(0006)  CS-0x010  0x1A000         || 		sei			 ; initialize interrupts
(0007)  CS-0x011  0x3603C         || 		mov r0, 0x3C ; sets counter to 60 seconds
(0008)                     0x012  || main:
(0009)  CS-0x012  0x34081         || 		out r0, sseg ; output seven seg value
(0010)  CS-0x013  0x08090         || 		brn main 	 ; repeat if no interrupt is triggered
(0011)                            || 
(0012)                       032  || .org 0x20
(0013)                     0x020  || isr:
(0014)  CS-0x020  0x2C001         || 		sub r0, 0x01 ; decrement counter 1
(0015)  CS-0x021  0x0A118         || 		brcs thing	 ; go to new branch if counter reaches 0
(0016)  CS-0x022  0x1A003         || 		retie 		 ; go back to seven seg output
(0017)                            || 
(0018)                     0x023  || thing:
(0019)  CS-0x023  0x3603C         || 		mov r0, 0x3C ; reset counter value back to 60 seconds
(0020)  CS-0x024  0x1A003         || 		retie		 ; go back to seven seg output
(0021)                            || 
(0022)                       1023  || .org 0x3FF
(0023)  CS-0x3FF  0x08100         || 		brn isr

(0024)                            || 		brn isr






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
ISR            0x020   (0013)  ||  0023 
MAIN           0x012   (0008)  ||  0010 
THING          0x023   (0018)  ||  0015 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
SSEG           0x081   (0001)  ||  0009 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
