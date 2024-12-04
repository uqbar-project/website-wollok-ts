import wollok.game.*
import _01_juego.*
import _03_frames.*
import _04_elementosEnEscenario.*
import _05_sonidos.*
import _06_animacion.*
import _07_personaje.*
import _08_armas.*

class Escenario {
	method dimensionarEscenario() {
		game.cellSize(100)
		game.height(10)
		game.width(19)
		game.boardGround("interfaces/Inicio.png")
		game.title("El Eternauta")
	}
}

class Nivel inherits Escenario {

	const property frames
	var property indiceFrame = 0
	var property sound = new MusicaJuego()
	
	method agregarVisuales() {
		game.addVisual(juan)
		game.addVisual(puntuacion)
		game.addVisual(vidaJuan)
		const botiquin = new Botiquin()
		botiquin.generarBotiquines()
	}
	
	method mostrarHistoria() {
		if (indiceFrame < frames.size()) {
			frames.get(indiceFrame).mostrar()
			indiceFrame += 1
		} else {
			game.clear()
			self.mostrarMenu()
		}
	}
	
	method mostrarMenu()
	
	method jugarNivel() {
		self.agregarVisuales()
		juan.activarFuncionalidades()
	}

	method reiniciarNivel() {
		game.clear()
		sound.reanudarMusica()
		self.resetearFuncionalidades()
		self.jugarNivel()
	}
	
	method resetearFuncionalidades() {
		juan.resetearFuncionalidades()
	}

	method pasarDeNivel() {
		sound.pararMusica()
		game.clear()
		juan.resetearFuncionalidades()
		juego.siguienteNivel()
		juego.iniciar()
	}
}

object nivel1 inherits Nivel(frames = [ historiaUno, historiaDos, historiaTres ]) {

	override method dimensionarEscenario() {
		super()
		menu.mostrar()
	}
	
	override method mostrarMenu() {
		mainMenu.mostrar()
	}

	override method jugarNivel() {
		super()
		const cascarudo = new Cascarudo()
		cascarudo.generarEnemigos()
	}

	override method agregarVisuales() {
		game.addVisual(escenario1)
		super()
	}
}

object nivel2 inherits Nivel(frames = [ historiaCuatro ]) {

	override method dimensionarEscenario() {
		super()
		game.clear()
		new ObjetivoLogrado().mostrar()
	}
	
	override method mostrarMenu() {
		menuArmas.mostrar()
	}

	override method jugarNivel() {
		super()
		const hombreRobots = new HombreRobot()
		hombreRobots.generarEnemigos()
	}

	override method agregarVisuales() {
		game.addVisual(cielo)
		game.addVisual(cerca)
		game.addVisual(calle2)
		game.addVisual(calle)
		super()
	}
}

object nivel3 inherits Nivel(frames = [ historiaCinco ]) {

	override method dimensionarEscenario() {
		super()
		game.clear()
		new ObjetivoLogrado().mostrar()
	}

	override method mostrarMenu() {
		menuArmas.mostrar()
	}
	
	override method resetearFuncionalidades() {
		vidaEscudoRayo.resetearVida()
		super()
	}

	override method jugarNivel() {
		super()
		mano.accionarArma()
	}

	override method agregarVisuales() {
		game.addVisual(casaRosada)
		game.addVisual(calle)
		game.addVisual(calle2)
		super()
		game.addVisual(vidaEscudoRayo)
		game.addVisual(mano)
		game.addVisual(rayo1)
		game.addVisual(rayo2)
	}
}