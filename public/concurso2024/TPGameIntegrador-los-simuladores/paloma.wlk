import muros.*
import juego.*
import configuraciones.*
import sonidos.*


object paloma {
  const posicionX = 1
  var property posicionY = 4
  var version = vuelo1
  var property color = natural
  
  method image() = (("paloma" + color.color()) + version.version()) + ".png"
  
  method cambiarVersion() {
    version = version.siguiente()
    aleteo.play()
  }
  
  method position() = game.at(posicionX, posicionY)
  
  method subir() {
    posicionY = 7.min(posicionY + 1)
  }
  
  method bajar() {
    posicionY = 0.max(posicionY - 1)
  }
  
  method teclasMovimiento() {
    keyboard.up().onPressDo({ self.subir() })
    keyboard.down().onPressDo({ self.bajar() })
  }
  
  method teclasColor() {
    keyboard.w().onPressDo({ self.color(azul) })
    keyboard.a().onPressDo({ self.color(verde) })
    keyboard.s().onPressDo({ self.color(rojo) })
    keyboard.d().onPressDo({ self.color(amarillo) })
  }

}

