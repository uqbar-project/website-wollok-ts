import wollok.game.*
import fantasma.*
import puntaje.*

//items que puede usar el jugador
class Item {
  var position = game.at(0, 0)
  var image = ""
  
  method esInteractivo() = true
  //el jugador puede interactuar (o sea pueden colisionar)
  
  method position(nueva) {
    position = nueva
  }
  
  method position() = position
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }

  method asustarse(jugador) {}
  method recibirDaño(cant) {}
  method actuar(jugador)
  method instanciar(posicion, cantidad)
  method esCazador() = false
}

class Pocion inherits Item {   //suma los puntos al jugador y le recupera una vida

  override method actuar(jugador) {
    if(game.hasVisual(self)){
    jugador.recuperarVida(puntaje.puntosPocion()) 
    game.removeVisual(self)
    }
  }
  
  override method instanciar(posicion, cantidad) {  //crea el objeto pocion
    self.image("pocionVida.png")
    self.position(posicion)
  }
}

class Trampa inherits Item { //resta puntos al jugador y le quita una vida
 
  override method actuar(jugador) {
    if(game.hasVisual(self)){
    jugador.recibirDaño(puntaje.puntosTrampa()) 
    game.removeVisual(self)
    }
  }
  
  override method instanciar(posicion, cantidad) { //crea el objeto trampa
    self.image("trampa.png")
    self.position(posicion)
  }
}