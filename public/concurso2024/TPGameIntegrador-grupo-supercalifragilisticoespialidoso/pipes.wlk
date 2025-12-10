import wollok.game.*
import menues.*

class Pipe {
    var property position = game.at(self.x(), self.y())

    method x() = 150
    method y() = -posAleatoria //genero un numero aleatorio positivo y despues agrego el "-" porque sino se rompe

    method xPOS() = position.x()

    var property posAleatoria = 10.randomUpTo(50).truncate(0) //-10: arriba de todo -50: abajo de todo


    method avanzar() {
        position = position.left(1)
    }

    method desaparecer() {game.removeVisual(self)}
    method image()
}

class PipeBottom inherits Pipe{
    override method image() = "pipe-bottom.png"
    var yaSumo = false

    method yaSumo() = yaSumo

    method sumar() {
    yaSumo = true
    }
}


class PipeTop inherits Pipe{
    const altura
    override method y() = altura + 67 + dificultad.valor() //el 67 es para que las pipes estén pegadas, depues agregamos la dificultad que sería el gapSize()
    override method image() = "pipe-top.png"
}

