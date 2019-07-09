.equ TOPSPIN = 0b00000000
.equ BACKSPIN = 0b00000001
.def PARAMETER = r16
.def PARAMETER2 = r17

sixteenth_delay:
		ldi  r18, 5
		ldi  r19, 75
		ldi  r20, 191
	L5: dec  r20
		brne L5
		dec  r19
		brne L5
		dec  r18
		brne L5
		nop
	ret


delay_timer:					// 1 segundo delay
		ldi r16, low(49910)
		ldi r17, high(49910)		

		sts TCNT5H, r17
		sts TCNT5L, r16

		ldi r16, (1 << TOIE5)
		sts TIMSK5, r16

		ldi r16, 0b00000101 //(1<<CS50) | (1<<CS52) // Prescaler 1024
		sts TCCR5B, r16
		sei
		sleep
		ret

half_delay_timer:					// medio segundo delay
		ldi r16, low(57723)
		ldi r17, high(57723)		

		sts TCNT5H, r17
		sts TCNT5L, r16

		ldi r16, (1 << TOIE5)
		sts TIMSK5, r16

		ldi r16, 0b00000101 //(1<<CS50) | (1<<CS52) // Prescaler 1024
		sts TCCR5B, r16
		sei
		sleep
		ret

TIM5_OVF:
		reti