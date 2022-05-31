
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "fun.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	
movz x10, 0x00, lsl 16
movk x10, 0x0000, lsl 00

@@ -31,6 +30,7 @@ movk x10, 0x0000, lsl 00
		add x10,x10,0x1000 // voy sumando bits del color q quiero al anterior color y me voy acercando
		cmp x3,16 // si x3 es 16 significa que ya dibuje las 16 lineas y debo parar( la primera la dibujo cuando x3 es 0) 
		b.ne newline


	//------- dibujo del marco
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

	//----------bordes oscuros 
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


	//--------- botones

	bl dark_gray
	bl rectangle
	//--------------rect horizontal abajo
	//------------ botones ----------
	//cruz negra
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
	//-- cruz negra
	//------------horizontal
	//circulos rojos
	mov x1, 530
	mov x2, 370
	mov x3, 25

	movz x4, 0xC3, lsl 16
	movk x4, 0x1818, lsl 0

	bl circle

	//-------------------
	mov x1, 470
	mov x2, 420
	mov x3, 25

	movz x4, 0xC3, lsl 16
	movk x4, 0x1818, lsl 0

	bl circle
	//--------animacion
	movz x4, 0x00, lsl 16
	//movk x4, 0x2000, lsl 0    // color inicial de la linea
	movk x4, 0x2000, lsl 0
	mov x7,60			 //<-- en x7 voy guardando los parametros que se van pasando en x0 del rectangulo

	mov x0, 350                      // parametros importantes para futura funcion x0, x1 coordenadas de la ficha
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


	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
