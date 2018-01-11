; SW 1 Assignment 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Register Aliases
.def R_QUEUE = r0 ; register used for holding values
.def R_ADD   = r1 ; register used to add values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Assembler Directives
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ INPUTPORT  = 0x30 ; input port for values
.equ OUTPUTPORT = 0x40 ; output port for values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x00      ; memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mov r0, 0x00 ; queue register
   mov r1, 0x00 ; initialize registers (MOV = move value to register)

   in r0, 0x30 ; grab data, place in r0 (input values are unsigned 8 -bit values)
   add r1, r0   ; take in r0 (source) and add to r1 (destination)
   in r0, 0x30
   add r1, r0
   in r0, 0x30
   add r1, r0

   out r1, 0x40

; ~~~~~~~~~~~~~~~~~~~ program fragment ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
