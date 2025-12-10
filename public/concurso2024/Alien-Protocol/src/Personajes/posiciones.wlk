
import wollok.game.*

object posiciones {

  // Limita la posición dentro del tablero
  method limitarDentroDe(posicion) {
    var x = posicion.x()
    var y = posicion.y()

    if (x < 0) x = 0
    if (y < 0) y = 0
    if (x >= game.width()) x = game.width() - 1
    if (y >= game.height()) y = game.height() - 1

    return game.at(x, y)
  }

  method fueraDelMapa(posicion){
    return posicion.x() < 0 or
           posicion.y() < 0 or 
           posicion.x() >= game.width()
           posicion.y() >= game.height()
  }
}


// ------------- DIRECCIONES Y ORIENTACION -------------

object direccionArriba {
    method siguientePosicion(pos) = pos.up(1)
}

object direccionAbajo {
    method siguientePosicion(pos) = pos.down(1)
}

object direccionIzquierda {
    method siguientePosicion(pos) = pos.left(1)
}

object direccionDerecha {
    method siguientePosicion(pos) = pos.right(1)
}