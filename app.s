
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "fichas.s"

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
					
		// el loop 0 hace 1 linea o rectangulo de 30 de largo por 480 de ancho

	setcolor:
		add x3,x3,1
		add x10,x10,0x1000 // voy sumando bits del color q quiero al anterior color y me voy acercando
		cmp x3,16 // si x3 es 16 significa que ya dibuje las 16 lineas y debo parar( la primera la dibujo cuando x3 es 0) 
		b.ne newline
	
	bl marco
	bl Botones

	mov x5, 110
	bl Anim14
	mov x5, 140
	bl Anim5
	mov x5, 260
	bl Anim15

	//-------------------
	
	
	//---------------------------------------------------------------
	// Infinite Loop 
	InfLoop:
		bl InfLoop
