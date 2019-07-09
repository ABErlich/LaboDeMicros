/*
 * Led.asm
 *
 *  Created: 05/09/2018 21:32:51
 *   Author: AErlich
 */ 


 .include "m2560def.inc"

		.org 0
		rjmp main

.org 300

main:	

		sbi	DDRB,7 // Configuro el puerto B7 COMO SALIDA
loop:
		sbi PORTB, 7
		rcall demora
		cbi	PORTB, 7 
		rcall demora
		rjmp loop

demora:
		ldi r16, 255
		dec r16
		brne demora
		
		ret

