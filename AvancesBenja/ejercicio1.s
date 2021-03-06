
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
					
		// el loop 0 hace 1 linea o rectangulo de 40 de largo por 640 de ancho

	setcolor:
		add x3,x3,1
		add x10,x10,0x1000 // voy sumando bits del color q quiero al anterior color y me voy acercando
		cmp x3,16 // si x3 es 16 significa que ya dibuje las 16 lineas y debo parar( la primera la dibujo cuando x3 es 0) 
		b.ne newline

	
//------------------------ dibujo del marco(claro) -------------------------------
	
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
	
	
	
	//--------------- bordes oscuros ------------------ 
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
	
	//----------------------- botones --------------------
	
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
	movk x4 ,0x1818, lsl 0
	mov x6 ,x1
	bl circle
	
	mov x5, 190
	mov x6, 240
	bl ficha3           //<- cuadradito blanco
	


	b InfLoop
//----------------------------------------------------------------------------


//-------------------------------- funciones -------------------------------------------

square: //Assume: lado > 0
	//Parametros
	//X0 -> Coordenada X
	//X1 -> Coordenada Y
	//X2 -> Lado
	//X3 -> Color
	
	mov x15, lr  		//Return auxiliar
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

	// r?? >= (xc-x)?? + (yc-y)??

	mul x3,x3,x3   // r??
	
	mov x9, SCREEN_HEIGH         // Y Size 
	loop1_circle:
		mov x10, SCREEN_WIDTH         // X Size
	loop0_circle:
		sub x11,x1,x10  	//x11 = xc-x
		mul x11,x11,x11		//x11 = (xc-x)??
		sub x12,x2,x9   	//x12  = yc-y
		mul x12,x12,x12		//x12 = (yc-y)??
		add x11,x11,x12 	//x11 = (xc-x)?? + (yc-y)??
		cmp x3, x11		//Paint only if r?? >= (xc-x)?? + (yc-y)??
		b.LT else_circle
		stur w4,[x0]	   // Set color of pixel N
	else_circle:
		sub x0,x0,4	   	// Previus pixel
		sub x10,x10,1	   	// decrement X counter
		cbnz x10,loop0_circle	   // If not end row jump
		sub x9,x9,1	   	// Decrement Y counter
		cbnz x9,loop1_circle	   // if not last row, jump
	br lr

//rectangulo pantallita
sweepline: // parametros: x7->cord y desde donde empiezo
	mov x14,lr
	mov x0, 110
	mov x1, x7
	mov x2, 30
	mov x3, 420
	bl rectangle
	
	add x4,x4,0x1000   //<- cambio el color de x4 para el prox llamado para imitar el degradado del fondo
	add x7,x7,30      //<- bajo la linea 1 bloque para el prox llamado
	
	br x14


delay:
	//x0 ->	millis to delay
	delay_loop0:
		sub x0,x0,1
		movz x1,0xbffe, lsl 0
		
		
	delay_loop1:
		sub x1,x1,1
		ldur x2,[x20]
		ldur x2,[x20]
		ldur x2,[x20]
		cbnz x1, delay_loop1
		cbnz x0, delay_loop0
	br lr

ficha1: //parametros: x5->coord x de donde sale la ficha
	sub sp,sp,8
	STUR x30, [SP, 0]

	mov x0,600
	mov x0, x5
	mov x1,x6
	mov x2 , 30
	movz x3, 0x00, lsl 16
	movk x3, 0x0000, lsl 0 
	bl square

	mov x0,600
	mov x0, x5
	add x0,x0,4
	mov x1,x6
	add x1,x1,4
	mov x2 , 22
	movz x3, 0xAE, lsl 16
	movk x3, 0xAEAE, lsl 0
	bl square

	mov x0,600
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

ficha3:// cuadrado de cuatro bloques 
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


//----------------------------------------------------------
// Infinite Loop 
InfLoop: 
	b InfLoop
