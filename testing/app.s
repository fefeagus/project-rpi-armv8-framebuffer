
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


.globl main
main:
	// X0 contiene la direccion base del framebuffer
 	mov x20, x0	// Save framebuffer base address to x20	
 	mov x21, 12345	// Save current pseudorandom (SEED)
 	movz x21,0x3D43,lsl 0
 	movk x21,0xF92B,lsl 16
	
	
	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00
	
	//DELETE	(For Demo)
	mov x19,19
	mov x22,22
	mov x23,23
	mov x24,24
	mov x25,25
	mov x26,26
	mov x27,27
	bl save_preserved_registers
	mov x19,1
	mov x20,2
	mov x21,3
	mov x22,4
	mov x23,5
	mov x24,6
	mov x25,7
	mov x26,8
	mov x27,9
	bl restore_preserved_registers
	//DELETE

	
	//	mov x2, SCREEN_HEIGH         // Y Size 
	//loop1:
	//	mov x1, SCREEN_WIDTH         // X Size
	//loop0:
	//	stur w10,[x0]	   // Set color of pixel N
	//	add x0,x0,4	   // Next pixel
	//	sub x1,x1,1	   // decrement X counter
	//	cbnz x1,loop0	   // If not end row jump
	//	sub x2,x2,1	   // Decrement Y counter
	//	cbnz x2,loop1	   // if not last row, jump
	
	
	



	//x1 -> Coordenada x (Centro)
	//x2 -> Coordenada y (Centro)
	//x3 -> Radio
	//x4 -> Color
	//mov x1,200
	//mov x2,200
	//mov x3,1000
	//mov x4,0
	//bl circle	
	
	//mov x3, 50
	//mov x4,100
	//bl circle
	
	
	//x0 -> Coordenada x
	//x1 -> Coordenada y
	//x2 -> Longitud base
	//x3 -> Padding
	//x4 -> Color
	

	
forever:
	/*
	mov x0,340
	bl random
	//mov x0,200
	mov x22,x0
	mov x1,200
	mov x2,300
	mov x3,1
	mov x4,200
	bl vertical_isosceles_triangle
	
	
	mov x0,1000
	bl delay_millis
	
	mov x0,x22
	mov x1,200
	mov x2,300
	mov x3,1
	mov x4,0
	bl vertical_isosceles_triangle
	*/
	
	//mov x26,7	//Fix void x
	//mov x27,9	//Fix void y
	mov x0,480
	bl random
	mov x1,x0
	//sdiv x1,x1,x26 
	mov x0,640
	bl random
	//sdiv x0,x0,x27
	bl xy_pixel
	mov x10,0xFFFF
	movk x10,0xFF, lsl 16
	stur w10,[x0]
	mov x0,5
	bl delay_millis
	
	b forever
	


	//Loop forever and skip functions	
	b InfLoop



//INCREMENT_c, 0x1			//Linear congruential generator
//MULTIPLIER_a, 0x15A4E35		//Linear congruential generator
//MODULUS_m, 0x100000000		//Linear congruential generator
//SEED, 1				//Linear congruential generator




//Importante - Toda función que modifique registros "preserved across a call" debería tener la forma:
/*
name:
	bl save_preserved_registers
	//DO STUFF
	bl restore_preserved_registers
	br somewhere

*/
//Save registers that are preserved across a call (x19-x27)


save_preserved_registers:
	mov x9,0x0	//Can't be imm
	stur x19,[x9]
	stur x20,[x9,8]
	stur x21,[x9,16]
	stur x22,[x9,24]
	stur x23,[x9,32]
	stur x24,[x9,40]
	stur x25,[x9,48]
	stur x26,[x9,56]
	stur x27,[x9,64]
	br lr

//Restore registers that are preserved across a call (x19-x27)
restore_preserved_registers:
	mov x9,0x0	//Can't be imm
	ldur x19,[x9]
	ldur x20,[x9,8]
	ldur x21,[x9,16]
	ldur x22,[x9,24]
	ldur x23,[x9,32]
	ldur x24,[x9,40]
	ldur x25,[x9,48]
	ldur x26,[x9,56]
	ldur x27,[x9,64]
	br lr

random: //Generates pseudorandom number between 0 and x1 and stores it in x0
	mov x9,x21		//x9  -> Xn
	movz x10,0x4E35,lsl 0	//x10 -> a
	movk x10,0x15A,lsl 16
	movz x11,0x1,lsl 32	//x11 -> m
	mov x12,0x1		//x12 -> c
	mul x9,x9,x10		//x9  -> Xn * a 
	add x9,x9,x12		//x9  -> (Xn * a) +c
	sdiv x13,x9,x11		//x13 -> ((Xn * a) + c) / m
	msub x9,x13,x11,x9	//x13 -> Xn+1
	mov x21,x9		//Save Xn+1
	sdiv x14,x9,x0		
	msub x0,x14,x0,x9	//Return number in range
				//num - (cociente*denominador) -> coc,denom,num
	br lr


	
delay_millis:
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


vertical_isosceles_triangle:
	//x0 -> Coordenada x
	//x1 -> Coordenada y
	//x2 -> Longitud base
	//x3 -> Padding
	//x4 -> Color
	
	mov x15,lr	//Return auxiliar
	
	bl xy_pixel 	//x0 -> dirección primer pixel, primer nivel
	
	
	
	mov x1,x2	//x1 -> longitud base
	sub x1,x1,1
	mov x10,4	//Can't mult by imm
	mul x1,x1,x10	
	add x1,x1,x0	//x1 -> dirección último pixel, último nivel
	mov x11,SCREEN_WIDTH
	mul x11,x11,x10 	
	
	mul x3,x3,x10 	//Considerar padding como direcciones de memoria

	loop_1_vit:	
		mov x9,x0 	//x9 -> dirección pixel nivel actual 
	loop_0_vit:
		stur w4,[x9]	//Pintar pixel
		add x9,x9,4	//Proximo pixel del nivel actual
		cmp x9,x1	
		b.LE loop_0_vit //Seguir mientras nivel no este pintado
		
		add x0,x0,x3	//Pasar al siguiente nivel
		sub x1,x1,x3	
		sub x0,x0,x11
		sub x1,x1,x11
		cmp x0,x1
		b.LE loop_1_vit //Seguir mientras todos los niveles no esten pintados
		
	
		br x15		//return
		
	

	
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



		
	
	
	
	
	



	//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
