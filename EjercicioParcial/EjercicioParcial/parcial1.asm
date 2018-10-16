/*
 * parcial1.asm
 *
 *  Created: 10/10/2018 19:12:19
 *   Author: AErlich
 */ 

 // Una tabla Fn de 256 valores
// Que tome por el puerto B un byte
// Que saque por el puerto C Fn(B) si el puerto D.1 es 0
// Que saque por el puerto C Fn(B) negado si el puerto D.1 es 1

 
.dseg
.org 0x200
Fn: .byte 256

.cseg
.org 0x300

main:
		// Configuro el puntero a la tabla
		ldi Yl, low(Fn)
		ldi yH, high(Fn)

		// Configuro puertos
		cbi DDRD, 1 // puerto D.1 COMO ENTRADA
		ldi r16, 0xFF
		ldi r17, 0
		out DDRB, r17 // pueto B como entrada
		out DDRC, R16 // puerto C como salida

loop:
		IN r16, PINB // LEO EL PUERTO B
		
		// asumo que es un entero > 0
		// Me guardo el puntero en r1 y r0
		mov r1, Yh
		mov r0, Yl

		adc Yl, r16 // Sumo la parte baja del puntero a la tabla y el valor tomado
		ldi r16, 0
		adc Yh, r16 // Si hubo carry se lo sumo a la parte alta del puntero a la tabla

		ld r18, Y // recupero Fn[B]

		mov Yh, r1
		mov Yl, r0 // recupero el puntero original

leerD1:
		IN r16, PIND // Leo el puerto D
		// como el bit que quiero esta en D[1] muevo dos posiciones para ponerlo en el carry
		ror r16
		ror r16
		brcs sacarNegado

		OUT PORTB, r18
		jmp loop

sacarNegado:

		COM r18 // complemento a 1 del registro me niega todos los bits
		OUT PORTB, r18
		jmp loop




//Ejercicio 3 suponer que es un string terminado en \0