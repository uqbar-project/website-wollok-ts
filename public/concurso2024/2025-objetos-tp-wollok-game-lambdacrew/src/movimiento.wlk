import battlecity.*

object izquierda {
    method siguientePosicion(posicion) {
        return posicion.left(1)
    }

    method controlInvertido() = derecha

    method imagenBala() = "bala_tanque_left.png"

    method imagenTanque1() = "tank_left.png"

    method imagenTanque2() = "tankP2_left.png"
}
object abajo {
    method siguientePosicion(posicion) {
        return posicion.down(1)
    }

    method controlInvertido() = arriba

    method imagenTanque1() = "tank_down.png"

    method imagenTanque2() = "tankP2_down.png"
    

    method imagenBala() = "bala_tanque_down.png"
}
object arriba {
    method siguientePosicion(posicion) {
        return posicion.up(1)
    }

    method controlInvertido() = abajo

    method imagenBala() = "bala_tanque_up.png"

    method imagenTanque1() = "tank_up.png"

    method imagenTanque2() = "tankP2_up.png"
}
object derecha {
    method siguientePosicion(posicion) {
        return posicion.right(1)
    }

    method controlInvertido() = izquierda

    method imagenBala() = "bala_tanque.png"

    method imagenTanque1() = "tank_right.png"

    method imagenTanque2() = "tankP2_right.png"
}

object sinDireccion {
    method siguientePosicion(posicion) {
        return posicion
    }
    
    method controlInvertido() = self

    method imagenBala() = "bala_tanque.png"

    method imagenTanque1() = "tank_left.png"

    method imagenTanque2() = "tankP2_right.png"

}

object wraparound {
    method aplicarA(numero, topeInferior, topeSuperior) {
        if(numero < topeInferior) {
            return topeSuperior
        } else if(numero > topeSuperior) {
            return topeInferior
        } else {
            return numero
        }
    }
}



object permitir_movimiento{

    method puedoMovermeEnEstaDireccion (entidad, unaOrientacion) {
        return game.getObjectsIn(unaOrientacion.siguientePosicion(entidad.position())).all {unObj => unObj.esAtravesable(entidad)} && !limitesMapa.fueraDeLosLimites(unaOrientacion.siguientePosicion(entidad.position()))
    }

    method noPuedoAvanzarPorQueHayUnMuro (entidad, unaOrientacion) {
        game.getObjectsIn(unaOrientacion.siguientePosicion(entidad.position())).forEach 
            {unObj => 
                if (unObj.puedeSerDaniadoPorBala()){
                    unObj.recibirImpactoDeBala(entidad)
                }
            }
    }

    method mePuedoCubrir (entidad, unaOrientacion) {
        return game.getObjectsIn(unaOrientacion.siguientePosicion(entidad.position())).any {unObj => unObj.puedeCubrirme()} 
    }

}

object limitesMapa {

    method teSalisteDeLosLimitesDelMapa (elemento) = 
        elemento.position().x() > juegoBattleCity.ancho() || elemento.position().x() < 0 ||
        elemento.position().y() > juegoBattleCity.alto() || elemento.position().y() < 0


    method fueraDeLosLimites (posicionAControlar) =

        posicionAControlar.x() >= juegoBattleCity.ancho() || posicionAControlar.x() < 0 ||
        posicionAControlar.y() >= juegoBattleCity.alto() || posicionAControlar.y() < 0
    
}