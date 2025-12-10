import wollok.game.*

object pantallas {
	const property inicio = new Fondo(position=game.at(0,0), img="pantallaInicio.png")
	const property seleccion = new Fondo(position=game.at(0,0), img="seleccionDePersonajes.png")
	const property instrucciones = new Fondo(position=game.at(0,0), img="instrucciones.png")
	const property juego = new Fondo(position=game.at(0,0), img="fondoDelJuego.png")
	const property nivel2 = new Fondo(position=game.at(0,0), img="nivel2.png")
	const property barraDeVida = new BarraDeVida(position = game.at(0,14), img = "5barradevida.png")
	const property victoria = new Fondo(position=game.at(0,0), img="findeljuego.png")
	const property creditos = new Fondo(position=game.at(0,0), img="creditos.png")
	const property gameOver = new Fondo(position=game.at(0,0), img="gameover.png")
} 

class Visual {
    var property position = game.at(0,0)
    var img = ""

    method image() = img
    
    method agregarVisual(){
    	if (!game.hasVisual(self)){
    		game.addVisual(self)
    	}
    }

	method hasVisual() { 
		return game.hasVisual(self) 
	}
    
    method removerVisual(){
    	if (game.hasVisual(self)){
    		game.removeVisual(self)
    	}
    }

	method recibirAtaque(otroHechizo) {
    // Un hechizo no hace nada cuando choca con el fondo, no choca con ningun enemigo tampoco
    // Se agrega este método vacío para evitar el error 
    // "MessageNotUnderstoodException" cuando colisiona con el fondo.
    	otroHechizo.destruir() {}
  	}
}

class Fondo inherits Visual{}

class BarraDeVida inherits Visual{
	method actualizarse(unJugador) {
		img = unJugador.vida().toString() + "barradevida.png"
		self.removerVisual()
		self.agregarVisual()
	}
}