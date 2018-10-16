/*
 * parcial2.asm
 *
 *  Created: 10/10/2018 19:41:33
 *   Author: AErlich
 */ 


 // Leer el valor del puerto B y guardarlo en una variable X
 // Escribir en el puerto C x^2 + 2x
 // Calcular los valores posibles de x para que el resultado quepa en 8 bits (sin signo)
 // Si la operacion desborda, escribir en el puerto C 0xFF

 .def cuentaH = r21
 .def cuentaL = r20
 .def rx = r17
 .def maximoX = r23

.dseg
.org 0x200
x_: .byte 1

.cseg
.org 0x300

main:
		// Configuro la direccion de X
		ld Yl, low(x_)
		ldi yH, high(x_)

		ldi r16, 0
		ldi r17, 0xFF
		out DDRB, r16 // puerto B como entrada
		out DDRC, r17 // puerto C como salida

leerPuertoB:

		IN rx, PINB // leo el puerto B
		st Y, r16
		call obtenerMaximoX
		cp rx, maximoX
		brlo FinalizarConCuenta

		jmp FinalizarConOverflow


obtenerMaximoX:
		ldi maximoX, 0
loop:
		inc maximoX
		mov r5, rx // auxiliar
		mov rx, maximoX
		call calcularCuenta
		mov rx, r5 // recupero
		
		ldi r18, 0
		cp r18, cuentaH // la parte alta de la cuenta es mayor a 0 entonces la cuenta > 255
		brlo loop

		dec maximoX
		ret 
calcularCuenta:
		mov r3, rx // auxiliar

		mul r3, r3 // Hago x*x
		movw cuentaL, r0 // Me traigo el resultado r0:r1 en cuentaL:cuentaH

		lsl r3 // Hago x*2
		adc cuentaL, r3 // x*x + x*2
		ldi r16, 0
		adc cuentaH, r16

FinalizarConOverflow:
		ldi r18, 0xFF
		OUT PORTC, r18

FinalizarConCuenta:
		call calcularCuenta
		OUT PORTC, cuentaL