import wollok.game.*
import _07_personaje.*
import _02_nivel.*
import _01_juego.*
import _08_armas.*

class Botiquin inherits Objeto(position = game.at((0..13).anyOne(), [1, 3].anyOne()), image = "Botiquin_112x50.png") {
	
	const property id = self.identity().toString()
	
	method generarBotiquines() {
		game.onTick(10000, "generar_botiquin", { const nuevoBotiquin = new Botiquin()
			nuevoBotiquin.crear()
		})
	}
	
	method crear() {
		position = self.position()
		game.addVisual(self)
	}
	
	override method serImpactado(objeto) {
		objeto.usar()
	}
	
	override method desactivarFuncionalidades() {
		game.removeVisual(self)
	}
}

object vidaJuan {

	var vida = 100
	const property position = game.at(1, game.height() - 1)
	var property image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
	
	method vida() = vida

	method text() = vida.toString()

	method restarVida(enemigo) {
		vida = 0.max(vida - enemigo.danio())
		image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
		game.removeVisual(self)
		game.addVisual(self)
		if (vida == 0) {
			juan.morir()
		}
	}

	method resetearVida() {
		vida = 100
		image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
	}
	
	method sumarVida() {
		vida = 100.min(vida + 25)
		image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
		game.removeVisual(self)
		game.addVisual(self)
	}

}

object vidaEscudoRayo {
	var property danioRecibido
	var danioAcumulado = 0
	var property vida = 1000
	var property vidaBarraSalud = vida * 0.10
	const property position = game.at(game.width() - 5, game.height() - 1)
	var property image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"

	method text() = self.vidaBarraSalud().toString()
	
	method danioRecibido(objeto) {
		danioRecibido = objeto.danio()
		danioAcumulado += danioRecibido
		self.restarVida()
	}
	
	method restarVida() {
		if (danioAcumulado >= 100) {
			danioAcumulado = 0
			vida = 0.max(vida - 100)
			vidaBarraSalud = vida * 0.10
            self.actualizarImagen()
            self.generarExplosion()
		}
	}

    method actualizarImagen() {
        image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
        game.removeVisual(self)
        game.addVisual(self)
    }
    
	method generarExplosion() {
		if (vida == 0) {
			juan.desactivarFuncionalidades()
			mano.desactivarFuncionalidades()
			game.schedule(3000, { mano.morir() rayo1.explotar() rayo2.explotar()})
			game.schedule(4000, { juego.nivelActual().pasarDeNivel()})
		}
	}
	
	method resetearVida() {
		vida = 1000
		image = "barraDeSalud/(" + self.text() + "_)Barra_Vida-210x98.png"
	}
}

object puntuacion {

	var puntos = 0
	const property color = "#ff00ff"
	const property position = game.at(game.width() - 2, game.height() - 1)
	
	method puntos() = puntos
	
	method text() = puntos.toString()

	method textColor() = self.color()

	method sumarPuntos(enemigo) {
		puntos = 1000.min(puntos + enemigo.puntosOtorgadosPorMuerte())
		if (puntos >= 1000) {
			game.schedule(200, { juego.nivelActual().pasarDeNivel()})
		}
	}

	method resetearPuntuacion() {
		puntos = 0
	}

}

class FondoDeEscenario inherits Objeto {}

object escenario1 inherits FondoDeEscenario(image = "escenarios/Nivel_1-2000x1000.png", position = game.origin()) {}
object casaRosada inherits FondoDeEscenario(image = "escenarios/casaRosada.png", position = game.at(0, 1)) {}
object cielo inherits FondoDeEscenario(image = "escenarios/Cielo_Nocturno-2400x600.png", position = game.at(0, 4)) {}
object cerca inherits FondoDeEscenario(image = "escenarios/Cerca-3600x150.png", position = game.at(0, 4)) {}
object calle inherits FondoDeEscenario(image = "escenarios/Calle-3600x300.png", position = game.at(0, 1)) {}
object calle2 inherits FondoDeEscenario(image = "escenarios/Calle-3600x300-girada.png", position = game.at(-1, 0)) {}