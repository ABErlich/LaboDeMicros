/*
 * EjercicioParcial8.asm
 *
 *  Created: 9/10/2018 15:38:56
 *   Author: Axel
 */ 


 
.cseg 
.org 300

	tabla_flash: .db "Hola mundo!",0
	
	// INICIALIZO EL PUNTERO
	ldi Zl, low(tabla_flash)*2
	ldi Zh, high(tabla_flash)*2
	
	// ahora en Z tengo el puntero a la table de la FLASH entonces:
loop:
	lpm r0, Z+	// Me lee el primer registro desde la flash y actualiza el puntero
	
	jmp loop