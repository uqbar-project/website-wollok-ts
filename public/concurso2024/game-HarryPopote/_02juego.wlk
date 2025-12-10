import _03niveles.*
import _06sonidos.*

object juego {
    method iniciar() {
      game.boardGround("inicioModBoard.png")
      musicaJuego.reproducir()
      
     self.iniciarNivel1()
    }
      method iniciarNivel1(){
        keyboard.space().onPressDo({
        nivel1.comenzar()})
      }
      
    } 

 

