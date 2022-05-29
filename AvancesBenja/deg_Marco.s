
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
//---------------- CODE HERE ------------------------------------
	
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
	//fondo degradado negro a azul
	
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
	
	
	
	//-------------------
	
	b InfLoop


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

xy_pixel:    
	//x0->coordx
	//x1->coory
	//x0->return value
	mov x9,640           //x9->640
	madd x0,x1,x9,x0      //x0-> x+(640*Y)
	lsl x0,x0,2		//x0-> 4*(x+(y*640))
	add x0,x0,x20       //Add base_adress
	
	ret
	
gray: //hace gris el registro x4
	movz x4, 0x80, lsl 16
	movk x4, 0x8080, lsl 00
	
	ret
dark_gray: // hace gris osucuro x4
	movz x4, 0x40, lsl 16
	movk x4, 0x4040, lsl 0
	
	ret

//----------------------------------------------------------
	// Infinite Loop 
InfLoop: 
	b InfLoop
