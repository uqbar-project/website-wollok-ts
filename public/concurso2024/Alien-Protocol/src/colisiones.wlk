import wollok.game.*
import elementos.*

object colisiones{
    var property obstaculos = [] 
    var property enemigos = []
    var property salidas = []
    
    method limpiar() {
        enemigos.clear()
        obstaculos.clear()
        salidas.clear()
    }
    method agregarObstaculo(obstaculo) = obstaculos.add(obstaculo)
    method agregarEnemigo(enemigo) = enemigos.add(enemigo)

   method hayObstaculoEn(posX, posY){
        return obstaculos.any({obstaculo => obstaculo.estaEnCelda(posX, posY) })
    }

    method hayEnemigoEn(posX, posY){
        return enemigos.any({enemigo => enemigo.estaEnCelda(posX, posY)})
    }

    method obtenerEnemigoEn(x, y) {
        return enemigos.find({
            ene => ene.estaEnCelda(x, y)
        })
    }

    method haySalidaEn(x, y) {

        if(salidas == null) return false
        if(salidas.isEmpty()) return false

        return salidas.any({
            s => s.position().x() == x && s.position().y() == y
        })
    }

}