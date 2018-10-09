/*
 * EjercicioParcial7.asm
 *
 *  Created: 9/10/2018 15:15:48
 *   Author: Axel
 */ 


 .org 0
 jmp main







 .org 300

 main:
		// seteo puertos
		ldi r16, 0xff
		out DDRB, r16
		out DDRC, r16

		// inicializo variable ram
		ldi r16, 0
		sts salida, r16
		
		// inicializo SP
		ldi r16, low(RAMEND)
		ldi r17, high(RAMEND)
		out spl, r16
		out sph, r17

		// uso el stack para joder
	/*	ldi r16, 0
		push r16 // pongo 0 en el stack
		
		ldi r17, 0xff
		push r17

		pop r0
		pop r1*/
 loop:
		
		call read_port

		call filtro

		jmp loop



read_port:



filtro:




.dseg
.org 0x200
entrada: .byte 1
salida: .byte 1
