import letraPadre.*
import sonido.*
class LetraAmarilla2 inherits LetraPadre {       
  override
    method doExplosion(){
        self.explotar("frenarCaida2.png", new Sonido(cancion="frenarCaida.mp3"))
    }


}