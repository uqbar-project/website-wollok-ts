import stats.*
import wollok.game.*
import juego.*
import managers.*
import tienda.*

//---------------------------------Drops---------------------------------------

class Drop {
    var property position
    var property image

    method colisionPj()
}

//---------------------------------Curas---------------------------------------
class Cura inherits Drop {
    const vidaDada

    override method colisionPj() {
        puntosDeVida.curarse(vidaDada)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Monedas---------------------------------------

class Oro inherits Drop()  {
    const valor

    override method colisionPj() {
        tienda.obtenerOro(valor)
        game.removeVisual(self)
        managerItems.quitarItem(self)
    }
}

//---------------------------------Municion---------------------------------------

class Balas inherits Drop(image = juego.jugador().visualAmmo()){

    override method colisionPj() {
        juego.jugador().arma().recargar(6)
        game.removeVisual(self)
        managerItems.quitarItem(self)
        managerItems.restarBalasDeTablero()
    }
}

