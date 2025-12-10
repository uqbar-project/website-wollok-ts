
import letraPadre.*
import sonido.*
class LetraNegra2 inherits LetraPadre {       
  override
    method doExplosion(){
        self.explotar("perderVida1.png", new Sonido(cancion="perderVida.mp3"))
    }


}