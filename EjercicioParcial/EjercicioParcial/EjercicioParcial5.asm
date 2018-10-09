/*
 * EjercicioParcial5.asm
 *
 *  Created: 9/10/2018 12:46:28
 *   Author: Axel
 */ 

 // UNA RUTINA QUE LEA UNA TABLA EN SRAM A PARTIR DE LA DIRECCION TABLA_RAM Y QUE FINALIZA CON EL VALOR 0XFF EL BYTE LEIDO SE PASA EN R20 
 // COMO ENTRADA PARA LA RUTINA CALCULA_PARIDAD. 


.include "m2560def.inc"

.dseg
.org 0x200
TABLA_RAM: .byte 1000

.cseg
.org 0x300

main:
		ldi Yl, low(TABLA_RAM)
		ldi yH, high(TABLA_RAM)

loop:
		ld r20, Y+
		cpi r20, 0xFF


calcula_paridad:

		jmp loop



