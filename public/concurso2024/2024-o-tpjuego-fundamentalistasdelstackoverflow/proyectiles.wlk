import morcilla.*
import general.*

class Direccion {
    const x
    const y
    const limiteIzq
    const limiteDer

    method x() = x
    method y() = y
    method limiteIzq() = limiteIzq
    method limiteDer() = limiteDer
}

const dirIzquierda = new Direccion(x = -1, y = 0, limiteIzq = 0, limiteDer = 99)
const dirDerecha = new Direccion(x = 1, y = 0, limiteIzq = -1, limiteDer = 32)
const dirDiagonalIzquierda = new Direccion(x = -1, y = -1, limiteIzq = 0, limiteDer = 99)
const dirDiagonalDerecha = new Direccion(x = 1, y = -1, limiteIzq = -1, limiteDer = 32)

class Proyectil {
    var property position = new PositionMejorada(x = posicionInicial.x(), y = posicionInicial.y())
    const posicionInicial
    const id
    const velocidad
    const delay
    const sentido

    method image() = "miniMiniHueso.png"

    method delay() = delay + 1000

    method duracion() = self.delay() + velocidad * 34

    method direccion() {
        position = new PositionMejorada(x = posicionInicial.x(), y = posicionInicial.y())
        game.addVisual(self)
        game.onTick(velocidad, "proyectil" + id, {self.movimiento()})
    }

    method movimiento() {
        position.horizontalMejorado(sentido.x(), sentido.limiteIzq(), sentido.limiteDer())
        position.verticalMejorado(sentido.y(), 99, -4)
        if(position.x() == sentido.limiteIzq() || position.x() == sentido.limiteDer())
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectil" + id)
        }
    }

    method tocaMorcilla() {
        morcilla.perderVida()
    }
}