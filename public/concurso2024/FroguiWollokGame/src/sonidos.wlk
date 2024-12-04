import wollok.game.*
import rana.*
import objetosDeNiveles.*


object sonido{
	
	method ejecutar(nombre){
		if(!nombre.sonido().played()){
			nombre.sonido().play()
			nombre.config()
		}
	}
}

class MovimientoRana {
	const property sonido = game.sound("select-sound-121244.mp3")
	method config(){
		sonido.volume(0.5)
	}
}

class Ambiente{
	const property sonido = game.sound("game-music-loop-6-144641.mp3")
	
	method config(){
		sonido.volume(0.5)
		sonido.shouldLoop(true)
	}
}

class PerderNivel{
	const property sonido = game.sound("videogame-death-sound-43894.mp3")

	method config(){
		sonido.shouldLoop(false)
	}
}

class PerderVidas {
	const property sonido = game.sound("negative_beeps-6008.mp3")
}