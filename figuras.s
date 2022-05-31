
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "app_fun.s"

	//------- dibujo del marco
	// STUR x30, [SP, 0]
	// LDR x30, [SP, 0]
	// ret
marco:	//------- dibujo del marco
	STUR x30, [SP, 0]
	mov x0, 0
	mov x1, 0
	mov x2, 480
	mov x3, 40

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
	mov x0, 600
	mov x1, 0
	mov x2, 480
	mov x3, 40
	
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
	mov x0, 40
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	bl rectangle
	//--------------rect vertical izq
	mov x0, 540
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	bl rectangle
	//-------------rect vertical der
	mov x0, 100
	mov x1, 40
	mov x2, 20
	mov x3, 500
	
	bl dark_gray
	bl rectangle
	//-------------rect horizontal arriba
	mov x0, 100
	mov x1, 300
	mov x2, 20
	mov x3, 500
	
	bl dark_gray
	bl rectangle
	//--------------rect horizontal abajo
	LDR x30, [SP, 0]
	ret //recupero el registro x30 y retorno
	
Botones:	//------------ botones ----------
	//cruz negra
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
	
Animatic: 	//--------animacion
	STUR x30, [SP, 0]
	movz x4, 0x00, lsl 16
	//movk x4, 0x2000, lsl 0    // color inicial de la linea
	movk x4, 0x2000, lsl 0
	mov x7,60			 
	//∧-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo

	mov x0, 350                      
	// ∧---parametros importantes para futura funcion x0, x1 coordenadas de la ficha
	mov x1, 60
	mov x2 , 30
	movz x3, 0xFF, lsl 16
	movk x3, 0xFFFF, lsl 0            //<- cuadradito blanco
	mov x6 ,x1
	
	
	mov x5, 0    
	moveloop:
		mov x0, 400
		bl delay
		mov x0, 350
		mov x1, x6
		mov x2 , 30
		movz x3, 0xFF, lsl 16
		movk x3, 0xFFFF, lsl 0	
		bl square
		cmp x5, 7
		b.eq InfLoop
		add x6, x6, 30
		add x5,x5,1
		mov x0, 1600
		bl delay
		bl sweepline
		add x4,x4,0x1000
		add x7,x7,30
		b moveloop

	LDR x30, [SP, 0]
	ret //recupero el registro x30 y retorno
	
	InfLoop: 
		b InfLoop
		ret






