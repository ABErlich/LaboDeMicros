shoot:
		// Habilito caida
		ldi r20, 13
		sts FIRE_ENABLE_REG, r20
		call sixteenth_delay
		// deshabilito caida
		ldi r20, 9
		sts FIRE_ENABLE_REG, r20
	ret


set_ball_speed:

		ld r18, Y
		cpi r18, BACKSPIN
		brne its_topspin				// Si es backspin tengo que complementar la velocidad

		call map_backspin_firespeed_ToPWM
		sts FIRE_SPEED_REG1, PARAMETER2
		sts FIRE_SPEED_REG2, PARAMETER
	ret

	its_topspin:
		call map_topspin_firespeed_ToPWM		// Mapeo el valor recibido por parametro 0-5 a un valor de PWM 0-255
		sts FIRE_SPEED_REG2, PARAMETER2
		sts FIRE_SPEED_REG1, PARAMETER
		
	ret

set_fire_angle:
		call map_FireAngle_ToPWM
		sts FIRE_ANGLE_REG, PARAMETER	// asumo que en r16 viene el angulo entre 1 y 5
	ret

start_mixer:
		ldi PARAMETER, DEFAULT_MIXING_SPEED
		OUT MIXING_SPEED_REG, PARAMETER	// asumo que el parametro de la velocidad viene en r16
	ret

stop_mixer:
		ldi PARAMETER, 0
		OUT MIXING_SPEED_REG, PARAMETER	// asumo que el parametro de la velocidad viene en r16
	ret

set_topspin:
		ld r17, Y						// Tengo el tipo de spin actual en r17
		cpi r17, TOPSPIN
		breq return						// si ya tenia topspin no hago nada
		call swich_speeds				// y si es distinto tengo que invertir la velocidad(complementar el PWM)

		ldi r17, TOPSPIN
		st Y, r17						// guardo el tipo de spin

	ret


set_backspin:
		ld r17, Y					// Tengo el tipo de spin actual en r17
		cpi r17, BACKSPIN
		breq return					// si ya tenia backspin no hago nada
		call swich_speeds			// y si es distinto tengo que invertir la velocidad(complementar el PWM)

		ldi r17, BACKSPIN
		st Y, r17					// guardo el tipo de spin
		
	ret

return:
		ret

swich_speeds:
		
		lds r1, FIRE_SPEED_REG1
		lds r2, FIRE_SPEED_REG2

		sts FIRE_SPEED_REG1, r2
		sts FIRE_SPEED_REG2, r1

	ret


map_topspin_firespeed_ToPWM:						
		cpi PARAMETER, '0'
		breq set_topspin_fire_to_0
		cpi PARAMETER, '1'
		breq set_topspin_fire_to_1
		cpi PARAMETER, '2'
		breq set_topspin_fire_to_2
		cpi PARAMETER, '3'
		breq set_topspin_fire_to_3
		cpi PARAMETER, '4'
		breq set_topspin_fire_to_4
		cpi PARAMETER, '5'
		breq set_topspin_fire_to_5

		jmp set_topspin_fire_to_0					// Si el parametro es mayor a 5 o un caracter invalido

<<<<<<< HEAD
	set_fire_to_0:
		ldi PARAMETER, 3
=======
	set_topspin_fire_to_0:
		ldi PARAMETER, 3
		ldi PARAMETER2, 3
>>>>>>> 5f388c1d9647c825ff83a041eecff65a66080e78
		ret
	set_topspin_fire_to_1:
		ldi PARAMETER, 105					
		ldi PARAMETER2, 75
		ret
	set_topspin_fire_to_2:
		ldi PARAMETER, 115
		ldi PARAMETER2, 75
		ret
	set_topspin_fire_to_3:
		ldi PARAMETER, 130
		ldi PARAMETER2, 75
		ret
	set_topspin_fire_to_4:
		ldi PARAMETER, 140
		ldi PARAMETER2, 75
		ret
	set_topspin_fire_to_5:
		ldi PARAMETER, 155
		ldi PARAMETER2, 75
		ret

map_backspin_firespeed_ToPWM:						
		cpi PARAMETER, '0'
		breq set_backspin_fire_to_0
		cpi PARAMETER, '1'
		breq set_backspin_fire_to_1
		cpi PARAMETER, '2'
		breq set_backspin_fire_to_2
		cpi PARAMETER, '3'
		breq set_backspin_fire_to_3
		cpi PARAMETER, '4'
		breq set_backspin_fire_to_4
		cpi PARAMETER, '5'
		breq set_backspin_fire_to_5

		jmp set_backspin_fire_to_0					// Si el parametro es mayor a 5 o un caracter invalido

	set_backspin_fire_to_0:
		ldi PARAMETER, 3
		ldi PARAMETER2, 3
		ret
	set_backspin_fire_to_1:
		ldi PARAMETER, 105					
		ldi PARAMETER2, 70
		ret
	set_backspin_fire_to_2:
		ldi PARAMETER, 110
		ldi PARAMETER2, 70
		ret
	set_backspin_fire_to_3:
		ldi PARAMETER, 115
		ldi PARAMETER2, 70
		ret
	set_backspin_fire_to_4:
		ldi PARAMETER, 120
		ldi PARAMETER2, 70
		ret
	set_backspin_fire_to_5:
		ldi PARAMETER, 125
		ldi PARAMETER2, 70
		ret

map_FireAngle_ToPWM:

		cpi PARAMETER, '1'
		breq set_angle_to_1
		cpi PARAMETER, '2'
		breq set_angle_to_2
		cpi PARAMETER, '3'
		breq set_angle_to_3
		cpi PARAMETER, '4'
		breq set_angle_to_4
		cpi PARAMETER, '5'
		breq set_angle_to_5


		jmp set_angle_to_1					

	set_angle_to_1:				// 0 GRADOS
		ldi PARAMETER, 14		// Estos numeros son arbitrarios, salen de probar fisicamente el resultado
		ret
	set_angle_to_2:				// 45 GRADOS
		ldi PARAMETER, 18	
		ret
	set_angle_to_3:				// 90 GRADOS
		ldi PARAMETER, 23
		ret
	set_angle_to_4:				// 135 GRADOS
		ldi PARAMETER, 27
		ret
	set_angle_to_5:				// 180 GRADOS
		ldi PARAMETER, 31						
		ret
