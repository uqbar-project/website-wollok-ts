import letraPadre.*
import sonido.*
class LetraRoja2 inherits LetraPadre {       
  override
    method doExplosion(){
        self.explotar("aumentarCaida3.png", new Sonido(cancion="aumentarCaida.mp3"))
    }


}