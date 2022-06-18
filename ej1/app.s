
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32

.include "fichas.s"

.globl main

/*
Controla el flujo del la animación. Mostrará una partida de tetris en particular, pero el main
puede ser modificado para mostrar cualquier partida.
*/

main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	
	
	
	//DIBUJA EL FONDO
	movz x10, 0x00, lsl 16
	movk x10, 0x0000, lsl 00
	mov x3, 0
	newline:
		mov x1, 19200      //  cantidad pixeles de cada linea ( (640*480)/16 )
		
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
	
	//Dibuja el marco de la Game Boy
	bl marco
	//Dibuja botones de la Game Boy
	bl Botones
	
	//Notemos que las coordenadas de la pantalla sobre la cual se animará el tetris son:
	
	//Coordenada inicial pantalla x: 110
	//Coordenada final pantalla x: 529
	
	//Coordenada inicial pantalla y: 60
	//Coordenada final pantalla y: 299
	
	
	//Dibujo pantalla
	
	mov x5,11	//1
	mov x6,4
	bl tetris_c
	bl ficha18
	
	mov x5,0	//2
	mov x6,6
	bl tetris_c
	bl ficha14
	
	mov x5,1	//3
	mov x6,4
	bl tetris_c
	bl ficha7
	
	mov x5,7	//4
	mov x6,6
	bl tetris_c
	bl ficha15
	
	mov x5,10	//5
	mov x6,5
	bl tetris_c
	bl ficha10
	
	mov x5,6	//6
	mov x6,5
	bl tetris_c
	bl ficha19
	
	mov x5,3	//7
	mov x6,6
	bl tetris_c
	bl ficha0
	
	mov x5,4	//8
	mov x6,4
	bl tetris_c
	bl ficha7
	
	mov x5,2	//9
	mov x6,3
	bl tetris_c
	bl ficha21
	
	mov x5,7	//10
	mov x6,3
	bl tetris_c
	bl ficha3
	
	mov x5,12	//11
	mov x6,5
	bl tetris_c
	bl ficha5
	
	mov x5,0	//12
	mov x6,3
	bl tetris_c
	bl ficha18
	
	mov x5,4	//12
	mov x6,1
	bl tetris_c
	bl ficha9
	

InfLoop:		//Mantener hasta el infinito
	bl InfLoop	
	
	
	
	//---------------------------------------------------------------

	
		
