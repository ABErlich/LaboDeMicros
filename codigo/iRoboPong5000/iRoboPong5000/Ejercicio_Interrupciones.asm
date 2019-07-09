/*
 * Ejercicio_Interrupciones.asm
 *
 *  Created: 9/10/2018 21:18:26
 *   Author: Axel
 */ 



 .org 0
 rjmp main

 // 3 Registros de configuracion

 main:

		sei // pone el bit de interrupcion global en 1
		
		// EIMSK: Aca activo o desactivo las interrupciones en particular (Interrupciones Externas)
		// EIFR: Aca se setean los flags de cada interrupcion, para apagar un flag le tengo que poner un 1 logico, sino se limpia solo cuando se empieza a ejecutar la interrupcion
		//			Estos flags se setean independientemente de si la interrupcion esta habilitada
		// EICRA (INT3:0) and EICRB (INT7:4): Registro de control para cada interrupcion


