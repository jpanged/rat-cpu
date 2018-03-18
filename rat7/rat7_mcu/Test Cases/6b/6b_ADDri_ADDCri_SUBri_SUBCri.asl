

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


(0001)                            || 
(0002)                            || ; --  AUTHOR:     DOUG BRANDT & JAMES GILSTRAP
(0003)                            || ; --  DATE:       FEB 24, 2011
(0004)                            || ; --  CLASS:      CPE 233
(0005)                            || ; --  INSTRUCTOR: GERFEN
(0006)                            || ; -- 
(0007)                            || ; --  PURPOSE:    THIS PROGRAM WAS BUILT TO TEST SEVERAL DIFFERENT INSTRUCTIONS OF THE RAT PROCESSOR
(0008)                            || ; --              THE TEST CASE NUMBER FOR THIS PROGRAM IS #6 (THIS INCLUDES ADD(REG,IMM), ADDC(REG,IMM), SUB(REG,IMM), SUBC(REG,IMM))
(0009)                            || ; --              THE PROGRAM PERFORMS THE OPERATION, CHECKS THAT THE OPERATION PERFORMED CORRECTLY, AND THEN UPDATES THE OUTPUT(LED) VALUES
(0010)                            || 
(0011)                            || 
(0012)                            || ; INPUT AND OUTPUT PORTS
(0013)                            || ; -----------------------------
(0014)                       032  || .EQU SWITCHES = 0x20
(0015)                       255  || .EQU BUTTONS = 0xFF
(0016)                       064  || .EQU LEDS = 0x40
(0017)                            || ; -----------------------------
(0018)                            || 
(0019)                            || ; CONSTANTS
(0020)                       190  || .EQU INSIDE_FOR_COUNT    = 0xBE
(0021)                       190  || .EQU MIDDLE_FOR_COUNT    = 0xBE
(0022)                       190  || .EQU OUTSIDE_FOR_COUNT   = 0xBE
(0023)                            || ;--------------------------------
(0024)                            || 
(0025)                            || ; DATA SEG
(0026)                            || ; -----------------------------
(0027)                            || .DSEG
(0028)                       000  || .ORG 0x00
(0029)                            || ; -----------------------------
(0030)                            || 
(0031)                            || ; CODE SEG
(0032)                            || ; -----------------------------
(0033)                            || .CSEG
(0034)                       016  || .ORG 0x10
(0035)                            || ; -----------------------------
(0036)                            || 
(0037)                     0x010  || MAIN:
(0038)  CS-0x010  0x36100         ||        MOV R1,0x00      ; register 1 is used to hold the status of the operations completed
(0039)  CS-0x011  0x36400         ||        MOV R4,0x00      ; register 4 is used to hold the bit locator/updater
(0040)  CS-0x012  0x08401         ||        CALL waste_time
(0041)  CS-0x013  0x22401         ||        OR  R4,0x01
(0042)  CS-0x014  0x36201         ||        MOV R2,0x01
(0043)  CS-0x015  0x28202         ||        ADD R2,0x02
(0044)  CS-0x016  0x30203         ||        CMP R2,0x03
(0045)  CS-0x017  0x080CA         ||        BREQ IF2         ; if correct, go to correct section
(0046)  CS-0x018  0x080E0         ||        BRN END_IF2      ; else continue past it
(0047)                            || 
(0048)                     0x019  || IF2:
(0049)  CS-0x019  0x00121         ||        OR R1,R4         ; update the status bit -- this lights up led 1 only
(0050)  CS-0x01A  0x34140         ||        OUT  R1,LEDS
(0051)  CS-0x01B  0x080E0         ||        BRN END_IF2
(0052)                            || 
(0053)                     0x01C  || END_IF2:
(0054)  CS-0x01C  0x08401         ||        CALL waste_time
(0055)  CS-0x01D  0x22402         ||        OR   R4,0x02     ; change the bit updater value so that the next bit will be updated
(0056)  CS-0x01E  0x18001         ||        SEC              ; set carry to 1
(0057)  CS-0x01F  0x2A203         ||        ADDC R2,0x03
(0058)  CS-0x020  0x30207         ||        CMP  R2,0x07
(0059)  CS-0x021  0x0811A         ||        BREQ IF3         ; if correct, go to the correct section
(0060)  CS-0x022  0x08130         ||        BRN END_IF3      ; else continue past it
(0061)                            || 
(0062)                     0x023  || IF3:                    ; THE PROCESS CONTINUES IN A SIMILAR WAY FOR THE REMAINDER OF THE FUNCTIONS BEING TESTED
(0063)  CS-0x023  0x00121         ||        OR R1,R4
(0064)  CS-0x024  0x34140         ||        OUT R1,LEDS
(0065)  CS-0x025  0x08130         ||        BRN END_IF3
(0066)                            || 
(0067)                     0x026  || END_IF3:
(0068)  CS-0x026  0x08401         ||        CALL waste_time
(0069)  CS-0x027  0x22404         ||        OR  R4,0x04
(0070)  CS-0x028  0x2C202         ||        SUB R2,0x02
(0071)  CS-0x029  0x30205         ||        CMP R2,0x05
(0072)  CS-0x02A  0x08162         ||        BREQ IF4
(0073)  CS-0x02B  0x08178         ||        BRN END_IF4
(0074)                            || 
(0075)                     0x02C  || IF4:
(0076)  CS-0x02C  0x00121         ||        OR R1,R4
(0077)  CS-0x02D  0x34140         ||        OUT R1,LEDS
(0078)  CS-0x02E  0x08178         ||        BRN END_IF4
(0079)                            || 
(0080)                     0x02F  || END_IF4:
(0081)  CS-0x02F  0x08401         ||        CALL waste_time
(0082)  CS-0x030  0x22408         ||        OR  R4,0x08
(0083)  CS-0x031  0x18001         ||        SEC
(0084)  CS-0x032  0x2E203         ||        SUBC R2,0x03
(0085)  CS-0x033  0x30201         ||        CMP  R2,0x01
(0086)  CS-0x034  0x081B2         ||        BREQ IF5
(0087)  CS-0x035  0x081D0         ||        BRN END_IF5
(0088)                            || 
(0089)                     0x036  || IF5:
(0090)  CS-0x036  0x00121         ||        OR R1,R4
(0091)  CS-0x037  0x221F0         ||        OR R1,0xF0
(0092)  CS-0x038  0x34140         ||        OUT R1,LEDS
(0093)  CS-0x039  0x081D0         ||        BRN END_IF5
(0094)                            || 
(0095)                     0x03A  || END_IF5:
(0096)  CS-0x03A  0x34140         ||        OUT R1,LEDS
(0097)  CS-0x03B  0x08460         ||        BRN END
(0098)                            || 
(0099)                            || 
(0100)                            || 
(0101)                            || .CSEG
(0102)                       128  || .ORG         0x80
(0103)                            || 
(0104)                     0x080  || waste_time:
(0105)  CS-0x080  0x365BE         ||              MOV     R5,OUTSIDE_FOR_COUNT  ;set outside for loop count
(0106)                     0x081  || outside_for:
(0107)  CS-0x081  0x2C501         ||              SUB     R5,0x01
(0108)  CS-0x082  0x366BE         ||              MOV     R6,MIDDLE_FOR_COUNT   ;set middle for loop count
(0109)                     0x083  || middle_for:
(0110)  CS-0x083  0x2C601         ||              SUB     R6,0x01
(0111)  CS-0x084  0x367BE         ||              MOV     R7,INSIDE_FOR_COUNT   ;set inside for loop count
(0112)                     0x085  || inside_for:
(0113)  CS-0x085  0x2C701         ||              SUB     R7,0x01
(0114)  CS-0x086  0x0842B         ||              BRNE    inside_for
(0115)                            || 
(0116)  CS-0x087  0x22600         ||              OR      R6,0x00               ;load flags for middle for counter
(0117)  CS-0x088  0x0841B         ||              BRNE    middle_for
(0118)                            || 
(0119)  CS-0x089  0x22500         ||              OR      R5,0x00               ;load flags for outsde for counter value
(0120)  CS-0x08A  0x0840B         ||              BRNE    outside_for
(0121)  CS-0x08B  0x18002         ||              RET
(0122)                            || 
(0123)                     0x08C  || END:
(0124)  CS-0x08C  0x04109         ||        MOV R1,R1
(0125)  CS-0x08D  0x08460         ||        BRN END





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
END            0x08C   (0123)  ||  0097 0125 
END_IF2        0x01C   (0053)  ||  0046 0051 
END_IF3        0x026   (0067)  ||  0060 0065 
END_IF4        0x02F   (0080)  ||  0073 0078 
END_IF5        0x03A   (0095)  ||  0087 0093 
IF2            0x019   (0048)  ||  0045 
IF3            0x023   (0062)  ||  0059 
IF4            0x02C   (0075)  ||  0072 
IF5            0x036   (0089)  ||  0086 
INSIDE_FOR     0x085   (0112)  ||  0114 
MAIN           0x010   (0037)  ||  
MIDDLE_FOR     0x083   (0109)  ||  0117 
OUTSIDE_FOR    0x081   (0106)  ||  0120 
WASTE_TIME     0x080   (0104)  ||  0040 0054 0068 0081 


-- Directives: .BYTE
------------------------------------------------------------ 
--> No ".BYTE" directives used


-- Directives: .EQU
------------------------------------------------------------ 
BUTTONS        0x0FF   (0015)  ||  
INSIDE_FOR_COUNT 0x0BE   (0020)  ||  0111 
LEDS           0x040   (0016)  ||  0050 0064 0077 0092 0096 
MIDDLE_FOR_COUNT 0x0BE   (0021)  ||  0108 
OUTSIDE_FOR_COUNT 0x0BE   (0022)  ||  0105 
SWITCHES       0x020   (0014)  ||  


-- Directives: .DEF
------------------------------------------------------------ 
--> No ".DEF" directives used


-- Directives: .DB
------------------------------------------------------------ 
--> No ".DB" directives used
