import wollok.game.*
import rey.*
import enemigos.*
import aliados.*
import UI.*
import sound.*
import mecanicas.*
import oleadas.*
import leaderboard.*
import escenas.cambioDeEscena.*
import proyectiles.*
import namePrompt.*
import images.*
import trucos.*

object ajedrez inherits Escena {
	var tutorialActivo = false

	override method mostrar() {
		game.addVisual(reyBlanco)
		visuales.add(reyBlanco)
		game.boardGround("Tablero.png")
		
		oleada.crearOleada(5)
		game.showAttributes(reyBlanco)
		
		//UI
		game.addVisual(score)
		visuales.add(score)
		game.addVisual(recurso)
		visuales.add(recurso)
		game.addVisual(vida)
		visuales.add(vida)
		game.addVisual(piezasRestantes)
		visuales.add(piezasRestantes)
		game.addVisual(oleadaActual)
		visuales.add(oleadaActual)

		self.abrirTutorial()
		
		// Controles
		game.addVisual(controles)
		visuales.add(controles)
		controles.init()

		keyboard.l().onPressDo({ leaderboard.toggle() })

		keyboard.plusKey().onPressDo({sonidos.subirVolumen()})
		keyboard.minusKey().onPressDo({sonidos.bajarVolumen()})
		keyboard.m().onPressDo({ sonidos.toggle() })
		
		//Reiniciar juego
		keyboard.alt().onPressDo({ mecanicasJuego.reiniciarJuego() })
		// Empieza solo a los 2 segundos
		keyboard.space().onPressDo({ if (tutorialActivo) self.cerrarTutorial() })
	}
	
	override method ocultar() {
		mecanicasJuego.detenerVerificaciones()
		
		oleada.detenerOleada()
		oleada.reiniciar()
		
		super()
	}

	method abrirTutorial() {
		game.addVisual(tutorial)
		tutorialActivo = true
	}

	method cerrarTutorial() {
		game.removeVisual(tutorial)
		tutorialActivo = false
		game.schedule(
			1000,
			{ 
				sonidos.playFondo()
				oleada.crearOleada(5)
				oleada.iniciarOleada()
				mecanicasJuego.iniciarVerificaciones()
			}
		)
	}

	method juegoActivo() = !tutorialActivo && !namePrompt.awaiting()
}

object controles {
	var property position = game.center()
	method init() {
		keyboard.right().onPressDo({if (ajedrez.juegoActivo()) reyBlanco.mover(reyBlanco.position().x() + 1, reyBlanco.position().y()) })
		keyboard.left().onPressDo({if (ajedrez.juegoActivo()) reyBlanco.mover(reyBlanco.position().x() - 1, reyBlanco.position().y()) })
		keyboard.up().onPressDo({if (ajedrez.juegoActivo() && trucos.idclip()) reyBlanco.mover(reyBlanco.position().x(), reyBlanco.position().y() + 1) })
		keyboard.down().onPressDo({if (ajedrez.juegoActivo() && trucos.idclip()) reyBlanco.mover(reyBlanco.position().x(), reyBlanco.position().y() - 1) })

		keyboard.num(1).onPressDo(
			{ if (ajedrez.juegoActivo()) reyBlanco.intentarColocarPieza(new PeonBlanco()) }
		)
		keyboard.num(2).onPressDo(
			{ if (ajedrez.juegoActivo()) reyBlanco.intentarColocarPieza(new CaballoBlanco()) }
		)

		keyboard.num(3).onPressDo(
			{ if (ajedrez.juegoActivo()) reyBlanco.disparar(new AlfilBlanco()) }
		)

		keyboard.num(4).onPressDo(
			{ if (ajedrez.juegoActivo())reyBlanco.disparar(new TorreBlanca()) }
		)
	}
}