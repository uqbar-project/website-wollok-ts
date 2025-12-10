import wollok.game.*
import personaje.*
import partida.*

class Obstaculo {
    // Por defecto se inicializa en (0,0) para evitar definir la position en la instancia del objeto transparente que tenga padre.
    var property position = game.at(0,0)
    // Por defecto se inicializa con la imagen transparente ya que tendremos muchos objetos transparentes y el que no, tendrá su propia imagen al momento de instanciarlo.
    const property image = "transparente.png"

    const movimiento = true
    
    method efectosDeColisionarContraJugador(jugador)

    method danio()

    method zonasPermitidas(nuevaPos) {
      return !zonaNoJugable.existeLaPosicion(nuevaPos) 
        && zonaSpawn.position() != nuevaPos
        && !zonaPedidos.existeLaPosicion(nuevaPos)
        && !zonaClientes.existeLaPosicion(nuevaPos)
    }

    method movimientoAleatorio() {
        if (movimiento){
            const nuevaPos = game.at(0.randomUpTo(game.width()).truncate(0),3.randomUpTo(game.height()).truncate(0))
            if (self.zonasPermitidas(nuevaPos)) {
                position = nuevaPos
            } /*else {
                self.movimientoAleatorio()
            }*/ //Comento el llamado recursivo para ver la performance
        }
    }
}

class Vehiculo inherits Obstaculo {
    const peso
    
    override method danio() = if (peso > 1700) 10 else 5

    override method efectosDeColisionarContraJugador(jugador) {
        jugador.disminuirVida(self.danio())
        game.say(self, "Correte che!")
    }

    override method movimientoAleatorio() {
        const nuevaPos = game.at(position.x()-1,position.y())
        if (!zonaNoJugable.caeEnBordeOeste(nuevaPos)) {
            const objetosEnNuevaPos = game.getObjectsIn(nuevaPos)
            const estaElJugador = objetosEnNuevaPos.contains(personaje)

            if (estaElJugador) {
                self.efectosDeColisionarContraJugador(personaje)
            }
            position = nuevaPos
        } else {
            position = game.at(position.x()+29,position.y())
        } 
    }
}

class Chorro inherits Obstaculo {
    const arma

    override method danio() = 1 + arma.danio()

    override method efectosDeColisionarContraJugador(jugador) {
        jugador.disminuirVida(self.danio())
        jugador.disminuirMonedas(500)
        jugador.pedidoRobado()
        game.say(self, "NO TE REGALES")
    }
}

class Gorrudo inherits Obstaculo {
    var choque = 0

    const mensaje = "Dame guita si queres pasar"

    override method danio() = 0

    override method efectosDeColisionarContraJugador(jugador) {
        game.say(self, mensaje)
        choque = choque + 1

        if (choque == 2) {
            personaje.disminuirMonedas(1000)
            self.movimientoAleatorio()
            choque = 0
        }
    }

}

class Transparente inherits Obstaculo { //Instanciar objetos transparentes para hacer zonas del mapa no jugables u objetos que ocupan más de una celda (Por el tamaño de su imagen)
    const obstaculoPadre
    const nombreObstaculoPadre
    
    //Dento del initialize ejecuta el método sobrescrito "position" para que lo ubique de acuerdo a su código.
    method initialize() {
        self.position(position)
    }

    override method danio() = if(obstaculoPadre) nombreObstaculoPadre.danio() else 0

    override method position(valor) {
        //En caso de que tenga obstaculo padre, toma su posición y le suma 1 a eje x(Se asume que la imagen SIEMPRE ocupa n celdas hacía la derecha)
        if (obstaculoPadre) {
            position = game.at(nombreObstaculoPadre.position().x() +1,nombreObstaculoPadre.position().y())
        //Si no, toma la position que le pasemos al momento de instanciarlo
        } else {
            position = valor
        }
    }
    
    override method efectosDeColisionarContraJugador(jugador) {
        jugador.disminuirVida(self.danio())
        game.say(self, "Correte che!")
    }

    method moverseConSuPadre() {
        if(obstaculoPadre){
            position = game.at(nombreObstaculoPadre.position().x()+1,nombreObstaculoPadre.position().y())
        }
    }

}

object faca {
    method danio() = 1
}

object pipa {
    var cargada = false

    method danio() = if (cargada) 5 else 1

    method cargar() {
        cargada = true
    }

    method descargar() {
        cargada = false
    }
}

