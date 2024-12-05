import tablero.*
import config.*

object oro {
  const property position = game.at(1,10)
  method text() = "Oro disponible: " + tablero.oroActual()
  method textColor() = paleta.rojo()
  method mostrarOro() {
    game.addVisual(self)
  }
  method borrarOro() {
    game.removeVisual(self)
  }
}
