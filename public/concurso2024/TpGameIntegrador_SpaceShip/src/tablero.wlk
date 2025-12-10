import wollok.game.*
import weapons.*
import juego.*
import ships.*
import sonidos.*

class Tablero {
	var position
	var image
	method position() = position
	method image() = image
		
	
}


object tableroDificultad {


	method position() = game.at(10, 1)

	method image() = "image/"+ juego.modo().toString()+ ".png"

}

