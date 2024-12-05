import wollok.game.*
import niveles.*
import rana.*
import objetosDeNiveles.*
import sonidos.*

object comienzo{
	method config(){
		game.title("Frogui")
		game.height(20)//largo
		game.width(20)//ancho
		game.cellSize(50)
		game.addVisual(pantallaInicio)
		pantallaInicio.config()
	}
}

class Pantalla {
	var property position = game.origin()
	var fotograma = false
	const fotogramas = []

	method image() = if (fotograma) fotogramas.get(1) else fotogramas.get(0)

	method cambiarFotograma(){
		fotograma = !fotograma
	}
	
	method config() {
		game.clear()
		if(not game.hasVisual(self)){
			game.addVisual(self)
		}
		
		self.agregarFotograma()
		
		game.onTick(100, "cambiarFotograma" , {self.cambiarFotograma()})
	}
	
	method configuracionAdicional(){}
	
	method agregarFotograma(){}
}

object pantallaInicio inherits Pantalla{	
	
	override method agregarFotograma(){
		fotogramas.add("pantallaInicio.png")
		fotogramas.add("pantallaInicio2.png")
	}
	
	override method config() {
		super()
		keyboard.enter().onPressDo{ pantallaEscenarios.config() }
		keyboard.e().onPressDo{ game.stop() }
	}
}

object pantallaEscenarios inherits Pantalla {
	override method agregarFotograma(){
		fotogramas.add("pantallaEscenarios.png")
		fotogramas.add("pantallaEscenarios2.png")
	}
	
	override method config() {
		super()

		keyboard.c().onPressDo{
			nivel.configurarEscenarioCiudad()
			self.configuracionAdicional()
		}
		
		keyboard.d().onPressDo{
			nivel.configurarEscenarioDesierto()
			self.configuracionAdicional()
		}
	}
	
	override method configuracionAdicional(){
		const ambiente = new Ambiente()
		nivel.nivelActual().config()
		sonido.ejecutar(ambiente)
	}
}


object pantallaGameOver inherits Pantalla{
	override method agregarFotograma(){
		fotogramas.add("pantallaGameOver.jpg")
		fotogramas.add("pantallaGameOver2.jpg")
	}
	
	override method config(){
		super()
		
		const gameOver = new PerderNivel()
		sonido.ejecutar(gameOver)
		
		keyboard.r().onPressDo{ 
			nivel.nivelActual().configurarPuntos() 
			nivel.nivelActual().config()
		}
	}
}


object pantallaWin inherits Pantalla{
	override method agregarFotograma(){
		fotogramas.add("fondoWin.png")
		fotogramas.add("fondoWin2.png")
	}
	
	override method config(){
		super()
	
		game.schedule(300, {
			if (not game.hasVisual(puntajeFinal)){
				game.addVisual(puntajeFinal)
			}
		})

		keyboard.enter().onPressDo{ game.stop() }
	}
}

object puntajeFinal{
	const property position = game.at(16, 1)
	method text() = (nivel.puntos()).toString()
	method textColor() = "#000000"
}
