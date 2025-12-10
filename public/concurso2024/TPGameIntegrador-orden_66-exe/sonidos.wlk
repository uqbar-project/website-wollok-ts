import wollok.game.*

object sonido {
	method ejecutar(nombre) {
		if (!nombre.sonido().played()) {
			nombre.sonido().play()
			nombre.config()
		}
	}
	
	method detener(nombre) {
		nombre.sonido().stop()
	}
	
	method enEjecucion(nombre) = nombre.sonido().played()
}

class InputSound {
	const property sonido = game.sound("lightSaber.mp3")
	
	method config() {
		sonido.volume(0.3)
		sonido.shouldLoop(false)
	}
}

class GameMusic {
	const property sonido = game.sound("mainMusic.mp3")
	
	method config() {
		sonido.volume(0.2)
		sonido.shouldLoop(true)
	}
}

class MenuMusic {
	const property sonido = game.sound("menuMusic.mp3")
	
	method config() {
		sonido.volume(0.2)
		sonido.shouldLoop(true)
	}
}
