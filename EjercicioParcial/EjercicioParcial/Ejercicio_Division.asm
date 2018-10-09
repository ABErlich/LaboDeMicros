/*
 * EjercicioParcial4.asm
 *
 *  Created: 9/10/2018 11:08:30
 *   Author: Axel
 */ 



 /// DIVIDE EL NUMERO EN R19 Y EL NUMERO EN R17
 // DEJA EL RESULTADO EN R18 Y EL RESTO EN R20

 .include "m2560def.inc"

.cseg
.org 0
rjmp main

.org 300
main:

	ldi r16, 9
	ldi r17, 3

	ldi r18, 1

	call checkCero

loop:
	
	inc r18
	mov r19, r18
	mul r19, r17
	mov r19, r0

	sub r19, r16

	BRSH end

	jmp loop

end:
	dec r18 // aca tengo el resultado

	mov r19, r18
	mul r19, r17
	mov r19, r0

	mov r20, r16
	sub r20, r19 // en r16 tengo el resto

	ret

checkCero:
	cpi r17, 0
	brne loop

	set // si el divisor es 0 pongo el flag T en 1

	jmp main