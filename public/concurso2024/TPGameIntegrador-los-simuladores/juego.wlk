import paloma.*
import muros.*
import configuraciones.*
import puntos.*
import sonidos.*

object juego {
  const muros = []
  var juegoIniciado = false
  var puntosActuales = 0
  var dificultad = 0
  
  method inicio() {
    juegoIniciado = false
    self.prepararTablero()
    self.presentacion()
  }
  
  method prepararTablero() {
    game.cellSize(75)
    game.height(8)
    game.width(12)
    game.title("FlyPichon")
    game.boardGround("fondo.png")
    muros.clear()
    self.reiniciarPuntos()
  }
  
  method presentacion() {
    game.addVisual(pantallaPresentacion)
    keyboard.e().onPressDo(
      { if (!juegoIniciado) {
          juegoIniciado = true
          dificultad = facil
          self.jugar()
        } }
    )
    keyboard.h().onPressDo(
      { if (!juegoIniciado) {
          juegoIniciado = true
          dificultad = dificil
          self.jugar()
        } }
    )
  }
  
  method perder() {
    perder.play()
    game.removeVisual(game.allVisuals())
    game.addVisual(pantallaPerder)
    game.removeVisual(paloma)
    game.removeTickEvent("AvanzarMuros")
    game.removeTickEvent("HacerMuros")
    game.removeTickEvent("cambio")
    keyboard.z().onPressDo({
      game.clear();
      self.inicio()
      })
  }
  
  method jugar() {
    self.baseJuego()
    dificultad.hacerMuro()
    game.onTick(self.tiempo(), "AvanzarMuros", { self.avanzarMuros() })
    game.onTick(self.tiempo() * 3, "HacerMuros", { dificultad.hacerMuro() })
    textoPuntos.mostrarPuntos()
    game.onCollideDo(paloma, { objeto => objeto.interaccionPaloma() })
    game.onCollideDo(eliminador, { b => b.interaccionEliminar() })
  }
  
  method dificil() {
    self.baseJuego()
  }
  
  method baseJuego() {
    game.removeVisual(pantallaPresentacion)
    game.onTick(500, "cambio", { paloma.cambiarVersion() })
    game.addVisual(paloma)
    game.addVisual(eliminador)
    dificultad.configurarTeclas()
    puntos.iniciarPuntos()
  }
  
  method agregarMuro(unMuro) {
    muros.add(unMuro)
  }
  
  method eliminarMuro() {
    const muro = muros.find({ f => f.posicionX() == eliminador.position().x() })
    muro.eliminar()
    muros.remove(muro)
  }
  
  method mostrarMuros() {
    muros.forEach({ m => m.mostrar() })
  }
  
  method avanzarMuros() {
    muros.forEach({ m => m.avanzar() })
  }
  
  method tiempo() = 750
  
  method especialPrimerMuro() = muros.first().nuevoEspecial()
  
  method sumarPunto() {
    puntos.sacarPuntos(puntosActuales)
    puntosActuales += 1
    puntos.mostrarPuntos(puntosActuales)
  }
  
  method reiniciarPuntos() {
    puntosActuales = 0
  }
  
  method puntosString() = puntos.toString()
}

object pantallaPresentacion {
  method image() = "presentacion.png"
  
  method position() = game.at(0, 0)
}

object pantallaPerder {
  method image() = "perder.png"
  
  method position() = game.at(0, 0)
}