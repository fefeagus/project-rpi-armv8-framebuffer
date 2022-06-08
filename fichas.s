.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "figuras.s"

ficha1: //parametros: x5->coord x de donde sale la ficha
	sub sp,sp,8
	STUR x30, [SP, 0]

	mov x0,600
	mov x0, x5
	mov x1,x6
	mov x2 , 30
	movz x3, 0x00, lsl 16
	movk x3, 0x0000, lsl 0 
	bl square

	mov x0,600
	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	movz x3, 0xAE, lsl 16
	movk x3, 0xAEAE, lsl 0
	bl square

	mov x0,600
	mov x0, x5
	add x0,x0,10
	mov x1,x6
	add x1,x1,10
	mov x2 , 10
	movz x3, 0xFF, lsl 16
	movk x3, 0xFFFF, lsl 0
	bl square
	

	LDR x30, [SP, 0]
	add sp,sp,8
	ret	


ficha2: //parametros: x5->coord x de donde sale la ficha
	sub sp,sp,8
	STUR x30, [SP, 0]

	mov x0,600
	mov x0, x5
	mov x1,x6
	mov x2 , 30
	movz x3, 0xFF, lsl 16
	movk x3, 0xFFFF, lsl 0 
	bl square

	mov x0,600
	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	movz x3, 0x00, lsl 16
	movk x3, 0x0000, lsl 0
	bl square


	LDR x30, [SP, 0]
	add sp,sp,8
	ret	

ficha3:// cuadrado de cuatro bloques 
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	sub x5, x5, 30
	sub x6, x6, 30
	bl ficha1
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret	

ficha4:// ficha con forma de s
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	sub x5, x5, 30
	sub x6, x6, 30
	bl ficha1
	bl ficha1
	sub x6, x6, 30
	sub x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	
ficha5:// ficha con forma de s de pie
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha1
    add x5,x5,30
    bl sweepsquare
    add x6,x6,30
	bl ficha1
    sub x5,x5,30
	bl ficha1
    add x5,x5,30
    add x6,x6,30
	bl ficha1
    sub x6,x6,30
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret


ficha6:// ficha con forma de s invertida
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret


	
ficha7:// ficha con forma de s invertida de pie
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	sub x6, x6, 30
	sub x5, x5, 30
	bl ficha1
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha8:// ficha con forma de l invertida acostada a la derecha
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha9:// ficha con forma de l invertida acostada a la izquierda
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha1
	add x5, x5, 30
	bl ficha1
	add x5, x5, 30
	bl ficha1
	add x6, x6, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

ficha10:// ficha con forma de l invertida
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl ficha1
	add x6, x6, 30
	bl ficha1
	add x6, x6, 30
	bl ficha1
	sub x5, x5, 30
	bl ficha1
	sub x6, x6, 60
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

ficha11:// ficha con forma de l
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha12:// ficha con forma de l acostada derecha
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	sub x6, x6, 60
	add x5, x5, 30
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha13:// ficha con forma de l acostada izquierda
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	

	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	sub x6, x6, 60
	bl ficha1
	add x6, x6, 30
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret
	
ficha14:// ficha con forma de t para arriba
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl sweepsquare

	add x6,x6,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	sub x6,x6,30
	bl ficha2
	add x5,x5,30

	bl sweepsquare
	
	add x6,x6,30
	bl ficha2

	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

ficha15:// ficha con forma de t
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha2
	add x5,x5,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	sub x5,x5,30
	add x6,x6,30
	bl ficha2

	//add x6,x6,30 //  me muevo una linea hacia abajo en prox llamado

	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

ficha16:// ficha con forma de t lado izquierdo
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	sub x6, x6, 30
	sub x5, x5, 30
	bl ficha1
	add x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha17:// ficha con forma de t lado derecho
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	bl ficha1
	sub x6, x6, 30
	add x5, x5, 30
	bl ficha1
	sub x5, x5, 30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

ficha18:// ficha recta
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha2
	add x6, x6, 30
	bl ficha2
	add x6, x6, 30
	bl ficha2
	add x6, x6, 30
	bl ficha2
	sub x6,x6,60
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

ficha19:// ficha recta acostada
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl ficha2
	add x5, x5, 30
	bl ficha2
	add x5, x5, 30
	bl ficha2
	add x5, x5, 30
	bl ficha2
	add x6, x6, 30
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret


 //---------------------------- anim ficha 14--------------------------------------	
Anim14: //parametros-> x19 de que lugar sale la ficha  
	sub sp, sp,8
	STUR x30, [SP,0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	loop_14:          //-- movimiento
		bl ficha14

		cmp x14, 6
		b.eq ret14
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline

		b loop_14
	

	
	//recupero el registro x30 y retorno
	ret14: 
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret


 //---------------------------- anim ficha15 --------------------------------------	
Anim15: //parametros-> x19 de que lugar sale la ficha  
	sub sp, sp,8
	STUR x30, [SP,0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	loop_15:   //movimiento
		bl ficha15

		cmp x14, 6
		b.eq ret15
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline

		b loop_15
	

	
	//recupero el registro x30 y retorno
	ret15: 
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret


Anim5: //parametros-> x19 de que lugar sale la ficha  
	sub sp, sp,8
	STUR x30, [SP,0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	loop_5:   //movimiento
		bl ficha5

		cmp x14, 4
		b.eq ret5
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline

		b loop_5
	

	
	//recupero el registro x30 y retorno
	ret5: 
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret

Anim18: //parametros-> x19 de que lugar sale la ficha  
	sub sp,sp,8
	STUR x30, [SP, 0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	
	bl ficha19
	mov x0, 1600
	bl delay
	bl sweepline120
	bl ficha19
	mov x0, 1600
	bl delay
	bl sweepline120
	
	loop_18:   //movimiento
		bl ficha18

		cmp x14, 2
		b.eq ret18
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline120

		b loop_18
	

	
	//recupero el registro x30 y retorno
	ret18: 
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret

	
Anim19: //parametros-> x19 de que lugar sale la ficha  
	sub sp, sp,8
	STUR x30, [SP,0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	
	
	
	loop_19:   //movimiento
		bl ficha19

		cmp x14, 4
		b.eq ret19
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline120

		b loop_19
	

	
	//recupero el registro x30 y retorno
	ret19: 
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret
	

Anim9_10: //parametros-> x19 de que lugar sale la ficha  
	sub sp,sp,8
	STUR x30, [SP, 0]

	movz x4, 0x00, lsl 16  // color inicial de la linea
	movk x4, 0x2000, lsl 0

	mov x7,60		     //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo
	mov x6,60


	mov x14, 0    // iterador
	
	loop_9_10:   //movimiento
		bl ficha9

		cmp x14, 5
		b.eq ret9_10
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline

		b loop_9_10	


	
	//recupero el registro x30 y retorno
	ret9_10: 
		mov x0, 1600
		bl delay
		bl sweepline
		add x5, x5, 60
		sub x6, x6, 30
		bl ficha10
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret
