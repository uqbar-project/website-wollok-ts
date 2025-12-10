
import _04visuales.*
import _07harry.*



class Dementor {
	var property image = "dementorIzq.png"
	var property position 
	var newX = position.x() 
	var property objeto
	const property posicionInicial = position

	method reiniciar() {
		position = posicionInicial
	}

  	method buscarA(personaje) {
		const buscar = personaje.position()
		if (buscar.x() > position.x()){
			newX = position.x() + 1
			self.mirarDerecha()	
		}  else {
			newX = position.x()-1
			self.mirarIzquierda()
		}
		var newY = position.y() + if (buscar.y() > position.y()) 1 else -1
		newX = newX.max(0).min(game.width() - 1) 
		newY = newY.max(0).min(game.height() - 1)
		position = game.at(newX, newY)
		
	}

	method mirarDerecha() {
	  image="dementorDer.png"
	}

	method mirarIzquierda() {
		image= "dementorIzq.png"
	}

	method tieneInvitacionCompleta() {}
	method irAHogwarts() {}

	method perderVida() {}
	method colisionarConHarry() { harry.perderVida() }
}


class DementorFijo inherits Dementor {
    var property puntoA
    var property puntoB
    var property destinoActual = puntoB
    
    override method buscarA(personaje) {
        if (position == destinoActual) {
            destinoActual = if (destinoActual == puntoA) puntoB else puntoA
        }

        const posObjetivo = destinoActual
        var proximoX = position.x()
        var proximoY = position.y()

        if (posObjetivo.x() > proximoX) {
            proximoX = proximoX + 1
            self.mirarDerecha() 
        } else if (posObjetivo.x() < proximoX) {
            proximoX = proximoX - 1
            self.mirarIzquierda() 
        }
        
        if (posObjetivo.y() > proximoY) {
            proximoY = proximoY + 1
        } else if (posObjetivo.y() < proximoY) {
            proximoY = proximoY - 1
        }
        
        proximoX = proximoX.max(0).min(game.width() - 1) 
        proximoY = proximoY.max(0).min(game.height() - 1)
        
        position = game.at(proximoX, proximoY)
    }
	
}



/*
object dementor4 inherits DementorFijo(position = puntoA, puntoA = game.at(2,2), puntoB = game.at(8, 6)) {
	method reiniciar() {
	position = game.at(5,9)
	}   
}

object dementor1 inherits Dementor(position = game.at(5,9)) {
	method reiniciar() {
	position = game.at(5,9)
	}    
}

object dementor2 inherits Dementor(position = game.at(10,5)) {
	method reiniciar() {
	position = game.at(10,5)
	}    
}

object dementor3 inherits Dementor(position = game.at(18,5)) {
	method reiniciar() {
	position = game.at(18,5)
	}    
}
*/