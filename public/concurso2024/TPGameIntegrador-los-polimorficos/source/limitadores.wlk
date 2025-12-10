import cachito.*
import escenario.*
import objetos.*

class Limitador inherits ObjetoInteractivoFijo {

  override method interaccion() {
    self.empuja(cachito)
  }

  method empuja(cachito) {}
}

class LimitadorArriba inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().down(1))
	}
}

class LimitadorAbajo inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().up(1))
	}
}

class LimitadorIzquierda inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().right(1))
	}
}

class LimitadorDerecha inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().left(1))
	}
}

object limitadores {
    const coordenadasLimitadoresArribaCasa =      [[0, 10], [1, 10], [2, 10], [3, 10], [7, 10], [8, 10], 
                                                   [9, 10], [10, 10], [4, 9], [5, 9], [6, 9], [7, 4]]

    const coordenadasLimitadoresIzquierdaCasa =   [[9, 3], [9, 4], [9, 5], [9, 6], [9, 7], [9, 8], [9, 9]]

    const coordenadasLimitadoresDerechaCasa =     [[8, 3], [8, 4], [8, 5], [8, 6], [8, 7], [8, 8], [8, 9]]

    const coordenadasLimitadoresArribaPueblo =    [[2, 6], [3, 6], [4, 6], [7, 6], [1, 9], [7, 9]]

    const coordenadasLimitadoresAbajoPueblo =     [[1, 4], [2, 4], [3, 4], [4, 4], [7, 4], [8, 4], [9, 4], [5, 7], [7, 7]]

    const coordenadasLimitadoresIzquierdaPueblo = [[8, 6], [8, 7], [8, 9], [8, 10], [8, 11], [8, 12],
                                                   [4, 0], [4, 1], [4, 2], [4, 3], [4, 4], [4, 8], 
                                                   [4, 9], [4, 10], [4, 11], [4, 12], [0, 5], [0, 6], [0, 7]]

    const coordenadasLimitadoresDerechaPueblo =   [[10, 5], [10, 6], [10, 7], [10, 9], [10, 10], [10, 11],
                                                   [10, 12], [6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 9],
                                                   [6, 10], [6, 11], [6, 12], [2, 7], [2, 8], [7, 6]]   
    method agregarLimitadoresEnCasa() {
        coordenadasLimitadoresArribaCasa.forEach({c => game.addVisual(new LimitadorArriba(position = game.at(c.first(), c.last())))})
        coordenadasLimitadoresIzquierdaCasa.forEach({c => game.addVisual(new LimitadorIzquierda(position = game.at(c.first(), c.last())))})
        coordenadasLimitadoresDerechaCasa.forEach({c => game.addVisual(new LimitadorDerecha(position = game.at(c.first(), c.last())))})
    }

    method agregarLimitadoresEnPueblo() {
        coordenadasLimitadoresArribaPueblo.forEach({c => game.addVisual(new LimitadorArriba(position = game.at(c.first(), c.last())))})
        coordenadasLimitadoresAbajoPueblo.forEach({c => game.addVisual(new LimitadorAbajo(position = game.at(c.first(), c.last())))})
        coordenadasLimitadoresIzquierdaPueblo.forEach({c => game.addVisual(new LimitadorIzquierda(position = game.at(c.first(), c.last())))})
        coordenadasLimitadoresDerechaPueblo.forEach({c => game.addVisual(new LimitadorDerecha(position = game.at(c.first(), c.last())))})
    }
}