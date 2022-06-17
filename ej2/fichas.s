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
	*ficha3: 
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
	*ficha14:
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
	*ficha21:
		************** (Ancho de la pantalla)

Los tipos de cada ficha pueden consultarse en el cuerpo de cada función

Cada ficha compuesta x cuenta con:
	Función fichax: Dibuja la ficha en la ubicación solicitada
	Función destroy_fichax: Reemplaza la ficha en la ubicación solicitada con el fondo que corresponda

Por último habrá una función general_animation que arroja la figura solicitada en la posición x solicida a partir de la 
esquina superior izquierda de la figura.

Para crear una ficha nueva N  simplemente se debe definir la función fichaN, su destroy y agregarla en la función general_animation
*/


//-----------FUNCIONES FICHA-----------------

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

	bl ficha20
	add x5,x5,30
	bl ficha20
	add x6,x6,30
	bl ficha20
	sub x5,x5,30
	bl ficha20

	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	
destroy_ficha3:
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	sub x5,x5,30
	bl sweep_square_automatic
	
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

destroy_ficha4:// ficha con forma de s
	// **
	//**
	
	sub sp,sp,8
	STUR x30, [SP, 0]

	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	sub x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	
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
	bl ficha1
	add x6,x6,30
	bl ficha1
	sub x5,x5,30
	bl ficha1
	add x6,x6,30
	bl ficha1
	
	LDR x30, [SP, 0]
	LDR x5, [SP,8]
	add sp,sp,16
	ret

destroy_ficha5:// ficha con forma de s de pie
	// *
	//**
	//*
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	add x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	sub x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	
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

destroy_ficha6:// ficha con forma de s invertida 
	sub sp,sp,8
	STUR x30, [SP, 0]
	//**
	// **
	
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	
	
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

destroy_ficha7:// ficha con forma de s invertida de pie
	sub sp,sp,8
	STUR x30, [SP, 0]
	//*
	//**
	// *

	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	
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
	
destroy_ficha8:// ficha con forma de l invertida acostada a la derecha  
	//*
	//***
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret



ficha9:// ficha con forma de l invertida acostada a la izquierda
	//***
	//  *
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

destroy_ficha9:// ficha con forma de l invertida acostada a la izquierda
	//***
	//  *
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl sweep_square_automatic
	add x5, x5, 30
	bl sweep_square_automatic
	add x5, x5, 30
	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
	
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

destroy_ficha10:// ficha con forma de l invertida
	// *
	// *
	//**
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
	sub x5, x5, 30
	bl sweep_square_automatic
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

destroy_ficha11:// ficha con forma de l	
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	
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

destroy_ficha12:// ficha con forma de l acostada derecha	
	sub sp,sp,8
	STUR x30, [SP, 0]
	//***
	//*
	add x6,x6,30
	bl sweep_square_automatic
	sub x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	
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

destroy_ficha13:// ficha con forma de l acostada izquierda
	//  *
	//***
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	

	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	sub x6,x6,30
	bl sweep_square_automatic
	
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
	
destroy_ficha14:// ficha con forma de t para arriba
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	//ficha 2
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	sub x6,x6,30
	sub x5,x5,30
	bl sweep_square_automatic
	
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


destroy_ficha15:// ficha con forma de t 
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	sub x5,x5,30
	add x6,x6,30
	bl sweep_square_automatic


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
	
destroy_ficha16:// ficha con forma de t lado izquierdo 
	sub sp,sp,8
	STUR x30, [SP, 0]

	add x5,x5,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	sub x5,x5,30
	sub x6,x6,30
	bl sweep_square_automatic
	
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

destroy_ficha17:// ficha con forma de t lado derecho
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	sub x6,x6,30
	add x5,x5,30
	bl sweep_square_automatic
	
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
	
destroy_ficha18:// ficha recta
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]

	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
	add x6, x6, 30
	bl sweep_square_automatic
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
	
destroy_ficha19:// ficha recta acostada
	sub sp,sp,16
	STUR x30, [SP, 0]
	STUR x5,[SP,8]
	
	bl sweep_square_automatic
	add x5, x5, 30
	bl sweep_square_automatic
	add x5, x5, 30
	bl sweep_square_automatic
	add x5, x5, 30
	bl sweep_square_automatic
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


ficha21: //Linea de borrado
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	//También podría implementarse utilizando un único ciclo que se repita 14 veces
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	add x5,x5,30
	

	LDR x30, [SP, 0]
	add sp,sp,8
	ret
	
	
