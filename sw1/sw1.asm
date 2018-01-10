; SW 1 Assignment 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Register Aliases
.DEF R_QUEUE = r0 ; register used for holding values
.DEF R_ADD   = r1 ; register used to add values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Assembler Directives
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.EQU INPUTPORT  = 0x30 ; input port for values
.EQU OUTPUTPORT = 0x40 ; output port for values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.CSEG
.ORG  0x00      ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   MOV r0, 0x00 ; queue register
   MOV r1, 0x00 ; initialize registers (MOV = move value to register)

   IN r0, 0x30 ; grab data, place in r0 (input values are unsigned 8 -bit values)
   ADD r1, r0   ; take in r0 (source) and add to r1 (destination)
   IN r0, 0x30
   ADD r1, r0
   IN r0, 0x30
   ADD r1, r0

   OUT r1, 0x40

; ~~~~~~~~~~~~~~~~~~~ program fragment ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
