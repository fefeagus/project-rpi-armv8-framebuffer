
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
	
	
	
	//Inicio de la animación (La sección siguiente puede ser modificada para obtener otra animación
	
	//Para general animation tenemos que:
	//X0-> Posicion inicial (En el tetris)
	//X1-> Número de iteraciones
	//X2-> N° Ficha	(Codigo de ficha a animar -  Consultar fichas.s)
	
InfLoop:

	mov x5, 380
	bl Anim18	//Animacion especial 1 
	
	mov x0,0
	mov x1,6
	mov x2,14
	bl general_animation	//2 
	
	mov x0,1
	mov x1,4
	mov x2,7
	bl general_animation	//3
	
	mov x0,7
	mov x1,6
	mov x2,15
	bl general_animation	//4
	
	
	mov x5, 350
	bl Anim9_10	//Animacion especial 2
	
	mov x0,6
	mov x1,5
	mov x2,19
	bl general_animation	//6
	
	mov x0,3
	mov x1,6
	mov x2,14
	bl general_animation	//7
	
	mov x0,4
	mov x1,4
	mov x2,7
	bl general_animation	//8
	
	mov x0,2
	mov x1,3
	mov x2,3
	bl general_animation	//9
	
	mov x0,7
	mov x1,3
	mov x2,3
	bl general_animation	//10
	
	mov x0,12
	mov x1,5
	mov x2,5
	bl general_animation	//11
	
	mov x0,0
	mov x1,3
	mov x2,18
	bl general_animation	//12
	
	mov x0,4
	mov x1,3
	mov x2,9
	bl general_animation	//13
	
	mov x0,12
	mov x1,3
	mov x2,17
	bl general_animation	//14
	
	mov x0,9
	mov x1,3
	mov x2,12
	bl general_animation	//15
	
	mov x0,11
	mov x1,2
	mov x2,9
	bl general_animation	//16
	
	mov x0,0
	mov x1,2
	mov x2,15
	bl general_animation	//17
	
	//Se llenó una linea - Procedemos a borrarla
	mov x6,150
	mov x5,110
delete2:bl sweep_square_automatic //Borrar linea inferior
	add x5,x5,30
	cmp x5,500
	B.LE delete2
	
	mov x0, 2350
	bl delay
	
	mov x6,120
	mov x5,110
delete1:bl sweep_square_automatic //Borrar linea superior
	add x5,x5,30
	cmp x5,500
	B.LE delete1
	
	mov x6,150	//Trasladar fichas
	mov x5,110
	bl ficha2
	add x5,x5,30
	bl ficha2
	add x5,x5,30
	bl ficha2
	add x5,x5,270
	bl ficha1
	add x5,x5,30
	bl ficha1
	add x5,x5,30
	bl ficha1
	
	mov x0, 1500
	bl delay
	//La linea ya fue borrada - Seguimos añadiendo fichas nuevas
	
	mov x0,9
	mov x1,2
	mov x2,4
	bl general_animation	//18
	
	mov x0,3
	mov x1,3
	mov x2,19
	bl general_animation	//19
	
	mov x0,5
	mov x1,2
	mov x2,9
	bl general_animation	//20
	
	mov x0,7
	mov x1,1
	mov x2,6
	bl general_animation	//21
	
	mov x0,0
	mov x1,0
	mov x2,11
	bl general_animation	//22
	
	mov x0,2
	mov x1,1
	mov x2,8
	bl general_animation	//23
	
	mov x0,12
	mov x1,0
	mov x2,16
	bl general_animation	//24
	
	
	
	//Agregaremos la ficha que exede la pantalla (Por lo que se pierde el juego)
	//Se hará parpadear esta ficha para indicar que no entra en la pantalla
	
	mov x27,3	//Parpadeará 3 veces
	
BLINK:	mov x5,230	//Mostrar ficha
	mov x6,60
	bl ficha20
	add x6,x6,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	mov x0,2000
	bl delay
	
	mov x5,230	//Borrar ficha
	mov x6,60
	bl sweep_square_automatic
	add x6,x6,30
	bl sweep_square_automatic
	add x5,x5,30
	mov x0,1500
	bl sweep_square_automatic
	mov x0,2000
	bl delay
	sub x27,x27,1
	cbnz x27,BLINK
	
	//Deja de parpadear
	mov x5,230	//Mostrar (Otra forma podria haber sido primero borrar y luego mostrar para evitar las siguientes lineas
	mov x6,60
	bl ficha20
	add x6,x6,30
	bl ficha20
	add x5,x5,30
	bl ficha20
	mov x0,2000
	bl delay
	
	//Barre toda la pantalla 
	
	//La ficha 21, al tener el ancho de la pantalla, barre todas las fichas hasta caer
	mov x0,0
	mov x1,7
	mov x2,21
	bl general_animation	
	
	//Una vez que cayó, la borramos
	mov x5,110
	mov x6,270
	bl destroy_ficha21
	
	//Delay antes de reiniciar 
	mov x0, 8000
	bl delay
	
	bl InfLoop	//Repetir hasta el infinito
	
	
	
	//---------------------------------------------------------------

	
		
