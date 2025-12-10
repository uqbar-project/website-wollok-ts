import UI.*
import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import images.*
import oleadas.*
import pieza.*

class Enemigo inherits Pieza(position = game.at((0 .. 4).anyOne(), 7), ultimaFila = 0, color = negro, accesorio = new JaqueMate(piezaDueña = self)) {
  var contador = 3
  var property direccionesRandomizadas = []
  
  method posicionesAvanzables()

  override method posicionesCapturables() = self.posicionesAvanzables()

  method actualizarDirecciones() {
    direccionesRandomizadas = self.posicionesAvanzables().randomized()
  }

  method siguientePosicion() {
    if (direccionesRandomizadas.isEmpty()) {
      self.actualizarDirecciones()
    }
    
    const candidatos = direccionesRandomizadas.filter({ posicion => self.posicionValida(posicion) })
    return if (candidatos.isEmpty()) position else candidatos.anyOne()
  }
    
  method avanzar() {
    if (not muerto) {
      if (position.y() == 1 && contador >= 1){
        contador = contador - 1
        game.say(self, "contador " + contador)
        self.intentarAñadirJaque()
      } else {
        const pos = self.siguientePosicion()
        self.mover(pos.x(), pos.y())
        self.actualizarDirecciones()
      }

      self.intentarCapturar()
      self.capturarRey()
    }
  }

  method intentarAñadirJaque() {
    // No añadir jaque si el enemigo ya está muerto.
    if (not muerto && !game.hasVisual(accesorio)) {
      game.addVisual(accesorio)
    }
  }
  
  method capturarRey() {
    if (position.y() == 0) {
      if (reyBlanco.vidas() <= 0) {
        game.say(reyBlanco, "¡Game Over!")
        mecanicasJuego.gameOver()
      } else {
        vida.perderVida()//reyBlanco.perderVida()
        self.desaparece(500)
      }
    }
  }
}