/*
 * parcial3.asm
 *
 *  Created: 10/10/2018 19:49:51
 *   Author: AErlich
 */ 

 .def distancia = r20
 .def distanciaParcial = r21
 .def charRam = r17
 .def charFlash = r18
 .def contador = r22

 .dseg
.org 0x200

Input_table: .byte 256

.cseg
.org 0x300
Template_table: .db "sarasa1",0


main:		
		ldi distancia, 0 // aca voy a tener la cuenta

		// INICIALIZO EL PUNTERO A LA TABLA FLASH
		ldi Zl, low(Template_table)*2
		ldi Zh, high(Template_table)*2

		// INICIALIZO EL PUNTERO A LA TABLA RAM
		ldi Yl, low(Input_table)
		ldi yH, high(Input_table)
loop:
		
		call leerRam
		call leerFlash

		cpi charRam, 0 // Si lei un \0 Termino
		breq end

		ldi distanciaParcial, 0
		call comparar
		add distancia, distanciaParcial

leerRam:
		ld charRam, Y+
		ret
leerFlash:
		ld charFlash, Z+
		ret
comparar:
		eor charRam, charFlash
		mov r0, charRam		// calculo el x-or y copio por comodidad


		ldi contador, 8
contarUnos:
			dec contador
			ror r0

			brcs contarUnos // Si el carry esta en 0 corro denuevo
			inc distanciaParcial // Si el carry esta en 1 sumo.

			ldi r16, 0
			cpse contador, r16	// Si llegue a 0 en el contador vuelvo al loop principal, 
			rjmp contarUnos
			ret
end:
			cpi distancia, 0
			brne ponerCarry0 // Si la distancia es 0, pongo el carry en 0

ponerCarry1:
			BSET 0 
			ret
ponerCarry0:
			BCLR 0
			ret