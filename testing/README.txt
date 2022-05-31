shapes_y_auxs tiene las funciones:
	*n_pixel: Auxiliar para obtener la dirección del n-ésimo pixel
	*xy_pixel: Auxiliar para obtener direrección del pixel (x,y)
	*square: Dibuja un cuadrado a partir de su esquina superior derecha y longitud del lado.
		 Disclaimer: Si dibujan un cuadrado que se sale de la pantalla, se va todo a la mierda xd
		 
Pueden reemplazar app.s por shapes_y_auxs.s para testear


Yet to implement:
	*Dibujar un círculo (En un rato lo hago)
	*Dibujar rectangulo
	*Funcion delay
	
Yet to draw: 
	*Maquina de juegos (Solo el marco)


Todavía hay que pensar como:
	*Mover figuras
	*Hacer delay (Sin esto no podemos animar nada)


Ideas:
	*Mover figuras:
		* Se puede pintar todo el fondo de vuelta entre cada fotograma, y despues volver a pintar cada una de las figuras
		en su nueva posición (según su prioridad). La posición tendría que ser una función de una variable tiempo del programa.
		El tema con esto es que me parece horrible
		
		*Se puede guardar cada figura (incluido el fondo) en memoria antes de dibujarla. Deben estar guardadas en "orden de  
		prioridad".
		Mientras más al fondo, mayor prioridad.
		Cada vez que haya que mover una figura hacemos:
			a) En los pixeles de la figura a modificar, pintar los pixeles de las demas figuras en orden de prioridad.
			b) Dibujar la nueva figura			
		
		
	*Hacer delay:
		Una función que toma como algumento la cantidad n de veces que demora una unidad de tiempo. Ej delaymilisegundos.
		La función tiene dos ciclos anidados. El interno demora siempre la unidad de tiempo y el externo lo ejecuta n veces.
		Desventaja: Depende de los hz del procesador, pero creo que no hay solución muy fácil para esto.
		
Falta pensar:
	*Que vamos a animar en la máquina. Ideas hasta ahora:
		*Tetris
		

