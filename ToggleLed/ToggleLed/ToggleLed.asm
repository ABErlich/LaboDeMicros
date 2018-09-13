/*
 * ToggleLed.asm
 *
 *  Created: 12/09/2018 19:35:05
 *   Author: AErlich
 */ 

 // Al pulsar un boton, deberia cambiar el estado del led

.include "m2560def.inc"

	.org 0
	rjmp main

.org 300

.equ LED = 7
.equ BOTON = 0

main:
		sbi	DDRB, LED  // bit 7 del puerto b como salida
		cbi DDRB, BOTON  // bit 6 del puerto b como entrada

		// Si DDRB se setea como salida, PORTB me sirve para setear un valor logico
		// Si DDRB se setea como entrada, PORTB me habilita o deshabilita la resistencia de pullup
		// Configuro el resistor de pullup para el bit de entrada, para que este por defecto en 1
		// Ver si por defecto tengo las resistencias de pullup activas o no
		sbi PORTB, BOTON


loop:			// Mi loop principal
		
		in r16, PINB  // Leo el puerto B, no se porque el puerto B...
		ldi r17, 1 // Uso el r17 esto como mascara

		and r16, r17 // aplico la mascara a r0

		// Ahora en r0 tengo el valor de la entrada
		//dec r0 // Le resto 1 para setear los flags
		cpi r16, 1

		brne delayAndRead  // si en r0 tengo 0, salto a toggleLed, sino sigue el loop


		/*
		OTRA OPCION:
			SBIC: lee un bit directamente de un puerto, y si esta o no en 1, skipea la siguiente instruccion
			esto me evita de hacer la logica que hice arriba.
		*/

		rjmp loop 

delayAndRead:
	
		call demora // Seteo un delay para revalidar la lectura del pin
	
		in r16, PINB  // Leo el puerto B
		ldi r17, 1 // Uso el r17 esto como mascara

		and r16, r17 // aplico la mascara a r0

		// Ahora en r0 tengo el valor de la entrada
		//dec r0 // Le resto 1 para setear los flags
		cpi r16, 1

		brne toggleLed // Si nuevamente se leyo el valor de cambio, voy al led
		jmp loop

toggleLed:
		// Me fijo si el led estaba prendido,
		in r16, PINB

		ldi r17, 0b10000000 // Uso el r17 esto como mascara

		eor r16,r17 // x-or

		LSL r16 // Shifteo a la izquierda y hago que el bit mas significativo vaya al carry

		BRCS turnOnLed // Si el carry esta en 1, seteo el led

		jmp turnOffLed // Si el carry esta en 0, apago el led


turnOnLed:
		sbi	PORTB, LED
		jmp loop

turnOffLed:
		cbi	PORTB, LED
		jmp loop

		
demora:
		ldi r16, 255
loop2:
		
		dec r16
		brne loop2
		
		ret