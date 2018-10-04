/*
 * EjercicioParcial2.asm
 *
 *  Created: 26/09/2018 20:46:56
 *   Author: AErlich
 */ 

 .include "m2560def.inc"

.cseg
.org 0
rjmp main

.org 300

main:
	ldi r16, 8	// Cargo la semilla
	ldi r17, 25	// Cargo la semilla
loop:

	mov r1, r17
	mov r0, r16
	
	// numero =>  msb ->  r1, r0  <- lsb

	lsl r17
	eor r17, r1 // en r17[7] tengo el bit que tengo que alimentar en r0[0]
	

	lsl r17 // shifteo r17 para poner el msb en el carry
	rol r0 // en r0[0] pongo el carry y pongo en el carry r0[7]
			// y en el carry me queda lo que tengo que alimentar en r1[0]

	rol r1 // alimento el carry anterior en r1[0] y muevo todo el resto perdiendo el ultimo bit










