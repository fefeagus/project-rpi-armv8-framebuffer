
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "app_fun.s"



square: //Assume: lado > 0
	//Parametros
	//X0 -> Coordenada X
	//X1 -> Coordenada Y
	//X2 -> Lado
	//X3 -> Color
	
	mov x15, lr  		//Return auxiliara
	bl xy_pixel  		//x0 -> direccion primer pixel
	
	mov x11,SCREEN_WIDTH
	sub x11,x11,X2 		//Salto por linea
	lsl x11,x11,#2
	
	mov x9,x2 		//altura
	
	loop0_square:
			mov x10,x2 		//ancho
	loop1_square:
			stur w3,[x0]		//Set pixel
			add x0,x0,#4		//Next pixel
			sub x10,x10,#1		//Dec. width
			cbnz x10, loop1_square	//Checks whether line has been drawn
			add x0,x0,x11		//Skip void
			sub x9,x9,#1		//Dec. height
			cbnz x9,loop0_square	//Finish if done
		
	br x15	//return 


circle:
	//x1 -> Coordenada x (Centro)
	//x2 -> Coordenada y (Centro)
	//x3 -> Radio
	//x4 -> Color
	
	mov x0,x20
	mov x13,SCREEN_WIDTH
	mov x14,SCREEN_HEIGH	//Temp mult - Can't Mult by imm
	mul x13,x13,x14
	sub x13,x13,1
	mov x14,4
	mul x13,x13,x14
	add x0,x0,x13 //Starting from last possition

	// r² >= (xc-x)² + (yc-y)²

	mul x3,x3,x3   // r²
	
	mov x9, SCREEN_HEIGH         // Y Size 
	loop1_circle:
		mov x10, SCREEN_WIDTH         // X Size
	loop0_circle:
		sub x11,x1,x10  	//x11 = xc-x
		mul x11,x11,x11		//x11 = (xc-x)²
		sub x12,x2,x9   	//x12  = yc-y
		mul x12,x12,x12		//x12 = (yc-y)²
		add x11,x11,x12 	//x11 = (xc-x)² + (yc-y)²
		cmp x3, x11		//Paint only if r² >= (xc-x)² + (yc-y)²
		b.LT else_circle
		stur w4,[x0]	   // Set color of pixel N
	else_circle:
		sub x0,x0,4	   	// Previus pixel
		sub x10,x10,1	   	// decrement X counter
		cbnz x10,loop0_circle	   // If not end row jump
		sub x9,x9,1	   	// Decrement Y counter
		cbnz x9,loop1_circle	   // if not last row, jump
	br lr


rectangle:
//lado>0
//parametros x0->cordx ; x1->cordY ; x2->largo x3->ancho x4->color
	
	mov x15,lr
	bl xy_pixel
	
	mov x11, SCREEN_WIDTH
	sub x11,x11,x3
	lsl x11,x11,2
	 
	mov x9,x2
	
	loop0_rtg:
		mov x10,x3
	loop1_rtg:
		stur w4,[x0] //set pixel
		add x0,x0,#4 //next pixel
		sub x10,x10,1 //dec width
		cbnz x10,loop1_rtg //check whether line has been drawn
		add x0,x0,x11 //skip void
		sub x9,x9,1 //dec height
		cbnz x9,loop0_rtg //Finish if done
	br x15



//------------------------ figuras compuestas -----------------------

	//------- dibujo del marco
	// STUR x30, [SP, 0]
	// LDR x30, [SP, 0]
	// ret
marco:	//------- dibujo del marco
	sub sp, sp, 8
	STUR x30, [SP, 0]

	mov x0, 0
	mov x1, 0
	mov x2, 480
	mov x3, 50

	bl gray
	bl rectangle
	//--------------------------- lado1
	mov x0, 40
	mov x1, 320
	mov x2, 160
	mov x3, 560
	
	bl gray	
	bl rectangle
	//--------------------------rectangulo grande de abajo
	mov x0, 590
	mov x1, 0
	mov x2, 480
	mov x3, 50
	
	bl gray
	bl rectangle
	//-------------------------lado2
	mov x0, 40
	mov x1, 0
	mov x2, 40
	mov x3, 560
	
	bl gray
	bl rectangle
	//------------------------parte de arriba(gris claro)
	
	//---------------bordes oscuros------------------ 
	mov x0, 50
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	bl rectangle
	//--------------rect vertical izq
	mov x0, 530
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	bl rectangle
	//-------------rect vertical der
	mov x0, 100
	mov x1, 40
	mov x2, 20
	mov x3, 450
	
	bl dark_gray
	bl rectangle
	//-------------rect horizontal arriba
	mov x0, 100
	mov x1, 300
	mov x2, 20
	mov x3, 450
	
	bl dark_gray
	bl rectangle
	//--------------rect horizontal abajo

	LDR x30, [SP, 0]
	add sp, sp, 8

	ret //recupero el registro x30 y retorno
	
Botones:	//------------ botones ----------
	//cruz negra
	sub sp,sp,8
	STUR x30, [SP, 0]
	mov x0, 100
	mov x1, 350
	mov x2, 100
	mov x3, 24
	
	movz x4, 0x00, lsl 16
	movk x4, 0x0000, lsl 0
	
	bl rectangle
	
	//--------------vertical
	mov x0, 64
	mov x1, 387
	mov x2, 24
	mov x3, 100
	
	movz x4, 0x00, lsl 16
	movk x4, 0x0000, lsl 0
	
	bl rectangle
	//------------horizontal
	//circulos rojos
	mov x1, 530
	mov x2, 370
	mov x3, 25
	
	movz x4, 0xC3, lsl 16
	movk x4, 0x1818, lsl 0
	
	bl circle
	
	mov x1, 470
	mov x2, 420
	mov x3, 25
	
	movz x4, 0xC3, lsl 16
	movk x4, 0x1818, lsl 0
	
	bl circle
	LDR x30, [SP, 0]
	ret //recupero el registro x30 y retorno
	
	
//rectangulo que barre el rastro que deja la ficha
sweepline:
	sub sp,sp,8
	STUR lr, [sp, 0]
	mov x0, x5  //<-- el rectangulo enmpieza donde empieza la ficha
	mov x1, x7
	mov x2, 30
	mov x3, 90
	bl rectangle
	
	add x4,x4,0x1000   //<- cambio el color de x4 para el prox llamado para imitar el degradado del fondo
	add x7,x7,30      //<- bajo la linea 1 bloque para el prox llamado
	
	LDR lr, [sp, 0]
	add sp,sp,8
	ret
sweepsquare: //paramteros x6->coord y,x5-->coord x (color sensible al cambio de x4)
	sub sp,sp,8
	STUR lr, [sp, 0]

	mov x0,600
	mov x0, x5
	mov x1, x6
	mov x2 , 30             //<- cuardrado que se adapta al fondo
	mov x3, x4
	bl square
	
	LDR lr, [sp, 0]
	add sp,sp,8

	ret

	sweepline120:
	sub sp,sp,8
	STUR lr, [sp, 0]
	mov x0, x5  //<-- el rectangulo enmpieza donde empieza la ficha
	mov x1, x7
	mov x2, 30
	mov x3, 120
	bl rectangle
	
	add x4,x4,0x1000   //<- cambio el color de x4 para el prox llamado para imitar el degradado del fondo
	add x7,x7,30      //<- bajo la linea 1 bloque para el prox llamado
	
	LDR lr, [sp, 0]
	add sp,sp,8
	ret
