/*
 * Ejercicio_LeoRom.asm
 *
 *  Created: 9/10/2018 17:27:49
 *   Author: Axel
 */ 

 // Tener cuidado de deshabilitar interrupciones globales cuando se trabaja con EPROM

EEPROM_write:
		; Wait for completion of previous write
		sbic EECR, EEPE 
		rjmp EEPROM_write

		ldi r18, 0x00
		ldi r17, 0x1D

		; Seteo la direccion de escritura
		out EEARH, r18
		out EEARL, r17

		; dato que voy a escribir
		ldi r16, 0x67
		out EEDR,r16

		sbi EECR, EEMPE // EEMPE : Master Programming enable, este es el habilitador de escritura

		sbi EECR,EEPE // EEPE: Programming enable, una vez puesta la direccion y dato, se pone este en 1 para escribir
						// Se limpia automaticamente despues de 4 ciclos
		ret