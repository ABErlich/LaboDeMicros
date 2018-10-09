/*
 * Ejercicio_EscriboRom.asm
 *
 *  Created: 9/10/2018 17:54:26
 *   Author: Axel
 */ 


EEPROM_read:
		; espera a que se complete la accion anterior
		sbic EECR,EEPE
		rjmp EEPROM_read

		
		ldi r18, 0x00
		ldi r17, 0x1D


		; Setea la direccion de donde se va a leer
		out EEARH, r18
		out EEARL, r17
		
		; Empieza la lectura al setear EERE en 1
		sbi EECR,EERE

		; Read data from Data Register
		in r16,EEDR
		ret