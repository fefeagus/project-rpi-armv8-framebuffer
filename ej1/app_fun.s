
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480

/*
Contiene funciones auxiliares útiles para abstraer los pixeles de la pantalla a una matriz,
setear colores y guardar registros preserved across a call en el stack.
*/



xy_pixel://Calcula la dirección del pixel (x,y)   
	//Params: 
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
	
tetris_c://Convierte entrada del tetris a coordenada en patalla
	//Params:
	//x5->columna
	//x6->fila
	mov x0,30
	mul x5,x5,x0
	add x5,x5,110
	mul x6,x6,x0
	add x6,x6,60
	ret


save_preserved_registers:
	//Push registros x19..x27 al stack
	sub  sp, sp, #0x50
	stp  x26, x27, [sp]
	stp  x24, x25, [sp, #0x10]
	stp  x22, x23, [sp, #0x20]
	stp  x20, x21, [sp, #0x30]
	stp  x19, x26, [sp, #0x40]  //Might be changed to hold lr
	br lr


restore_preserved_registers:
	//Restaura los registros x19..x27 desde el stack
	mov x0,lr
	ldp  x19, x26, [sp, #0x40]  //Might be changed to hold lr
	ldp  x20, x21, [sp, #0x30]
	ldp  x22, x23, [sp, #0x20]
	ldp  x24, x25, [sp, #0x10]
	ldp  x26, x27, [sp]
	add sp,sp,#0x50
	br x0
	
	
	
	
	
	
	
	
	
