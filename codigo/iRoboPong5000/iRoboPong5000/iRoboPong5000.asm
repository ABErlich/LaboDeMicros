 .include "m2560def.inc"

.def IN_COMMAND = r25

.org 0
rjmp initial_config

.org $0032						//USART0 Rx Complete
jmp USART0_RXC

.org $0064
jmp TIM5_OVF					//Timer5 Overflow Handler


.org INT_VECTORS_SIZE

.include "./Configs/motorsConfiguration.asm"
.include "./Configs/usartConfiguration.asm"
.include "./Utility/utility.asm"
.include "./communicationController.asm"
.include "./fireController.asm"
.include "./Utility/commandParser.asm"
.include "./automaticMode.asm"

initial_config:
		
		// Configuro la comunicacion serial
		call usart_init

		// Configuro motores
		call motors_init
		call set_topspin

		ldi r16,(1<<SE)			// Habilito el modo sleep, tipo: IDLE
		out SMCR, r16
		
stand_by:
		/////// SETEO ESTADO STAND BY
		/////////////////////////
		call stop_mixer

		ldi PARAMETER, '0'
		call set_ball_speed

		ldi PARAMETER, '3'		// 90 grados
		call set_fire_angle
		
		/////////////
		/////////////

await_command:


		call usart_recieve_command
		call parse_execute_command

		jmp await_command