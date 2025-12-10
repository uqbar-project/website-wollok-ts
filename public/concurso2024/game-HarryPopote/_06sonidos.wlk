import wollok.game.*

class Sonido {
	
	var property sound
	var property soundEstaEnPausa = false
	var property soundEstaReproduciendo = false

	method reanudar() {
		sound.resume()
		self.soundEstaEnPausa(false)
		self.soundEstaReproduciendo(true)
	}

	method pausar() {
		sound.pause()
		self.soundEstaEnPausa(true)
		self.soundEstaReproduciendo(false)
	}

	method parar() {
		if (soundEstaReproduciendo) {
			sound.stop()
			self.soundEstaReproduciendo(false)
		}
	}

	method reproducir() {
		sound.shouldLoop(true)
		game.schedule(100, { sound.play()
			self.soundEstaEnPausa(false)
			self.soundEstaReproduciendo(true)
		})
	}

}



object musicaJuego inherits Sonido (sound = game.sound("theme.mp3")) {

}

object hechizoSound inherits Sonido (sound = game.sound("magic.mp3")) {

}

object perdisteSound inherits Sonido (sound = game.sound("perdiste.mp3")) {

}