destroy_ficha21: //Linea de borrado
	sub sp,sp,8
	STUR x30, [SP, 0]

	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	bl sweep_square_automatic
	add x5,x5,30
	

	LDR x30, [SP, 0]
	add sp,sp,8
	ret



//PARAMS:
//X0-> Posicion inicial (En el tetris. Va del 0 al 13)
//X1-> Número de iteraciones (Cantidad de veces que baja la ficha)
//X2-> N° Ficha	(Va del 1 al 21 con las fichas implementadas hasta el momento) (Consultar comentarios al incio de fichas.s)

general_animation:	
	sub sp,sp,8
	STUR x30, [SP, 0]
	
	//Save x19..x27
	bl save_preserved_registers
	add x1,x1,1 	//Más natural (0 es figura estática)
	mov x3,30
	mul x23,x0,x3	//x23 -> Coordenada x
	add x23,x23,110
	mov x24,60	//x24 -> Coordenada y
	mov x21,x1 	//Iteraciones Restantes
	mov x22,x2	//N° Ficha
	mov x25, 1600	//DELAY _TIME
	
g_a_bucle:	//Decidir que función ejecutar (Podría ser análogo a un switch/condicionales encadenados)
	sub x21,x21,1
	mov x5,x23
	mov x6,x24
	
	//SWITCH
	CMP x22,3
	B.EQ f_3
	CMP x22,4
	B.EQ f_4
	CMP x22,5
	B.EQ f_5
	CMP x22,6
	B.EQ f_6
	CMP x22,7
	B.EQ f_7
	CMP x22,8
	B.EQ f_8
	CMP x22,9
	B.EQ f_9
	CMP x22,10
	B.EQ f_10
	CMP x22,11
	B.EQ f_11
	CMP x22,12
	B.EQ f_12
	CMP x22,13
	B.EQ f_13
	CMP x22,14
	B.EQ f_14
	CMP x22,15
	B.EQ f_15
	CMP x22,16
	B.EQ f_16
	CMP x22,17
	B.EQ f_17
	CMP x22,18
	B.EQ f_18
	CMP x22,19
	B.EQ f_19
	CMP x22,21
	B.EQ f_21
	//Debería ingresar siempre a uno
	
f_3:
	bl ficha3
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha3
	b continue
f_4:
	bl ficha4
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha4
	b continue
f_5:
	bl ficha5
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha5
	b continue
f_6:
	bl ficha6
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha6
	b continue
f_7:
	bl ficha7
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha7
	b continue
f_8:
	bl ficha8
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha8
	b continue
f_9:
	bl ficha9
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha9
	b continue
f_10:
	bl ficha10
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha10
	b continue
f_11:
	bl ficha11
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha11
	b continue
f_12:
	bl ficha12
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha12
	b continue
f_13:
	bl ficha13
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha13
	b continue
f_14:
	bl ficha14
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha14
	b continue
f_15:
	bl ficha15
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha15
	b continue
f_16:
	bl ficha16
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha16
	b continue
f_17:
	bl ficha17
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha17
	b continue
f_18:
	bl ficha18
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha18
	b continue
f_19:
	bl ficha19
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha19
	b continue
f_21:
	bl ficha21
	mov x0,x25
	bl delay
	cbz x21,END_anim
	mov x5,x23
	mov x6,x24
	bl destroy_ficha21
	b continue
	
continue: 
	add x24,x24,30
	CBNZ x21,g_a_bucle
END_anim:	
	//Restore x19..x27
	bl restore_preserved_registers
	
	LDR x30, [SP, 0]
	add sp,sp,8
	ret


	
	



 //---------------------------- animaciones: parámetros: x5, de donde sale la ficha en el eje de las x ------------------------------

//Dos animaciones especiales
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
	add x5,x5,60
	loop_18:   //movimiento
		
		bl ficha18

		cmp x14, 2
		b.eq ret18
		add x14,x14,1

		mov x0, 1600
		bl delay

		bl sweepline

		b loop_18
	

	
	//recupero el registro x30 y retorno
	ret18: 
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
		mov x0, 200
		bl delay
		bl sweepline
		add x5, x5, 60
		sub x6, x6, 30
		bl ficha10
		LDR x30, [SP, 0]
		add sp, sp, 8
		ret


