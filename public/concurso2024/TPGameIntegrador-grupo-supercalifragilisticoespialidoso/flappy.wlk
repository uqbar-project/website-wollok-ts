import wollok.game.*
import sound.*

object flappyBird {
  var property position = game.at(15, 45)
  var velocity = 0
  var indice = 0
  const frames = ["yellowbird-midflap.png", "yellowbird-upflap.png", "yellowbird-downflap.png"]

  method image() = frames.get(indice) 


  method flap() {
    velocity = -5
    indice = 1 // Para que cambie de imagen
    wing.play()
  }

  method caer() {
    velocity = velocity + 1
    position = position.down(velocity)
    indice = 2 // Para que cambie de imagen
  }

  method reiniciar() {
    position = game.at(15, 45)
    velocity = 0
    indice = 0 // Para que cambie de imagen
  } 
  method colisionoTop(unPipe) = self.position().x() == unPipe.position().x() and self.position().y() < unPipe.position().y() 
  method colisionoBottom(unPipe) = self.position().x() == unPipe.position().x() and self.position().y() > unPipe.position().y()
}