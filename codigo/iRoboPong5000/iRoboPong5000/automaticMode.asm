
automatic_mode:

		cpi PARAMETER, '1'
		breq auto_mode1

		cpi PARAMETER, '2'
		breq auto_mode2_jump

		cpi PARAMETER, '3'
		breq auto_mode3_jump

		ldi IN_COMMAND, 0

		jmp stand_by

auto_mode3_jump:
		jmp auto_mode3
	
auto_mode2_jump:
		jmp auto_mode2

auto_mode1: // Aca vario la velocidad efecto y ubicacion de la pelota para generar ejercicios preestablecidos
		call start_mixer
		call set_topspin

		// BOLA 1
		ldi PARAMETER, '5'
		call set_ball_speed
		ldi PARAMETER, '5'
		call set_fire_angle

		//	DELAY ANTES DE EMPEZAR
		call delay_timer
		call delay_timer
		call delay_timer
		call delay_timer
		///

		call shoot

		call delay_timer
		call half_delay_timer

		// BOLA 2
		ldi PARAMETER, '3'
		call set_fire_angle

		call delay_timer

		call shoot

		call delay_timer
		call half_delay_timer

		// BOLA 3
		ldi PARAMETER, '5'
		call set_fire_angle

		call delay_timer

		call shoot

		call delay_timer
		call half_delay_timer


		// BOLA 4
		ldi PARAMETER, '1'
		call set_fire_angle

		call delay_timer

		call shoot

		cpi IN_COMMAND, 's'
		breq go_to_standby
		
		jmp auto_mode1


auto_mode2:

		call start_mixer

		call set_topspin

		// PARA QUE ARRANQUE MAS RAPIDO
		ldi PARAMETER, '5'
		call set_ball_speed
		///

		call delay_timer
		call delay_timer

		// BOLA 1
		ldi PARAMETER, '3'
		call set_ball_speed
		ldi PARAMETER, '5'
		call set_fire_angle

		//	DELAY ANTES DE EMPEZAR
		
		call delay_timer
		call delay_timer
		call delay_timer
		///

		call shoot

		// BOLA 2
		ldi PARAMETER, '5'
		call set_ball_speed

		call delay_timer
		call shoot

		// BOLA 3
		ldi PARAMETER, '5'
		call set_ball_speed

		call delay_timer
		call shoot

		cpi IN_COMMAND, 's'
		breq go_to_standby
		
		jmp auto_mode2

go_to_standby:
		jmp stand_by

auto_mode3:
		call start_mixer

		call set_topspin

		// PARA QUE ARRANQUE MAS RAPIDO
		ldi PARAMETER, '5'
		call set_ball_speed
		///

		call delay_timer
		call delay_timer

		// BOLA 1
		ldi PARAMETER, '3'
		call set_ball_speed
		ldi PARAMETER, '1'
		call set_fire_angle

		//	DELAY ANTES DE EMPEZAR
		
		call delay_timer
		call delay_timer
		call delay_timer
		///

		call shoot

		// BOLA 2
		ldi PARAMETER, '5'
		call set_ball_speed

		call delay_timer
		call shoot

		// BOLA 3
		ldi PARAMETER, '5'
		call set_ball_speed

		call delay_timer
		call shoot

		cpi IN_COMMAND, 's'
		breq go_to_standby
		
		jmp auto_mode3

