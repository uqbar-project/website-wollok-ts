import pantallaInicio.*
import wollok.game.*
import fantasma.*
import personas.*
import niveles.*
import nivel1.*
import nivel2.*

//controles generales de todo el juego
object controles {
	method configurarTeclas() {
		const nivel1 = new Nivel1()
		const nivel2 = new Nivel2()

		keyboard.w().onPressDo(
			{ grimly.position(arriba.moverseAProximaPosicion(grimly.position())) 
			  grimly.image("fantasma_detras.png")
			}
		)
		keyboard.s().onPressDo(
			{ grimly.position(abajo.moverseAProximaPosicion(grimly.position()))
			  grimly.image("fantasma_frente.png")
			}
		)
		keyboard.a().onPressDo(
			{ grimly.position(izquierda.moverseAProximaPosicion(grimly.position())) 
			  grimly.image("fantasma_izquierda.png")
			}
		)
		keyboard.d().onPressDo(
			{ grimly.position(derecha.moverseAProximaPosicion(grimly.position())) 
			  grimly.image("fantasma_derecha.png")
			}
		)
		keyboard.e().onPressDo(
			{ grimly.asustar(game.getObjectsIn(grimly.position())) }
		)
		
		keyboard.num1().onPressDo({ 
			if ((estadoJuego.nivelActual() != "nivel1") && (estadoJuego.nivelActual() != "nivel2"))
					{nivel1.configurate()}
			}
		)
		keyboard.num2().onPressDo({ 
			if ((estadoJuego.nivelActual() != "nivel2") && (estadoJuego.nivelActual() != "nivel1"))
					{nivel2.configurate()} 
			}
		)
		keyboard.m().onPressDo({ pantallaInicio.configurate() })
	}
}

//celdas por donde no se puede pasar, una lista para niveles y otra para inicio
object posicionesInvalidas {
	const property niveles = [

		game.at(20, 1),
		game.at(20, 2),
		game.at(20, 3),
		game.at(20, 4),
		game.at(20, 7),
		game.at(20, 8),
		game.at(20, 9),
		game.at(20, 10),
		game.at(21, 10),
		game.at(21, 9),
		game.at(22, 9),
		game.at(23, 9),
		game.at(24, 9),
		game.at(25, 9),
		game.at(26, 9),
		game.at(27, 9),
		game.at(28, 9),
		game.at(22, 10),
		game.at(23, 10),
		game.at(24, 10),
		game.at(25, 10),
		game.at(26, 10),
		game.at(27, 10),
		game.at(28, 10),
		game.at(29, 10),


		game.at(1, 7),
		game.at(2, 7),
		game.at(5, 7),
		game.at(6, 7),
		game.at(7, 7),
		game.at(7, 8),
		game.at(7, 9),
		game.at(7, 10),
		game.at(7, 11),
		game.at(7, 12),
		game.at(7, 12),
		game.at(7, 13),

		game.at(10, 13),
		game.at(10, 12),
		game.at(10, 11),
		game.at(10, 10),
		game.at(10, 8),
		game.at(11, 8),
		game.at(12, 8),
		game.at(15, 8),
		game.at(16, 8),
		game.at(17, 8),
		game.at(10, 9),
		game.at(17, 9),
		game.at(17, 10),
		game.at(17, 11),
		game.at(17, 12),
		game.at(17, 13)
		
		
		
	]
	const property inicio = [
		game.at(0, 10),
		game.at(1, 10),
		game.at(2, 10),
		game.at(3, 10),
		game.at(4, 10),
		game.at(5, 10),
		game.at(6, 10),
		game.at(7, 10),
		game.at(8, 10),
		game.at(9, 10),
		game.at(10, 10),
		game.at(11, 10),
		game.at(12, 10),
		game.at(13, 10),
		game.at(14, 10),
		game.at(15, 10),
		game.at(16, 10),
		game.at(17, 10),
		game.at(18, 10),
		game.at(19, 10),
		game.at(20, 10),
		game.at(21, 10),
		game.at(22, 10),
		game.at(23, 10),
		game.at(24, 10),
		game.at(25, 10),
		game.at(26, 10),
		game.at(27, 10),
		game.at(28, 10),
		game.at(29, 10),
		game.at(9, 7),
		game.at(10, 7),
		game.at(11, 7),
		game.at(12, 7),
		game.at(13, 7),
		game.at(14, 7),
		game.at(15, 7),
		game.at(16, 7),
		game.at(17, 7),
		game.at(18, 7),
		game.at(19, 7),
		game.at(20, 7),
		game.at(20, 8),
		game.at(20, 9),
		game.at(20, 10),
		game.at(9, 8),
		game.at(9, 9),
		game.at(9, 10)
	]
	var listaActual = inicio
	
	method listaActual() = listaActual
	
	method cargarInicio() {
		listaActual = inicio
	}
	
	method cargarNiveles() {
		listaActual = niveles
	}
}

class Direccion {
	method siguiente(position)
	
	method esIgual(unaDireccion) = unaDireccion == self
	// próxima posición en un tablero, aplica para el fantasma y los npc 

	method moverseAProximaPosicion(posicion) {//mueve a una porxima posicion
		const siguientePosicion = self.siguiente(posicion)
		if ((!posicionesInvalidas.listaActual().contains(siguientePosicion)) && (!self.estaEnElBorde(siguientePosicion))) {
			return siguientePosicion
		} else {
			return posicion
		}
	}
	
	method estaEnElBorde(posicion) { // indica si está en alguno de todos los bordes
		const sonBordes = [self.esBordeDerecho(posicion),self.esBordeIzquierdo(posicion),self.esBordeInferior(posicion),self.esBordeSuperior(posicion)]
		return sonBordes.any({ b => b })
	}
	
	method esBordeDerecho(posicion) =  game.width() == (posicion.x()+1)
	
	method esBordeIzquierdo(posicion) = posicion.x() == (0)
	
	method esBordeInferior(posicion) = posicion.y() == (0)
	
	method esBordeSuperior(posicion) = game.height() == (posicion.y() + 2) // toma en cuenta la franja reservada para los indicadores
}

object izquierda inherits Direccion {
	override method siguiente(position) = position.left(1)
}

object derecha inherits Direccion {
	override method siguiente(position) = position.right(1)
}

object abajo inherits Direccion {
	override method siguiente(position) = position.down(1)
}

object arriba inherits Direccion {
	override method siguiente(position) = position.up(1)
}

object invalida inherits Direccion {
	override method siguiente(position) {}
	
	method posicionInvalida() = posicionesInvalidas.listaActual() // indica cuales son las posiciones inválidas
	
	method noEsPosicionInvalida(posX, posY) = (!self.posicionInvalida().contains(game.at(posX, posY))) && (!self.estaEnElBorde(game.at(posX, posY)))//indica si la posición actual no es inválida
}