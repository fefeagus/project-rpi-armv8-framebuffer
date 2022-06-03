
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480



//funciones


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
	

	
	
	
	
	
	
	
	
	
