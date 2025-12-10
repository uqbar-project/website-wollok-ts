import menus.*
import musica.*
import niveles.*
import visuales.*
import wollok.game.*

object juegoPorNiveles {
  var property nivelesDeJuego = [nivelUno, nivelDos, nivelTres]
  var property indice = 0
  method iniciarJuego() {
    game.width(20)
    game.height(20)
    game.title("Wollok Dungeons")
    game.start()
    menuInicio.abrir()
  }
  method nivelActual() = nivelesDeJuego.get(indice)
  method pasarASiguienteNivel() {
    if(self.nivelActual().estaGanado()) {
        self.nivelActual().musica().stop()
        indice = indice + 1
        if (indice < nivelesDeJuego.size()) {
          self.nivelActual().initialize()
          self.nivelActual().pantalla().abrir()
      }
      else {
        indice -= 1
        menuGanador.abrir()
      }
    }
  }
}