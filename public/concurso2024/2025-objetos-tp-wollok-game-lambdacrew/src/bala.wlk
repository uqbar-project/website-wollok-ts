import src.tanque.*
import battlecity.*
import movimiento.*
import mapa.*

class Bala {

    var posicion
    const direccion

    var sprite = direccion.imagenBala()

    var oculto = false

    const lePerteneceA

    const fuerza = 1
    var rompeMurosReforzados = false

    method position() {
        return posicion
    }

    method image(){

        if (oculto) {
            return "invisible.png"
        }
            return sprite
    }

    method image(nuevaImagen){
        sprite =  nuevaImagen
    }

    method oculto() =  oculto

    method orientacion_bala(){
        return direccion
    }

    method habilitarRomperMurosReforzados(valor){
        rompeMurosReforzados = valor
    }

    method dibujarBala(){
        game.addVisual(self)
    }

    method lePerteneceA() = lePerteneceA

    method irPorAgua() = true

    method esAtravesable(entidad) = true

    method fuerza() = fuerza

    method rompeMurosReforzados() = rompeMurosReforzados

    method cambiarOculto(valor){
        oculto = valor
    }

    
    method moverBalas(){

        acciones_balas.controlar_interacciones(self)

        const nuevaPosicion = direccion.siguientePosicion(posicion)
        posicion = nuevaPosicion
        
    }

    method teChocoUnTanque (tanque) {}

    method puedeCubrirme() = false

}

object borrar_balas {

    method bala_logro_su_objetivo(elQueDisparo, unaBala){
        elQueDisparo.irBorrandoBalas(unaBala)
        game.removeVisual(unaBala)
    }
}

object acciones_balas {

    method controlar_interacciones(bala){

        if (limitesMapa.teSalisteDeLosLimitesDelMapa(bala)){
            borrar_balas.bala_logro_su_objetivo(bala.lePerteneceA(), bala)
        }

        if(!permitir_movimiento.puedoMovermeEnEstaDireccion(bala, bala.orientacion_bala())){
            permitir_movimiento.noPuedoAvanzarPorQueHayUnMuro(bala, bala.orientacion_bala())
        }

        if (permitir_movimiento.mePuedoCubrir(bala, bala.orientacion_bala())) {
            
            bala.cambiarOculto(true) 
        }

        if (!permitir_movimiento.mePuedoCubrir(bala, bala.orientacion_bala())) {
            
            bala.cambiarOculto(false)
        }
    }
}
