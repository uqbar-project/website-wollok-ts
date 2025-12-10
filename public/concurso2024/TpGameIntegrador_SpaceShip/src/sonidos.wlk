import wollok.game.*
import juego.*
import ships.*
import weapons.*
import vidas.*

object sonidoWin {

	method sonido() = "winning.mp3"

	method play() {
		game.sound("winning.mp3").play()
	}

}

object sonidoGameOver {

	method sonido() = "game-over.mp3"

	method play() {
		game.sound("game-over.mp3").play()
	}

}

object sonidoDisparos {

	method play() {
		game.sound("laser.mp3").play()
	}

}

object explosion {

	method play() {
		game.sound("explosion.mp3").play()
	}

}

object musicaDeFondo {

	const musicaFondo = game.sound("musicafondo.mp3")

	
	method iniciar() {
		if (musicaFondo.paused()){musicaFondo.resume()}
		else{
		musicaFondo.shouldLoop(true)
		musicaFondo.volume(0.3)
		game.schedule(500, { musicaFondo.play()})}
	}

	method sacarMusica() {
		musicaFondo.pause()
	}

	method reiniciar() {
		musicaFondo.resume()
	}

}

