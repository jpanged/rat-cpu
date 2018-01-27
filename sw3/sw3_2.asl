

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


(0001)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0002)                            || ;- Port Constants
(0003)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0004)                       066  || .equ out_port = 0x42 ; output port for values
(0005)                       154  || .equ in_port = 0x9A ; input to take 8-bit value
(0006)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0007)                            || ;- Main program
(0008)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0009)                            || .cseg
(0010)                       001  || .org  0x01 ; memory location of instruction data
(0011)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0012)                     0x001  || main:
(0013)  CS-0x001  0x3209A         || 			in r0, in_port ;assign value from in_port to r0
(0014)  CS-0x002  0x36160         || 			mov r1, 0x60   ;initialize delay_1 loop counter
(0015)                     0x003  || outer_loop:	
(0016)  CS-0x003  0x362FE         || 			mov r2, 0xFE   ;initialize delay_2 loop counter
(0017)                     0x004  || middle_loop:
(0018)  CS-0x004  0x363FF         || 			mov r3, 0xFF   ;initialize delay_3 loop counter
(0019)                            || 
(0020)  CS-0x005  0x2C301  0x005  || inner_loop:	sub r3, 0x01   ;subtract 1 from r3
(0021)  CS-0x006  0x0802B         || 			brne inner_loop
(0022)                            || 
(0023)  CS-0x007  0x2C201         || 			sub r2, 0x01   ;subtract 1 from r2
(0024)  CS-0x008  0x08023         || 			brne middle_loop
(0025)                            || 
(0026)  CS-0x009  0x2C101         || 			sub r1, 0x01    ;subtract 1 from r1
(0027)  CS-0x00A  0x0801B         || 			brne outer_loop   
(0028)                            || 
(0029)  CS-0x00B  0x34042         || 			out r0, out_port ; send value from r0 to out_port
(0030)  CS-0x00C  0x08008         || 			brn main





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
INNER_LOOP     0x005   (0020)  ||  0021 
MAIN           0x001   (0012)  ||  0030 
MIDDLE_LOOP    0x004   (0017)  ||  0024 
OUTER_LOOP     0x003   (0015)  ||  0027 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
IN_PORT        0x09A   (0005)  ||  0013 
OUT_PORT       0x042   (0004)  ||  0029 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
