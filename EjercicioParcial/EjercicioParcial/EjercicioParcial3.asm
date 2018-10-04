;Realizar una rutina que cuente la cantidad de palabras que hay en un string de memoria RAM definido como: STRPARRAFO

;La longitud de STRPARRAFO va entre 0 y 1000 inclusive y siempre termina con el caracter '\0'
;Las palabras estan separadas por uno o mas espacios y/o signos de puntuacion

.include "m2560def.inc"

.cseg
.org 0
rjmp main_loop

.org 300
main_loop:

    /* Inicializo el stack pointer */
		LDI        R16,LOW(RAMEND)
		LDI        R17,HIGH(RAMEND)
		OUT        SPL,R16
		OUT        SPH,R17

    ; INICIALIZACION
    ldi r16, 0
    sts memoryOffset, r16 ; arranco con un offset de 0
    sts wordCount, r16  ; cantidad de palabras = 0
    sts inWord, r16     ; estoyEnPalabra = False
    ; FIN INICIALIZACION


    ld r0, parrafo+
    ; leo un byte desde la posicion de memoria indicada
    ; si es \0 termino
    ; si es un caracter -> estoyEnPalabra = True
    ; si es espacio o signo de puntuacion && estoyEnPalabra -> cantidadpalabras++, estoyEnPalabra = False

    jmp main_loop


.dseg
	.org 0x200
	wordCount: .byte 1
    inWord: .byte 1
    memoryOffset: .byte 2
