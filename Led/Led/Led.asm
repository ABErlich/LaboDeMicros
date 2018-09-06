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
		cbi PORTB, 7
		rcall demora
		sbi	PORTB, 7 // Pongo 0 en el puerto
		rcall demora
		rjmp loop

demora:
		ldi r16, 255


loop2:
		ldi r17, 255
loop3:
		ldi r18, 5
loop4:
		dec r18
		brne loop4
		dec r17
		brne loop3
		dec r16
		brne loop2
		
		ret

