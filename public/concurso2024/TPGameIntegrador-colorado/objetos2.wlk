import protagonista.*
import objetos1.*

/// ARMA
class Arma inherits Visual {
  override method image() = "arma.png"
  override method position()= game.at(10,2)
  override method interactuar() {
     carlitos.recogerArma()
     game.removeVisual(self)
  }
}

/// CURACIONES
class Cura inherits Visual{
  const cura = 50
  override method image() = "cura.png" 
  override method interactuar() {
    carlitos.recuperarVida(cura)
    game.removeVisual(self)
  }
}

