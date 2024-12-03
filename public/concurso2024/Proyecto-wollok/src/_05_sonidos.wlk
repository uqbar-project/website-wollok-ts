import wollok.game.*

class Sonido {

	var property sound
	var property soundEstaEnPausa = false
	var property soundEstaReproduciendo = false

	method reanudarMusica() {
		sound.resume()
		self.soundEstaEnPausa(false)
		self.soundEstaReproduciendo(true)
	}

	method pausarMusica() {
		sound.pause()
		self.soundEstaEnPausa(true)
		self.soundEstaReproduciendo(false)
	}

	method pararMusica() {
		if (soundEstaReproduciendo) {
			sound.stop()
			self.soundEstaReproduciendo(false)
		}
	}

	method reproducirMusica() {
		sound.shouldLoop(true)
		game.schedule(500, { sound.play()
			self.soundEstaEnPausa(false)
			self.soundEstaReproduciendo(true)
		})
	}

}

class MusicaMenu inherits Sonido (sound = game.sound("sonidos/eternauta1.mp3")) {

}

class MusicaJuego inherits Sonido (sound = game.sound("sonidos/eternauta2.mp3")) {

}