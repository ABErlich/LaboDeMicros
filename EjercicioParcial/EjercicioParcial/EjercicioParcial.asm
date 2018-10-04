
.include "m2560def.inc"

.cseg
.org 0
rjmp main

.org 300
main:
	sbi	DDRB, 2  // bit 2 del puerto b como salida
	ldi r16, 4
	sts pos,r16
loop:
    lds r0, pos  // cargo x en r0 desde la ram
    // asumo que en r1 tengo el y[k] inicial

    lsr r0 // x = x/2    
    lsr r0 // x = x/2

    mov r2, r1 // copio y[k] en r2
    mov r3, r1 // copio y[k] en r3

    lsr r2 // y[k] = y[k]/2

    lsr r3 // y[k] = y[k]/2
    lsr r3 // y[k] = y[k]/2
    lsr r3 // y[k] = y[k]/2

    add r2, r3 // y[k]/2 + y[k]/8 = y[k]*5/8

    add r16, r2 // Cuenta completa en r0
    mov r1, r0 // lo guardo en r1

    ////////////////////////////// COMPARO

    subi r16, 129

	// comparo con 129 porque no hay forma de comparar <= o >
    brlo prenderPuertoB2

    jmp apagarPuertoB2


    prenderPuertoB2:
        sbi	PORTB, 2
    jmp loop


    apagarPuertoB2:
        cbi	PORTB, 2
    jmp loop



.dseg
	.org 0x200
	pos: .byte 1

