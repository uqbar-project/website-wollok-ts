import wollok.game.*
import rey.*
import aliados.*
import enemigos.*
import oleadas.*
import trucos.*

class Interfaz {
  const property position
  var property valor

  method text() {
    return " " + self.valorAMostrar()
  }

  method valorAMostrar() {
    return valor
  }

  method textColor() = "000000"

  method reiniciar() {
    valor = 0
  }

  method actualizar(_valorNuevo) {
    valor = _valorNuevo
  }
}


object score inherits Interfaz(position = game.at(6,7), valor = 0) {
  method addScore(v) {
    valor += v
  }
}


object recurso inherits Interfaz(position = game.at(6,6), valor = 100) {
  method añadirRecursos(v) {
    valor += v
  }

  method restarRecursos(v) {
    if (not trucos.infinityAmmo()) {
      valor -= v
    }
  }

  override method reiniciar() {
    valor = 100
  }
}


object piezasRestantes inherits Interfaz(position = game.at(6,5), valor = 0) {
  override method valorAMostrar() {
    return oleada.enemigosRestantes()
  }
}


object vida inherits Interfaz(position = game.at(6,0), valor = reyBlanco.vidas()) {
  method perderVida() {
    if (not trucos.modoDios()) {
      valor -= 1
      reyBlanco.vidas(valor)
    }
  }

  override method reiniciar() {
    valor = 3
    reyBlanco.vidas(3)
  }
}


object oleadaActual inherits Interfaz(position = game.at(6,4), valor = 1) {
  override method valorAMostrar() {
    return oleada.nivel()
  }

  override method reiniciar() {
    oleada.nivel(1)
  }
}
