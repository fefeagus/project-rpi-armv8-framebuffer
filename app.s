
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "app_fun.s"

.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	//---------------- CODE HERE ------------------------------------
	//Como convencion, X0 será la direccion de retorno de las funciones
	
	movz x10, 0x00, lsl 16
	movk x10, 0x0000, lsl 00

	mov x3, 0

	newline:
		mov x1, 19200      //  cant pixeles de cada linea ( (640*480)/16 )
		
	loop0:
		stur w10,[x0]	   // Set color of pixel N
		add x0,x0,4	   // Next pixel
		sub x1,x1,1  	   // decrement X counter
		cbnz x1,loop0	   // If not end of line go to loop0
					
		// el loop 0 hace 1 linea o rectangulo de 40 de largo por 480 de ancho

	setcolor:
		add x3,x3,1
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
	mov x0, 40
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	
	bl rectangle
	
	mov x0, 540
	mov x1, 40
	mov x2, 280
	mov x3, 60

	bl dark_gray
	
	bl rectangle
	
	mov x0, 100
	mov x1, 40
	mov x2, 20
	mov x3, 500
	
	bl dark_gray
	
	bl rectangle
	
	
	//--------- botones
	
	mov x0, 100
	mov x1, 350
	mov x2, 100
	mov x3, 24
	
	movz x4, 0x00, lsl 16
	movk x4, 0x0000, lsl 0
	
	bl rectangle
	
	mov x0, 64
	mov x1, 387
	mov x2, 24
	mov x3, 100
	
	movz x4, 0x00, lsl 16
	movk x4, 0x0000, lsl 0
	
	bl rectangle
	//-- cruz negra
	
	//------------------------------------------------
	
	//-- botones rojos
	
	
	mov x1,500
	mov x2,400
	mov x3,50
	mov x4,0xFF0000
	bl circle	
	
	mov x1,350
	mov x2,400
	mov x3,50
	mov x4,0xFF0000
	bl circle
	
	//---- kirby?
	
	mov x1,200
	mov x2,200
	mov x3,51
	mov x4,0
	bl circle
	
	mov x1,200
	mov x2,200
	mov x3,50
	movz x4, 0xFD, lsl 16
	movk x4, 0x00FF, lsl 0
	bl circle
	
	mov x0, 200
	mov x1, 200
	mov x2, 20
	mov x3, 14
	mov x4,0
	bl rectangle
	
	mov x0, 201
	mov x1, 200
	mov x2, 22
	mov x3, 12
	mov x4,0
	bl rectangle
	
	mov x0, 202
	mov x1, 200
	mov x2, 23
	mov x3, 10
	mov x4,0
	bl rectangle
	
	mov x0, 203
	mov x1, 200
	mov x2, 24
	mov x3, 8
	mov x4,0
	bl rectangle
	
	//----- brazo morado
	mov x0, 201
	mov x1, 200
	mov x2, 17
	mov x3, 14
	movz x4, 0xD8, lsl 16
	movk x4, 0x00D8, lsl 0
	bl rectangle
	
	
	//-------------------
	
	b InfLoop

	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
