import src.elementos.*
import src.colisiones.*
import wollok.game.*
import balas.*
import posiciones.*

class Arma{
    var property nombre
    var property image
    var property municion               // -1 para infinita
    var property mejorada = false
    const property cadencia             // milisegundos entre disparos
    const property fabricaBalas
    const property esObstaculo = false
    const property danioBase 
    const property esComun = true

    method image() = image
    method nombre() = nombre
    
    method tieneMunicion() = municion == -1 or municion > 0

    method puedeDisparar() = self.tieneMunicion()

    method danio(){
        if(mejorada){
            return danioBase * 2
        } else {
            return danioBase
        }
    }

    method mejorar(){
        mejorada = true
    }

    method dispararDesde(posicion, direccion){
        if(not self.tieneMunicion()) return false

        if(self.municion() > 0){
            self.municion(self.municion()-1)
        }

        const bala = fabricaBalas.nuevaBala(posicion, direccion)
        bala.arma(self)
        game.addVisual(bala)
        bala.nuevoViaje(direccion)

        return bala
    }

    method esPistola() = false
}

class Pistola inherits Arma(
    nombre = "pistola",
    municion = -1,
    cadencia = 500,
    danioBase = 1,
    fabricaBalas = fabricaBalaPistola,
    image = "pistola.png"
){
    override method esPistola() = true
}


class Escopeta inherits Arma (
    nombre = "escopeta",
    municion = 6,
    cadencia = 800,
    danioBase = 3,
    fabricaBalas = fabricaBalaEscopeta,
    image = "escopeta.png"
){
    override method esComun() = false
}

class Ametralladora inherits Arma (
    nombre = "ametralladora",
    municion = 20,
    cadencia = 200,
    danioBase = 2,
    fabricaBalas = fabricaBalaAmetralladora,
    image = "ametralladora.png"
){
    override method esComun() = false
}

class ArmaEnSuelo inherits Obstaculo{
    
    var property arma           // Arma real (Escopeta o Ametralladora)
}


// ----------------- REGISTRO GLOBAL ARMAS EN EL PISO -----------------

object armasMundo{

    var property armasSuelo = []

    method dejarArma(posicion, arma) {
        const armaSuelo = new ArmaEnSuelo(
        position = posicion,
        image = arma.image(),
        arma = arma
        )
        armasSuelo.add(armaSuelo)
        game.addVisual(armaSuelo)
        //colisiones.obstaculos().add(armaSuelo)
    }

    method eliminar(armaSuelo) {
        armasSuelo.remove(armaSuelo)
        game.removeVisual(armaSuelo)
    }

    method armaEn(posicion) {
        return armasSuelo.find({ arma =>
            arma.position().x() == posicion.x()
            && arma.position().y() == posicion.y()
        })
    }
}
