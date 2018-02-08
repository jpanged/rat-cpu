

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


(0001)                            || ; SW 5 Part 1
(0002)                            || ; CPE 233 Winter 2018
(0003)                            || ; Professor Gerfen
(0004)                            || ; Russell Caletena, Josiah Pang & Nathan Wang
(0005)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0006)                            || ;- Port Constants
(0007)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0008)                       066  || .equ outport = 0x42 ; output port for values
(0009)                       154  || .equ inport = 0x9A ; input to take 8-bit value
(0010)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0011)                            || ;- Data
(0012)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0013)                            || .dseg
(0014)                       032  || .org 0x20 ; Where to start Fibonacci array in scratchpad
(0015)                            || 
(0016)                     0x000  || fibonacci:
(0017)  DS-0x020             005  || 	.db 0x01, 0x01, 0x02, 0x03, 0x05
(0018)  DS-0x025             005  || 	.db 0x08, 0x0D, 0x15, 0x22, 0x37
(0019)  DS-0x02A             003  || 	.db 0x59, 0x90, 0xE9
(0020)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0021)                            || ;- Code
(0022)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0023)                            || .cseg
(0024)                       064  || .org  0x40 ; Memory location of instruction data
(0025)                            || ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(0026)                     0x040  || main:
(0027)                            || 	; Initialize all registers
-------------------------------------------------------------------------------------------
-STUP-  CS-0x000  0x36001  0x001  ||              MOV     r0,0x01     ; write dseg data to reg
-STUP-  CS-0x001  0x3A020  0x020  ||              LD      r0,0x20     ; place reg data in mem 
-STUP-  CS-0x002  0x36001  0x001  ||              MOV     r0,0x01     ; write dseg data to reg
-STUP-  CS-0x003  0x3A021  0x021  ||              LD      r0,0x21     ; place reg data in mem 
-STUP-  CS-0x004  0x36002  0x002  ||              MOV     r0,0x02     ; write dseg data to reg
-STUP-  CS-0x005  0x3A022  0x022  ||              LD      r0,0x22     ; place reg data in mem 
-STUP-  CS-0x006  0x36003  0x003  ||              MOV     r0,0x03     ; write dseg data to reg
-STUP-  CS-0x007  0x3A023  0x023  ||              LD      r0,0x23     ; place reg data in mem 
-STUP-  CS-0x008  0x36005  0x005  ||              MOV     r0,0x05     ; write dseg data to reg
-STUP-  CS-0x009  0x3A024  0x024  ||              LD      r0,0x24     ; place reg data in mem 
-STUP-  CS-0x00A  0x36008  0x008  ||              MOV     r0,0x08     ; write dseg data to reg
-STUP-  CS-0x00B  0x3A025  0x025  ||              LD      r0,0x25     ; place reg data in mem 
-STUP-  CS-0x00C  0x3600D  0x00D  ||              MOV     r0,0x0D     ; write dseg data to reg
-STUP-  CS-0x00D  0x3A026  0x026  ||              LD      r0,0x26     ; place reg data in mem 
-STUP-  CS-0x00E  0x36015  0x015  ||              MOV     r0,0x15     ; write dseg data to reg
-STUP-  CS-0x00F  0x3A027  0x027  ||              LD      r0,0x27     ; place reg data in mem 
-STUP-  CS-0x010  0x36022  0x022  ||              MOV     r0,0x22     ; write dseg data to reg
-STUP-  CS-0x011  0x3A028  0x028  ||              LD      r0,0x28     ; place reg data in mem 
-STUP-  CS-0x012  0x36037  0x037  ||              MOV     r0,0x37     ; write dseg data to reg
-STUP-  CS-0x013  0x3A029  0x029  ||              LD      r0,0x29     ; place reg data in mem 
-STUP-  CS-0x014  0x36059  0x059  ||              MOV     r0,0x59     ; write dseg data to reg
-STUP-  CS-0x015  0x3A02A  0x02A  ||              LD      r0,0x2A     ; place reg data in mem 
-STUP-  CS-0x016  0x36090  0x090  ||              MOV     r0,0x90     ; write dseg data to reg
-STUP-  CS-0x017  0x3A02B  0x02B  ||              LD      r0,0x2B     ; place reg data in mem 
-STUP-  CS-0x018  0x360E9  0x0E9  ||              MOV     r0,0xE9     ; write dseg data to reg
-STUP-  CS-0x019  0x3A02C  0x02C  ||              LD      r0,0x2C     ; place reg data in mem 
-STUP-  CS-0x01A  0x08200  0x100  ||              BRN     0x40        ; jump to start of .cseg in program mem 
-------------------------------------------------------------------------------------------
(0028)  CS-0x040  0x36000         || 	mov r0, 0x00 ; Count register
(0029)  CS-0x041  0x36120         || 	mov r1, 0x20 ; Location of current Fibonacci #, initialized to where .dseg begins
(0030)  CS-0x042  0x36200         || 	mov r2, 0x00 ; Value of current Fibonnaci
(0031)  CS-0x043  0x36300         || 	mov r3, 0x00 ; Location of Fibonacci # 3 spots away
(0032)  CS-0x044  0x36400         || 	mov r4, 0x00 ; Value of Fibonacci # 3 spots away, also holds subtraction result
(0033)                            || 
(0034)                     0x045  || fibonacci_diff:
(0035)  CS-0x045  0x04309         || 	mov r3, r1 ; Copies location of current Fibonacci #
(0036)  CS-0x046  0x28303         || 	add r3, 0x03 ; Gets location of Fibonacci # 3 spots away
(0037)                            || 
(0038)  CS-0x047  0x0420A         || 	ld r2, (r1) ; Grab current Fibonacci value
(0039)  CS-0x048  0x0441A         || 	ld r4, (r3) ; Grab Fibonacci value 3 away
(0040)                            || 
(0041)  CS-0x049  0x02412         || 	sub r4, r2 ; Calculate the difference
(0042)                            || 
(0043)  CS-0x04A  0x34442         || 	out r4, outport ; Output result
(0044)                            || 
(0045)  CS-0x04B  0x28101         || 	add r1, 0x01 ; Increment current Fibonacci #
(0046)                            || 	
(0047)  CS-0x04C  0x28001         || 	add r0, 0x01 ; Increment counter
(0048)  CS-0x04D  0x3000A         || 	cmp r0, 0x0A ; Is the count equal to 10?
(0049)                            || 
(0050)  CS-0x04E  0x0822B         || 	brne fibonacci_diff ; Loop until you get to the last number
(0051)                            || 
(0052)                     0x04F  || output:
(0053)  CS-0x04F  0x08200         || 	brn main ; Done





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
FIBONACCI      0x020   (0016)  ||  
FIBONACCI_DIFF 0x045   (0034)  ||  0050 
MAIN           0x040   (0026)  ||  0053 
OUTPUT         0x04F   (0052)  ||  


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
INPORT         0x09A   (0009)  ||  
OUTPORT        0x042   (0008)  ||  0043 


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
