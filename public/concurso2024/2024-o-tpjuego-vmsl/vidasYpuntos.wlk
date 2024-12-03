import configuracion.*
import platos.*
import clientes.*
import mueblesMapa.*
import mozo.*

class Estrella {
  var property image = "estrella.png"
  var property position
}

object vida{
    var property vidas = [
    new Estrella(position = game.at(29, 14)),
    new Estrella(position = game.at(28, 14)),
    new Estrella(position = game.at(27, 14))
  ]
  
  method perderVida() {
    if (vidas.size() == 1) {
    configuracion.terminarJuego()
    } else {
      const vidaParaEliminar = vidas.findOrDefault({vida1 => vidas.all({vida2 => vida1.position().x() >= vida2.position().x() }) }, null) // Flashbacks de haskell
      game.removeVisual(vidaParaEliminar)
      vidas.remove(vidaParaEliminar)
    }
  }
}


object puntaje {
  var property puntaje = 0
  //var property image = 0
  const property position = game.at(0, 14)
  
  method cambiarPuntaje(nuevoPuntaje) {
    puntaje += nuevoPuntaje
  }
  
  method text() = puntaje.toString()
  //method fontSize() = 24
  method textColor() = "FFFFFFFF"
  
  //de esta forma, puede que distintos nombres de metodos a llamar
  method sumarPuntos(cliente) {
    self.cambiarPuntaje(cliente.plato().puntaje() * cliente.multiplicador())
  }
  
  method restarPuntos(cliente) {
    self.cambiarPuntaje(-1000* cliente.multiplicador())
  }
}