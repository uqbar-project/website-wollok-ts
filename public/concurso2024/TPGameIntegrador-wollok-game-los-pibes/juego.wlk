import imagenYSonido.*
import wollok.game.*
import Boxeadores.*
import pantallas.*

object juego{
	method iniciar(){
		game.title("Punch Out")
        game.cellSize(16)

		game.height(15)
		game.width(16)

        game.addVisual(gestorImagenes)
        gestorPantallas.mostrarPantalla(pantallaCarga)
	}
}

object gestorPantallas {
    var property pantallaActual = null
    var property transicionEnProgreso = false

    method mostrarPantalla(pantalla) {
        pantallaActual = pantalla
        pantalla.mostrar()
        self.transicionEnProgreso(false)
    }
}