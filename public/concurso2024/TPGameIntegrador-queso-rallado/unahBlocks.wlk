import wollok.game.*

//padre
class Personaje {

    var property position = game.origin() 
    var property direccion = arriba //movimiento basado en sokoban game

    method moverArriba() {
        direccion = arriba
        self.avanzar()
    }
    method moverAbajo() {
        direccion = abajo
        self.avanzar()
    }
    method moverIzquierda() {
        direccion = izquierda
        self.avanzar()
    }
    method moverDerecha() {
        direccion = derecha
        self.avanzar()
    }
    method avanzar() {
        position = direccion.siguiente(position)
    }

    method empuja(unElemento) {
		try {
			unElemento.movete(direccion)
		} catch e : wollok.lang.Exception {
			self.retrocede()
			throw e
		}
	}

    method retrocede() {
		position = direccion.opuesto().siguiente(position)
	}

    method image() {} 
}


// ------------------------ EL DINO -------------------------
object dino inherits Personaje {
    override method image() = direccion.spriteParaDino() //cambio la imagen varia segun el movimiento
}
// ----------------------- DIRECCION -----------------------------

class Direccion { 
    method siguiente(position) {}
    method opuesto() {}
}
object arriba inherits Direccion {
    override method siguiente(position) = position.up(1)
    override method opuesto() = abajo
    method spriteParaDino() = "dinoW.png" //cambio en todos segun su direccion tiene su asset
}

object abajo inherits Direccion {
    override method siguiente(position) = position.down(1)
    override method opuesto() = arriba
    method spriteParaDino() = "dinoS.png"
}

object izquierda inherits Direccion {
    override method siguiente(position) = position.left(1)
    override method opuesto() = derecha
    method spriteParaDino() = "dinoEmpujaA.png"
}

object derecha inherits Direccion {
    override method siguiente(position) = position.right(1)
    override method opuesto() = izquierda
    method spriteParaDino() = "dinoEmpujaD.png"
}