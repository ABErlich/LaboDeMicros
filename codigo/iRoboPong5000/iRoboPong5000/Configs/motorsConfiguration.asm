.dseg
CURRENT_SPIN_TYPE: .byte 1


.cseg

ldi Yl, low(CURRENT_SPIN_TYPE)
ldi yH, high(CURRENT_SPIN_TYPE)

.equ DEFAULT_FIRE_SPEED = 0

.equ DEFAULT_FIRE_ANGLE = 9 // Angulo 0
.equ FIRE_ANGLE_REG = OCR1AL

.equ DEFAULT_FIRE_STATE = 9 // Angulo 0
.equ FIRE_ENABLE_REG = OCR1BL

.equ FIRE_SPEED_REG1 = OCR3CL		// PIN 3
.equ FIRE_SPEED_REG2 = OCR3AL		// PIN 5

.equ DEFAULT_MIXING_SPEED = 100
.equ MIXING_SPEED_REG = OCR0A

motors_init:
		// EN RESUMEN:
		// MOTOR DISPARADOR 1: PIN 2, 1 o 0 setea direccion de rotacion  
		// MOTOR DISPARADOR 1: PIN 3, PWM

		// MOTOR DISPARADOR 2: PIN 4, 1 o 0 setea direccion de rotacion
		// MOTOR DISPARADOR 2: PIN 5, PWM

		// MOTOR MEZCLADOR: PIN 13, PWM, el otro pin ponerlo a GND

		// SERVO DIRECCION: PIN 11, PWM, el otro pin ponerlo a GND

		// SERVO ALIMENTADOR: PIN 12 PWM, el otro pin ponerlo a GND

		ldi r16, TOPSPIN
		st Y, r16					// Seteo el tipo de spin inicial

pin_config:
		// Pongo los pines de los puertos necesarios como salida 
		// Uno de los pines va a estar en 0 o 1 dependiendo de la direccion y el otro va a tener el PWM
		sbi	DDRE, PE4				// PIN 2, si esta en 0 va en un sentido si esta en 1 va en el otro
		sbi	DDRE, PE5				// PIN 3 PWM motores disparadores	
		
		sbi	DDRE, PG5				// PIN 4, si esta en 0 va en un sentido si esta en 1 va en el otro
		sbi	DDRE, PE3				// PIN 5 PWM motores disparadores	

		sbi	DDRB, PB7				// PIN 13 PWM motor mezclador 
		// Aca no tengo un pin para la direccion ya que no me interesa, es solo un motor para revolver las pelotitas

		
		sbi DDRB, PB5				// PIN 11 PWM servo

		sbi DDRB, PB6				// PIN 12 PWM servo habilitador 		
		
fire_motors_config:
		lds r16, TCCR3B
		ori r16, 0b00001001			// WGM32 = 1 CS30 = 1: No prescaling
		sts TCCR3B, r16

		// Configuro PWM para los motores del disparador
		lds r16, TCCR3A
		ori r16, 0b10001001			// COM3C1 = 1, COM3A1 = 1
		sts TCCR3A, r16

		ldi r16, DEFAULT_FIRE_SPEED	
		sts FIRE_SPEED_REG1, r16	
		sts FIRE_SPEED_REG2, r16

mixing_motor_config:
		

		IN r16, TCCR0A
		sbr r16, 0b10000011			// WGM00 = 1, WGM01 = 1, COM0A1 = 1 ----> PWM, TOP=MAX, Actualiza OCR en TOP
		OUT TCCR0A, r16

		IN r16, TCCR0B
		sbr r16, 0b00000001			// CS01 = 1: No prescaling
		OUT TCCR0B, r16

		ldi r16, DEFAULT_MIXING_SPEED	// Velocidad inicial
		OUT MIXING_SPEED_REG, r16		// Comparador

fire_enable_motor_config:
		// WGMn3:0 = 15 en fast pwm ----> OCRnA for defining TOP
		// Configuro PWM para el servo
		lds r16, TCCR1A
		ori r16, 0b00100001			// WGM10 = 1, COM1B1 = 1 ----> PWM, TOP=MAX o MAX CUSTOM, Actualiza OCR en TOP
		sts TCCR1A, r16

		//El servo requiere de una frecuencia especifica de 50 Hz para funcionar
		lds r16, TCCR1B
		ori r16, 0b00001101			// WGM32 = 1, WGM33 = 1, CS30 = 1: prescaler en 256 para lograr una frecuencia de 60 Hz
		sts TCCR1B, r16

		ldi r16, DEFAULT_FIRE_STATE		// Angulo inicial
		sts FIRE_ENABLE_REG, r16		

servo_motor_config:
		// WGMn3:0 = 15 en fast pwm ----> OCRnA for defining TOP
		// Configuro PWM para el servo
		lds r16, TCCR1A
		ori r16, 0b10000001			// WGM10 = 1, WGM11 = 1, COM1A1 = 1 COM1A0 = 0 ----> PWM, TOP=MAX o MAX CUSTOM, Actualiza OCR en TOP
		sts TCCR1A, r16


		//El servo requiere de una frecuencia especifica de 50 Hz para funcionar
		lds r16, TCCR1B
		ori r16, 0b00001101			// WGM12 = 1, WGM13 = 1, CS12 = 0, CS11 = 1, CS10 = 1: prescaler en 256 para lograr una frecuencia de 60 Hz
		sts TCCR1B, r16

		ldi r16, DEFAULT_FIRE_ANGLE		// Angulo inicial
		sts FIRE_ANGLE_REG, r16		

	ret

	 

