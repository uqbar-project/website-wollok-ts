import wollok.game.*
import rana.*
import inicio.*
import niveles.*

class Objetos {
	var property position = game.origin()
	method image() = "invisibe.png"
	
	method derecha(){
		position = position.right(1) //asi se modifica siempre las posiciones
 		if (self.position().x() > 20) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(21)
		}
	}
	
	method izquierda(){
		position = position.left(1) //asi se modifica siempre las posiciones
 		if (self.position().x() < -1) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(21)
		}
	}
	
	method desplazarse(){}
	
	method colisionarConRana(){}
}

class AutoDerecha inherits Objetos {
  	override method image() = "autoblanco.png"
  	override method colisionarConRana(){ rana.perderVida() }
	override method desplazarse(){
		self.derecha()
	}		
}

class AutoIzquierda inherits Objetos{
  	override method image() = "autoverde.png"
  	override method colisionarConRana(){ rana.perderVida() }
	override method desplazarse(){
		self.izquierda()
	}		
}

object fondos inherits Objetos(position = game.origin()){
	var property fondos = ["fondoCiudad.png", "fondoCiudad2.png", "fondoDesierto.png", "fondoDesierto2.png"]
	var property image = ""
	
	override method image() = image
	
	method setImage(){
		image = fondos.get(nivel.nivelActual().fondo())
	}
}


class Llegada inherits Objetos{
	
	override method colisionarConRana(){
		nivel.nivelActual().aumentarMetasAlcanzadas()
		game.addVisual(new RanaMeta(position = rana.position()))
		rana.reset()
		if (nivel.nivelActual().metasAlcanzadas() == nivel.nivelActual().totalMetas()) {
                    nivel.aumentarNivel()
                }
	}
    
    override method image() = "bandera.png"
}

class RanaMeta inherits Objetos{
    // Representa una rana que se queda en la meta alcanzada
    override method image() = "ranaD.png"
    override method colisionarConRana(){ rana.perderVida() }
}


class Nenufar inherits Objetos{
	var property visible = true

    override method image() = if (visible) "nenufar.png" else "invisible.png"
	
   	method reaparecerEnFilaEspecifica(fila){ 
   		position = game.at(1.randomUpTo(game.width()-1).truncate(0), fila)
   	}
   	
   	method alternarVisibilidad() {
        visible = !visible
    }
}

class TroncoDerecha inherits Objetos{
	const property visible = true
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.derecha()
	}	
}

class TroncoDerecha2 inherits TroncoDerecha{
	override method image() = "tronco2.png"
}


class TroncoIzquierda inherits Objetos{
	const property visible = true
	override method image() = "tronco1.png"
	override method desplazarse(){
		self.izquierda()
	}
}

class TroncoIzquierda2 inherits TroncoIzquierda{
	override method image() = "tronco2.png"
}


object estrella inherits Objetos{
	override method image() = "estrella.png"
	
  	method reaparecerAlAzar() {
        const x = 1.randomUpTo(game.width()-1).truncate(0)
        const y = 1.randomUpTo(game.height()-1).truncate(0)
        position = game.at(x,y)
    }
    
    method agregarEstrella(){
		self.reaparecerAlAzar()
		game.addVisual(self)
	}
	
    override method colisionarConRana(){ 
    	nivel.sumarPunto(500) 
    	game.removeVisual(self) 
    	self.agregarEstrella()
    }
}

object contadorPuntos {
	const property position = game.at(2,17)
	method text() = "Puntos acumulados: " + (nivel.puntos()).toString()
	method textColor() = "#FEFFFE"
}


// bloqueadores
class Valla inherits Objetos {
	override method image() = "valla.png"
}

class CartelStop inherits Objetos {
	override method image() = "cartelStop.png"
}

// configuracion de las vidas de la rana
class Vidas {
    var property position = game.at(19,19)
    const visuals = ["", "1vidas.png", "2vidas.png", "3vidas.png"]
    var property image = visuals.get(rana.vidasRestantes())
    
    method cambiarVisual(){
        image = visuals.get(rana.vidasRestantes())
    }
    
    method initialize(){
    	image = visuals.get(3)
    }
}

// objetos nivel desierto
class Tren inherits Objetos{
	override method colisionarConRana(){ rana.perderVida() }
	override method derecha(){
		position = position.right(2.5) //asi se modifica siempre las posicones

		if (self.position().x() > 21) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.left(22)
		}
	}
}

class Locomotora inherits Tren{
	override method image() = "tren.png"
	override method desplazarse(){
		self.derecha()
	}
}

class Vagon inherits Tren{
	override method image() = "vagon.png"
	override method desplazarse(){
		self.derecha()
	}
}


class PlantaRodadora inherits Objetos{
    var fotograma = 0
    
    const visuals = ["rodadora1.png", "rodadora2.png", "rodadora3.png", "rodadora4.png", 
                     "rodadora5.png", "rodadora6.png", "rodadora7.png", "rodadora8.png"]
    
    var property image = visuals.get(0)
    
    override method image() = image
    
    override method colisionarConRana(){ rana.perderVida() }
    
    method cambiarVisual() {
        image = visuals.get(self.fotogramaActual())
    }
    
    method cambiarFotograma() {
        fotograma += 1
        if (fotograma > 7) {
            fotograma = 0
        }
        self.cambiarVisual()
    }
    
    method fotogramaActual() = fotograma
    
    override method desplazarse() {
        self.cambiarFotograma()
        position = position.left(2) //asi se modifica siempre las posiciones
 		if (self.position().x() < -1) { // me devuelve la posicion de x o y self.position().x/y()
			position = position.right(21)
		}
    }
}


class Cactus inherits Objetos{
	override method image() = "cactus2.png"
	override method colisionarConRana(){ rana.perderVida() }
}