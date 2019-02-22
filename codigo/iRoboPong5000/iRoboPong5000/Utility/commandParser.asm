
parse_execute_command: // La diferencia con el anterior es que a esta rutina la llamo desde el modo manual
		
		cpi IN_COMMAND, 's'					// STAND BY
		breq stand_by_jump

		cpi IN_COMMAND, 'a'					// MODO AUTOMATICO
		breq receive_auto_mode

		cpi IN_COMMAND, 'b'					// BACKSPIN
		breq set_backspin_call
			
		cpi IN_COMMAND, 't'					// TOPSPIN
		breq set_topspin_call

		cpi IN_COMMAND, 'v'					// SET FIRE SPEED
		breq receive_fire_speed

		cpi IN_COMMAND, 'n'					// SER FIRE ANGLE
		breq receive_fire_angle				

		cpi IN_COMMAND, 'd'
		breq shoot_jump

		cpi IN_COMMAND, 'm'
		breq start_mixer_call
		
		jmp await_command

receive_fire_speed:
		call usart_recieve_command
		mov PARAMETER, IN_COMMAND
		call set_ball_speed
	ret

receive_fire_angle:
		call usart_recieve_command
		mov PARAMETER, IN_COMMAND
		call set_fire_angle
	ret

receive_auto_mode:
		call usart_recieve_command
		mov PARAMETER, IN_COMMAND

		// Limpio la interrupcion
		ldi r16, (1 << RXC0)
		lds r17, UCSR0A

		or r16, r17
		sts UCSR0A, r16

		mov PARAMETER, IN_COMMAND
	jmp automatic_mode
		

set_topspin_call:
		call set_topspin
		ret

stand_by_jump:
		jmp stand_by
		

set_backspin_call:
		call set_backspin
		ret

shoot_jump:
		call shoot
		ret

start_mixer_call:
		call start_mixer
		ret