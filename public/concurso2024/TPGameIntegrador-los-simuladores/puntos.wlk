import juego.*
import paloma.*
import muros.*
import configuraciones.*

object puntos {
  const decenas = [
    new Decena(valor = 0),
    new Decena(valor = 1),
    new Decena(valor = 2),
    new Decena(valor = 3),
    new Decena(valor = 4),
    new Decena(valor = 5),
    new Decena(valor = 6),
    new Decena(valor = 7),
    new Decena(valor = 8),
    new Decena(valor = 9)
  ]
  const unidades = [
    new Unidad(valor = 0),
    new Unidad(valor = 1),
    new Unidad(valor = 2),
    new Unidad(valor = 3),
    new Unidad(valor = 4),
    new Unidad(valor = 5),
    new Unidad(valor = 6),
    new Unidad(valor = 7),
    new Unidad(valor = 8),
    new Unidad(valor = 9)
  ]
  method iniciarPuntos() {
    game.addVisual(decenas.find({ d => d.valor() ==0 }))
    game.addVisual(unidades.find({ u => u.valor() == 0 }))
  }
  
  method mostrarPuntos(unValor) {
    const decena = unValor.div(10)
    const unidad = unValor % 10
    game.addVisual(decenas.find({ d => d.valor() == decena }))
    game.addVisual(unidades.find({ u => u.valor() == unidad }))
  }
  
  method sacarPuntos(unValor) {
    const decena = unValor.div(10)
    const unidad = unValor % 10
    game.removeVisual(decenas.find({ d => d.valor() == decena }))
    game.removeVisual(unidades.find({ u => u.valor() == unidad }))
  }
}

class Punto {
  const valor
  
  method image() = valor.toString() + ".png"
  
  method position()
  
  method valor() = valor
}

class Decena inherits Punto {
  override method position() = game.at(11, 5)
}

class Unidad inherits Punto {
  override method position() = game.at(11, 4)
}

object textoPuntos {
  method position() = game.at(11, 6)
  
  method image() = "puntos1.png"
  
  method mostrarPuntos() {
    game.addVisual(self)
  }
}