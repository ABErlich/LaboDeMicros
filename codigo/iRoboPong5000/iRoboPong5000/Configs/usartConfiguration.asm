
.equ BAUD_RATE_L = 103
.equ BAUD_RATE_H = 0

usart_init:
		
		cli							// deshabilito interrupciones globales mientras inicializo 
        
        ldi r17, BAUD_RATE_H
        ldi r16, BAUD_RATE_L		// pongo 103 en los registros r17:r16

        sts UBRR0H, r17
        sts UBRR0L, r16				// setea el baud rate en 9600

        ldi r16, (1<<RXEN0)|(1<<RXCIE0)
        sts UCSR0B,r16				// activa la recepcion y la interrupcion al terminar una recepcion

        ldi r16, (3<<UCSZ00)		// modo asyncronico
        sts UCSR0C,r16				// Seteo el format de frame: 8 bits de datos, 1 bit de final

		
		sei							// vuelvo a activar interrupciones globales


    ret

