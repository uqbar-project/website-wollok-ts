import wollok.game.*
import _07_personaje.*
import _08_armas.*
import _02_nivel.*
import _01_juego.*
import _05_sonidos.*

class Frame {
	const property image
	const property position = game.origin()
	const property sound = new MusicaMenu()
	
	method mostrar() {
		game.clear()
		game.addVisual(self.image())
		self.configurarTeclado()
	}
	
	method configurarTeclado(){}
}

class Historia inherits Frame {
	override method configurarTeclado() {
		keyboard.space().onPressDo({ juego.nivelActual().mostrarHistoria() })
	}
}
object historiaUno inherits Historia(image = new Frame(image = "interfaces/HistoriaUno.png")) {}
object historiaDos inherits Historia(image = new Frame(image = "interfaces/HistoriaDos.png")) {}
object historiaTres inherits Historia(image = new Frame(image = "interfaces/HistoriaTres.png")) {}
object historiaCuatro inherits Historia(image = new Frame(image = "interfaces/HistoriaCuatro.png")) {}
object historiaCinco inherits Historia(image = new Frame(image = "interfaces/HistoriaCinco.png")) {}

object historiaSeis inherits Frame(image = new Frame(image = "interfaces/HistoriaSeis.png")) {
	override method configurarTeclado() {
		keyboard.space().onPressDo({ game.clear()
			gameOver.mostrar()
		})
	}
}

object tutorial inherits Frame(image = new Frame(image = "interfaces/Tutorial.png")) {

	override method configurarTeclado() {
		keyboard.x().onPressDo({ game.clear()
			mainMenu.mostrar()
		})
	}
}

object creditosUno inherits Frame(image = new Frame(image = "interfaces/creditosUno.png")) {

	override method configurarTeclado() {
		keyboard.space().onPressDo({ game.clear()
			creditosDos.mostrar()
		})
	}
}

object creditosDos inherits Frame(image = new Frame(image = "interfaces/creditosDos.png")) {

	override method configurarTeclado() {
		keyboard.x().onPressDo({ game.clear()
			mainMenu.mostrar()
		})
	}
}


object menu inherits Frame (image = new Frame(image = "interfaces/Inicio.png")) {
	override method mostrar() {
		super()
		sound.reproducirMusica()
	}

	override method configurarTeclado() {
		keyboard.enter().onPressDo({ game.clear()
			juego.nivelActual().mostrarHistoria()
		})
	}
}

object mainMenu inherits Frame (image = new Frame(image = "interfaces/MainMenu.png")) {

	override method configurarTeclado() {
		keyboard.num1().onPressDo({ menu.sound().pararMusica()
			game.clear()
			juego.nivelActual().sound().reproducirMusica()
			juego.nivelActual().jugarNivel()
		})
		keyboard.num2().onPressDo({ game.clear()
			tutorial.mostrar()
		})
		keyboard.num3().onPressDo({ game.clear()
			creditosUno.mostrar()
		})
	}

}



class ObjetivoLogrado inherits Frame(image = new Frame(image = "interfaces/ObjetivoLogrado.png")) {
	override method mostrar() {
		super()
		self.sound().reproducirMusica()
	}
	
	override method configurarTeclado() {
		keyboard.enter().onPressDo({ game.clear() self.sound().pararMusica()
			juego.nivelActual().mostrarHistoria()
		})
	}
}


object menuArmas inherits Frame(image = new Frame(image = "interfaces/SelectArma.png")){
	
	override method configurarTeclado() {
		keyboard.num1().onPressDo({
			game.clear()
			juan.arma(revolver)
			juego.nivelActual().sound().reproducirMusica()
			juego.nivelActual().jugarNivel()
		})
		keyboard.num2().onPressDo({
			game.clear()
			juan.arma(fusil)
			juego.nivelActual().sound().reproducirMusica()
			juego.nivelActual().jugarNivel()
		})
		keyboard.num3().onPressDo({
			game.clear()
			juan.arma(rifle)
			juego.nivelActual().sound().reproducirMusica()
			juego.nivelActual().jugarNivel()
		})
	}
}

object gameOver inherits Frame(image = new Frame(image = "interfaces/GameOver.png")) {

	override method mostrar() {
		super()
		game.schedule(6000, { game.stop()})
	}
	override method configurarTeclado() {}
}

class Reinicio inherits Frame(image = new Frame(image = "interfaces/ReiniciarPartida.png")) {

	override method mostrar() {
		juego.nivelActual().sound().pausarMusica()
		game.clear()
		game.addVisual(self.image())
		self.configurarTeclado()
		sound.reproducirMusica()
	}

	override method configurarTeclado() {
		keyboard.num1().onPressDo({ sound.pausarMusica()
			juego.nivelActual().reiniciarNivel()
		})
		keyboard.num2().onPressDo({ game.schedule(200, { game.stop()})})
	}
}