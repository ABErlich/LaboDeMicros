/*
 * EjercicioParcial6.asm
 *
 *  Created: 9/10/2018 13:20:20
 *   Author: Axel
 */ 

 // Calcular el bit de paridad del byte alojado en r20
 // Luego enviar el dato + el bit de paridad por el puerto PB.1
 // Se debe generar el reloj de la trasmision en el puerto PB.2
 // siendo valido el bit de dato en el flanco descendente del reloj
 
 // NOTA: El bit de paridad es 1 si el numero de 1s en el byte es impar
 
 .org 0
 rjmp main
 
 
 .org 300
 main: 
	
	ldi r17, 0
	ldi r16, 0

	ldi r20, 40
	mov r0, r20
	

calcular_paridad:
	
	inc r16
	cpi r16, 9
	breq fin_calculo_paridad

	rol r0
	brcc calcular_paridad
	inc r17
	jmp calcular_paridad


fin_calculo_paridad:

	// en r17[0] tengo el bit de paridad
	andi r17, 0x01
	
trasmitir_dato:
	
	sbi DDRB, 1 // Setea el pin 1 del puerto B como salida
	sbi DDRB, 2 // Setea el pin 2 del puerto B como salida

