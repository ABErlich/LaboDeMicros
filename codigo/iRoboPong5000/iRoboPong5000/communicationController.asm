usart_recieve_command:
		sleep
		//call parse_execute_command
	ret

has_pending_data:				// me pone el carry en 1 si hay datos para leer en el buffer

        lds r17, UCSR0A         // cargo en r17 el registro  
        lsl r17                 // el bit 7 de UCSRnA me indica si hay datos para leer
    ret

usart_recieve_data: // Si llegue hasta aca es porque hay informacion para leer, leo y vuelvo
        lds IN_COMMAND, UDR0
    ret

USART0_RXC:

		call usart_recieve_data
		
	reti
