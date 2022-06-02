
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480



//funciones

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

//rectangulo pantallita
sweepline:
	mov x14,lr
	mov x0, 100
	mov x1, x7
	mov x2, 30
	mov x3, 440
	bl rectangle
	
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
	
	
	
	
	
	
	
	
	
	
	
