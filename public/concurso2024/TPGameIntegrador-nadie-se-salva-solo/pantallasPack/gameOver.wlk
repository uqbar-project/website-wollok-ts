import pantallasPack.menu.Menu
import pantallasPack.juego2.*
import puntuacion.puntos
import sonido.Sonido
import pantallasPack.pantalla.Pantallas
class GameOver inherits Pantallas{

    const musica = new Sonido(cancion = "perdiste.mp3")
    const v = new Menu()

    override
    method image() = "gameOver2.png"

    override
    method mostrar(){
        self.playMusica()
        super()
    }

    method playMusica() {
        musica.reproducir(true)
        musica.cambiarVolumen(0.2)      
    }

   

    override
    method comportamiento(){
        
        keyboard.space().onPressDo({self.ocultar()})
      //  puntos.reubicar() funciona mal
    }    

    override
    method ocultar() {
        musica.parar()
        
        super()
        puntos.removeVisual()
        juego2.cambiarEscena(v)        
    }    


}