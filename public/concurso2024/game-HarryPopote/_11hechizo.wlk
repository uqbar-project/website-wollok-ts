import _08dementores.*
import _04visuales.*
import _06sonidos.*

object hechizo {
  var property image = "patronusAzul.png"
  var property position = game.at(0, 0)
  var activo = false
  const tickId = "moverHechizo"
  var direccion = "derecha"
  var habilitado = false // activa solo para nivel 2

  method velocidad() = 0.5
  method disponible() = !activo
  method habilitar() { habilitado = true }
  method deshabilitar() { habilitado = false }
  method reset() { self.destruir() }
  method colisionarConHarry() {}
  
  method dispararDesde(unMago) {
  
  if (habilitado && !activo) {
    self.configurarDireccionYPosicionSegun(unMago)
    self.mostrarYActivar()
    self.programarMovimiento()
    self.registrarColisionConDementores()
  }
}

method configurarDireccionYPosicionSegun(unMago) {
  if (unMago.image() == "harry2.png") {
    direccion = "izquierda"
    position = game.at(unMago.position().x() - 1, unMago.position().y())
  } else {
    direccion = "derecha"
    position = game.at(unMago.position().x() + 1, unMago.position().y())
  }
}

method mostrarYActivar() {
  game.addVisual(self)
  activo = true
}

method programarMovimiento() {
  game.onTick(60, tickId, { self.mover() })
}

method registrarColisionConDementores() {
  game.whenCollideDo(self, { enemigo =>
    if (visuales.enemigos().contains(enemigo)) {
      game.removeVisual(enemigo)
      game.addVisual(enemigo.objeto())
         self.destruir()
    }
  })
}


  method mover() {    
    if (direccion == "izquierda") {
      position = position.left(self.velocidad()) 
    } else {
      position = position.right(self.velocidad())
    }
    if (position.x() < 0 || position.x() >= game.width()) {
      self.destruir()
    }
  }

  method destruir() {
    game.removeVisual(self)
    game.removeTickEvent(tickId) 
    activo = false
  }
    



  method configurarColision(target) {
    game.whenCollideDo(target, { objeto => objeto.colisionarConHechizo(self) })
}
}