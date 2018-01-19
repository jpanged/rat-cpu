; SW 2 Assignment 2 - Part 1
; CPE 233 Winter 2018
; Professor Gerfen
; Russell Caletena, Josiah Pang & Nathan Wang

; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Port Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.equ OUTPUT = 0x42 ; Output port for values
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Memory Designation Constants
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.dseg
.org 0x00
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;- Main program
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.cseg
.org  0x01 ; Memory location of instruction data
; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main:
      in   r0, 0x30 ; Grab data & place in r0
      mov r1, r0 ; Do checks on r1, original number is r0

      clc ; Clear carry
      lsr r1 ; Right shift
      brcs is_odd ; If c=1, data is odd
      clc ; Clear carry
      lsr r1 ; Right shift
      brcc invert_bits ; If c=0, data is divisible by 4
      brn is_even ; Data is even but not divisble by 4

invert_bits:
      exor r0, 0xFF ; Invert the input bits
      brn done

is_odd:
      add r0, 0x11 ; Add 17
      clc ; Clear carry
      lsr r0 ; Right shift divides by 2
      brn done

is_even:
      sub r0, 0x01 ; Subtract 1
      brn done

done:
      out r0, OUTPUT
      brn main
