
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
	
	//Como convencion, X0 será la direccion de retorno de las funciones
	
	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00


	mov x2, SCREEN_HEIGH         // Y Size 
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]	   // Set color of pixel N
	add x0,x0,4	   // Next pixel
	sub x1,x1,1	   // decrement X counter
	cbnz x1,loop0	   // If not end row jump
	sub x2,x2,1	   // Decrement Y counter
	cbnz x2,loop1	   // if not last row, jump


	mov x0,100
	mov x1,100
	mov x2,1
	mov x3,300
	bl square	


	//Loop forever and skip functions	
	b InfLoop

n_pixel:
	//X0 -> Numero pixel
	//X0 -> Return
	lsl x0, x0, #2   // x0 -> 4*N
	add x0, x0, x20  // x0 -> 4*N + Base_address
	br lr
	
xy_pixel:
	//X0 -> Coordenada X
	//X1 -> Coordenada Y
	//X0 -> Return value
	mov x9, SCREEN_WIDTH  	//x9 -> 640
	madd x0,x1,x9,x0  	//x0 -> X + (640 * Y)
	lsl x0, x0, #2		//x0 -> 4 * (x + (y*640))
	add x0, x0, x20		//Add base_address
	br lr
	//Version alternativa sin madd ahorra registro x9
	
	
	
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



polygon: 	//Parametros:
		X0 -> Coordenada X1
		X1 -> Coordenada Y1
		
		
	
	
	
	
	
	
	
	
	



	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
