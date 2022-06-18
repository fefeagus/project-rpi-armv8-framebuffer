.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "figuras.s"

/*

Hay fichas básicas y fichas compuestas (Formadas con de las primeras).
Las fichas básicas son un cuadrado decorado de 30x30. Vendrían a ser los "colores" de este tetris.
Las compuestas son las formas del tetris.

Fichas básicas:
	*ficha1: Marco externo negro, interno gris y blanca al medio (Tipo 1)
	*ficha2: Marco blanco, interior negro (Tipo 2)
	*ficha20: Marco externo blanco, interno gris, interior negro. (Tipo 20)
Fichas compuestas:
	*ficha3: 	(Tipo 1)
		**
		**
	*ficha4:
		 **
		**
	*ficha5:
		 *
		**
		*
	*ficha6:
		**
		 **
	*ficha7:
		*
		**
		 *
	*ficha8:
		*
		***
	*ficha9:
		***
		  *
	*ficha10:
		 *
		 *
		**
	*ficha11:
		*
		*
		**
	*ficha12:
		***
		*
	*ficha13:
		  *
		***
	*ficha14:	(Tipo 2)
		 *
		***
	*ficha15:
		***
		 *
	*ficha16:
		 *
		**
		 *
	*ficha17:
		*
		**
		*
	*ficha18:
		*
		*
		*
		*
	*ficha19:
		****
	*ficha0:	(Tipo 20)
		 *
		***
	*ficha21:	(Tipo 1)
		**
		**

Los tipos de cada ficha pueden consultarse en el cuerpo de cada función

*/


//-----------FUNCIONES FICHA-----------------

ficha0:// ficha con forma de t hacia arriba	(Tipo 1)
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	
	add x6,x6,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	sub x6,x6,30
	sub x5,x5,30
	bl ficha20
	

	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret


//Parámetros de toda función ficha/destroy:
//x5->coordenada x
//x6->coordenada y
ficha1: 
	sub sp,sp,8
	STUR x30, [SP, 0]

	mov x0, x5
	mov x1,x6
	mov x2 , 30
	mov x3,0
	bl square

	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	movz x3, 0xAE, lsl 16
	movk x3, 0xAEAE, lsl 0
	bl square

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

	mov x0, x5
	mov x1,x6
	mov x2 , 30
	movz x3, 0xFF, lsl 16
	movk x3, 0xFFFF, lsl 0 
	bl square

	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	mov x3,0
	
	bl square


	LDR x30, [SP, 0]
	add sp,sp,8
	ret	

ficha3:// cuadrado de cuatro bloques 		(TIPO 20)
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha1
	add x5,x5,30
	bl ficha1
	add x6,x6,30
	bl ficha1
	sub x5,x5,30
	bl ficha1

	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	
ficha4:// ficha con forma de s
	// **
	//**
	
	sub sp,sp,8
	STUR x30, [SP, 0]

	add x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	sub x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

	
ficha5:// ficha con forma de s de pie
	// *
	//**
	//*
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	add x5,x5,30
	bl ficha2
	add x6,x6,30
	bl ficha2
	sub x5,x5,30
	bl ficha2
	add x6,x6,30
	bl ficha2
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret



ficha6:// ficha con forma de s invertida 
	sub sp,sp,8
	STUR x30, [SP, 0]
	//**
	// **
	
	bl ficha2
	add x5,x5,30
	bl ficha2
	add x6,x6,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret


	
ficha7:// ficha con forma de s invertida de pie
	sub sp,sp,8
	STUR x30, [SP, 0]
	//*
	//**
	// *

	bl ficha1
	add x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	add x6,x6,30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret



ficha8:// ficha con forma de l invertida acostada a la derecha  
	//*
	//***
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha2
	add x6,x6,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	
	
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	


ficha9:// ficha con forma de l invertida acostada a la izquierda
	//***
	//  *
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha20
	add x5, x5, 30
	bl ficha20
	add x5, x5, 30
	bl ficha20
	add x6, x6, 30
	bl ficha20
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret



ficha10:// ficha con forma de l invertida
	// *
	// *
	//**
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
	add x6,x6,30
	bl ficha1
	add x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

	

ficha12:// ficha con forma de l acostada derecha	
	sub sp,sp,8
	STUR x30, [SP, 0]
	//***
	//*
	add x6,x6,30
	bl ficha1
	sub x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret

	

ficha13:// ficha con forma de l acostada izquierda
	//  *
	//***
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	

	add x6,x6,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	sub x6,x6,30
	bl ficha1
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

	
ficha14:// ficha con forma de t para arriba	
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	//ficha 2
	add x6,x6,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	sub x6,x6,30
	sub x5,x5,30
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

	add x5,x5,30
	bl ficha20
	add x6,x6,30
	bl ficha20
	add x6,x6,30
	bl ficha20
	sub x5,x5,30
	sub x6,x6,30
	bl ficha20
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	

ficha17:// ficha con forma de t lado derecho
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	bl ficha2
	add x6,x6,30
	bl ficha2
	add x6,x6,30
	bl ficha2
	sub x6,x6,30
	add x5,x5,30
	bl ficha2
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret


ficha18:// ficha recta
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl ficha20
	add x6, x6, 30
	bl ficha20
	add x6, x6, 30
	bl ficha20
	add x6, x6, 30
	bl ficha20
	sub x6,x6,60
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret
	

ficha19:// ficha recta acostada
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl ficha20
	add x5, x5, 30
	bl ficha20
	add x5, x5, 30
	bl ficha20
	add x5, x5, 30
	bl ficha20
	add x6, x6, 30
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret
	

ficha20: //parametros: x5->coord x de donde sale la ficha
	sub sp,sp,8
	STUR x30, [SP, 0]

	mov x0, x5
	mov x1,x6
	mov x2 , 30
	movz x3, 0xFF, lsl 16
	movk x3, 0xFFFF, lsl 0 
	bl square

	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	movz x3, 0xAE, lsl 16
	movk x3, 0xAEAE, lsl 0
	bl square

	mov x0, x5
	add x0,x0,10
	mov x1,x6
	add x1,x1,10
	mov x2 , 10
	mov x3,0
	bl square
	

	LDR x30, [SP, 0]
	add sp,sp,8
	ret	
	
ficha21:// cuadrado de cuatro bloques 		(TIPO 20)
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl ficha2
	add x5,x5,30
	bl ficha2
	add x6,x6,30
	bl ficha2
	sub x5,x5,30
	bl ficha2

	LDR x30, [SP, 0]
	add sp,sp,8
	ret

