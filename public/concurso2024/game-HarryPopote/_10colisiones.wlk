import _08dementores.*
import _07harry.*
import _04visuales.*
import _03niveles.*

object colisiones {
    method configurar(personaje){
        game.whenCollideDo(personaje, { objeto => objeto.colisionarConHarry() })
    }
}