import cursor.*
import otros.*

class Tarjeta {
	const position
	var image = self.dorso()
	var frente = ""

	method image() = image
    method frente() = frente
	method position() = position

	method dorso() = "dorso" + config.tablero() + ".jpg"

    method estaDescubierta() = image != self.dorso()

	method frente(imagenFrente) {
		frente = imagenFrente
	}

	method descubrir() {
		if (not self.estaDescubierta()) image = frente
	}

	method ocultar() {
		game.schedule(1000	, {image = self.dorso()})
	}
}