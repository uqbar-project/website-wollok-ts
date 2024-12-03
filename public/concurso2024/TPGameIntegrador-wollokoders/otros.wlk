object fondoTablero {
	method position() = game.origin()

	method image() = "vacio5.jpg"
}

object tutorial {
    method position() = game.origin()

    method image() = "tutorialycontroles.jpg"
}


object ganaste {
    method position() = game.origin()

    method image() = "win4.jpg"
}

object tiempoTerminado {
    method position() = game.origin()

    method image() = "tiempoTerminadob.jpg"
}

object config {
    var tablero = 1 //1 o 2
    var seleccion = 3 //3 o 4
    var image = "config13g.png"

    method tablero() = tablero
    method seleccion() = seleccion
    method image() = image
    method position() = game.at((1920 - 914) / 2, 300)

    method initialize() {
		keyboard.num1().onPressDo({
            tablero = 1
            self.cambiarImagen()
		})
        keyboard.num2().onPressDo({
            tablero = 2
            self.cambiarImagen()
		})
        keyboard.num3().onPressDo({
            seleccion = 3
            self.cambiarImagen()
		})
        keyboard.num4().onPressDo({
            seleccion = 4
            self.cambiarImagen()
		})
    }

    method cambiarImagen() {
        image = "config" + tablero.toString() + seleccion.toString() + "g.png"
    }
}

object instrucciones {
    var visibilidad = true

    method image() = "instrucciones.png"
    
    method position() = game.at(0, 50)
    
    method iniciarTitileo() {
        game.onTick(800, "titileo", {
            visibilidad = not visibilidad
            if (visibilidad) {
                game.addVisual(self)  
            } else {
                game.removeVisual(self)  
            }
        })
    }

    method detenerTitileo() {
        game.removeTickEvent("titileo")
        game.removeVisual(self)  
    }
}

object textoPuntos {
    var property position = game.at(184, 128)
    
    method image() = "Puntos3R.png"
}

object textoBonus {
    method position() = game.at(1200, 108)

    method image() = "Bonus2R.png"
}

object textoTiempo {
    method position() = game.at(500, 108)
    method image() = "Tiempo3R.png"
}