import vidasYpuntos.*
import clientes.*
import mueblesMapa.*
import mozo.*
import platos.*

object gameOver {
    const property position = game.origin()
    const property image = "GameOver2.png"
}

object configuracion {
	method setGeneral() {
		game.width(30)
		game.height(15)
		game.cellSize(100)
		game.title("Wollok Diner")
	}
	
	method setVisuals() {
		game.boardGround("fondo.jpg")
		game.addVisual(puntaje)
		mesas.forEach({ mesa => game.addVisual(mesa) })
		vida.vidas().forEach({ vida => game.addVisual(vida) })
		comidas.forEach({plato => game.addVisual(plato)})

		rellenos.forEach({relleno => game.addVisual(relleno)})
		game.addVisual(mozo)
	}
	
	method setKeyboard() {
		//	TECLADO

		//movimiento mozo
		//intento de que el mozo no pase por encima de las mesas
		
		keyboard.up().onPressDo { mozo.moverse(mozo.position().up(1)) }
		keyboard.down().onPressDo { mozo.moverse(mozo.position().down(1)) }
		keyboard.left().onPressDo { mozo.moverse(mozo.position().left(1)) }
		keyboard.right().onPressDo { mozo.moverse(mozo.position().right(1)) }
		

		//Mostrar contenido de la bandeja
		keyboard.space().onPressDo({ mozo.mostrarBandeja() })
		//Agarrar platos(Mozo)
		keyboard.e().onPressDo({ mozo.agarrar()})
		//Interaccion con el cliente
		keyboard.f().onPressDo({ mozo.interactuarConCliente() })
	}

	method terminarJuego() {
    	game.removeTickEvent("spawnClientes")
		game.clear()
    	game.addVisual(gameOver)
		game.addVisual(puntaje)
	}

}