// ===============================
// Revisado
// ===============================
import administradorDeEnemigos.*
import administradorDeJuego.*
import wollok.game.*
import slime.*

// ===============================
// Objeto: Casa
// ===============================
object casa {
  var property vida = 3
  
  method sonidoDanio() = game.sound("m.explosion.mp3")
  // efecto de explosion cuando llegan al fin de la pantlla
  
  method position() = new MutablePosition(x = 12, y = 5)
  
  method text() = "Vidas restantes: " + vida.toString()
  
  method textColor() = "#FA0770"
  
  method recibirDanio(fila) {
    vida -= 1
    administradorDeEnemigos.enemigos().filter(
      { enemigo => enemigo.position().y() == fila }
    ).forEach({ enemigo => enemigo.matarSlime() })
    // elimina enemigos de la misma fila
    self.sonidoDanio().volume(0.3)
    if (vida <= 0) {
      pantalla.nuevoEstado(derrota)
      administradorDeJuego.terminarJuego()
    }
  }
  
  method reset() {
    vida = 3
  }
}