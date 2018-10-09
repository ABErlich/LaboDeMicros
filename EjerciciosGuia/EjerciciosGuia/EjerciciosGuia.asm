/*
 * EjerciciosGuia.asm
 *
 *  Created: 9/10/2018 10:51:48
 *   Author: Axel
 */ 


.include "m2560def.inc"

.cseg
.org 0
rjmp init

.org 0x122


init:
		// Inicializo Stack
		LDI r16, low(RAMEND)
		LDI r17, high(RAMEND)
		OUT SPL, R16
		OUT SPH, R17
main:

		LDI R20,$27
		LDI R21,$15
		SUB R20, R21
		LDI R20,$20
		LDI R21,$15
		SUB R20, R21
		LDI R24,95
		LDI R25,95
		SUB R24, R25
		LDI R22,50
		LDI R23,70
		SUB R22, R23
		L1: RJMP L1