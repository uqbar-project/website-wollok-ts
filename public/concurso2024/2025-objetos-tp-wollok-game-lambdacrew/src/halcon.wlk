import src.tanque.*
import src.battlecity.*

class Halcon {

    const sprite_bandera = "halcon.png"
    var posicion = new Position(x = 4,y = 0 )

    const lePerteneceA
    const origen_bandera

    var capturada = false
    
    method position() = posicion

    method position(nuevaPosicion) {
        posicion = nuevaPosicion
    }

    method image() {
        return sprite_bandera
    }

    method dibujarHalcon(){
        game.addVisual(self)
    }

    method origen_bandera() = origen_bandera

    method aSidoCapturada() = capturada

    method lePerteneceA() = lePerteneceA
    
    method esAtravesable(entidad) = true

    method puedeCubrirme () = false

    method restablecerUbicacion() {
        posicion = origen_bandera
    }
    

    method liberada() {
        capturada = false
    }

    method fueCapturada() {
        capturada = true
        lePerteneceA.opcion_respawn(false)
    }

    method teChocoUnTanque (tanque) {
        if (lePerteneceA != tanque && !capturada) {
            tanque.agarrarBandera(self)
            game.removeVisual(self)
        }
        else if (lePerteneceA == tanque) {
            posicion = origen_bandera
            capturada = false
            tanque.opcion_respawn(true)
        } 
    }

    method bandera_cae_al_suelo_desde_la_ubicacion_de(unTanque){
        self.position(unTanque.position())
        self.dibujarHalcon()
    }
}

