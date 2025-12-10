import letraPadre.*
import sonido.*
class LetraVerde2 inherits LetraPadre {       
  override
    method doExplosion(){
        self.explotar("aumentarVida1.png", new Sonido(cancion="aumentarVida.mp3"))
    }
}