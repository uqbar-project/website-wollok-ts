/*
import powerUps.*
import tanque.*
import bala.*


class Enemigo {
    var salud
    var posicion
    var direccion
    var posicion_anterior = new Position()

    method image(){
        return "tanque_basico.png"
    }
    method position(){
        return posicion
    }

    method direccion(){
        return direccion
    }

    method dibujarTanqueAmenaza(){
        game.addVisual(self)
    }

    method recibirDaño(unaBala){
        salud = salud - unaBala.fuerza()
    }

    method explotar(){
       // vida_extra.aparecerPowerUp()
        game.removeVisual(self)
        game.removeTickEvent("Enemigo disparo")


    }

    method dispararBala(){
        // const bala = new Bala(direccion = self.direccion(), posicion = self.direccion().siguientePosicion(self.position()))
        // bala.dibujarBala()
        // bala.detectarColision()
        // game.onTick(100, "desplazarBala", {bala.move()})
        // game.onTick(1000, "borrar bala", {bala.borrarBala()})
    }

    method teImpactoUnaBala(unaBala){
        if(salud > 1) {
            self.recibirDaño(unaBala)
        }
        else {
            self.explotar()
        }
    }
}
class TanqueEnemigo_Basico{
    var aguanta = 1
    var position = new Position(x = 4, y = 3)
    var posicionAnterior = new Position()

    method position(){
        return position
    }

    method posicionAnterior(nuevaPosicion){
        posicionAnterior = nuevaPosicion
    }

    method image(){
        return "tanque_basico.png"
    }

    method teImpactoUnaBala(unaBala){
        game.removeVisual(self)
        // vida_extra.aparecerPowerUp()
    }

    method paraDondeIr(){
        const orden = 1.randomUpTo(4)

        if( orden == 1 ){
            return arriba
        }
        else if(orden == 2){
            return derecha
        }
        else if (orden == 3){
            return abajo
        }
        else {
            return izquierda
        }
    }

    method move(){
        const antiguaPosicion = self.position()
        const nuevaDireccion = self.paraDondeIr()
        const nuevaPosicion = nuevaDireccion.siguientePosicion(position)

        self.posicionAnterior(antiguaPosicion)
        position = nuevaPosicion
    }

}
*/