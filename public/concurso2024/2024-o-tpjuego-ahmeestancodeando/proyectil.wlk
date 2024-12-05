// ===============================
// Revisado
// ===============================

import adminProyectiles.*
import game.*
import administradorDeEnemigos.administradorDeEnemigos


// ===============================
// Proyectil: Clase base para proyectiles
// ===============================
class Proyectil {
    // Propiedades
    var property tipoProyectil
    const position = new MutablePosition()
    const property danio = tipoProyectil.danio()
    var frame = 0
    var imagen = tipoProyectil.imagenes().get(0)
   
    // Métodos públicos
    method position() = position
    method image() = imagen
    method frenarEnemigo() = false
    method sePuedeSuperponer() = true

    // Método de movimiento
    method mover() {
        imagen=tipoProyectil.imagenes().get(0)
        frame=1
        position.goRight(1)
        if (self.llegueAlFinal() || self.verificarEnemigosEnfrente()) { self.eliminar() }
        
    }
    // Método que revisa si llego al final
    method llegueAlFinal() = position.x() >= 14
    // Método de colisión
    method colisionar() {tipoProyectil.colisionar().apply(self)}

    method combinar(){
        const posicionEnFrente = new MutablePosition(x = position.x(), y = position.y())

        const objetosEnPosicion = game.getObjectsIn(self.position()) + game.getObjectsIn(posicionEnFrente)

        const hayColision =  objetosEnPosicion.any({ objeto => objeto != self && objeto.combinarProyectil(self.tipoProyectil())}) //aparentemente wollok tiene lazy evaluation, chad wollok ;)
        if (tipoProyectil.puedeCombinarse() &&  hayColision ) {
            self.eliminar()
        }
    }

    method combinarProyectil(otroTipo){
        if (tipoProyectil.condicionParaCombinarse(otroTipo) && tipoProyectil.puedeCombinarse()){ 
            tipoProyectil = tipoProyectil.combinar()
            return true
            }
        return tipoProyectil.condicionParaCombinarse(otroTipo) && tipoProyectil.puedeCombinarse()
    }

    // Métodos para recibir daño
    method recibeDanioEnemigo(_danio) {return false}
    method recibeDanioMago(_danio) { return false}

    // Método para destruir el proyectil
    method destruirse() {
        if (tipoProyectil.destruirse()) { self.eliminar()}
    }

    // Método para eliminar el proyectil
    method eliminar() {
        game.removeVisual(self)
        administradorDeProyectiles.destruirProyectil(self)
    }

    method verificarEnemigosEnfrente() = !administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y() == self.position().y() && enemigo.position().x() >= self.position().x()-2})
    
    method cambiarFrame() {
        imagen=tipoProyectil.imagenes().get(frame)
        if(frame<2) {frame+=1}
    }
    method matarSlime(){}
}


// ===============================
// Proyectil Normal: Implementación específica de un proyectil normal
// ===============================
object proyectilNormal {
    // Métodos públicos
    const property imagenes = ["p.proyectilFuego - frame1.png", "p.proyectilFuego - frame2.png", "p.proyectilFuego - frame3.png"]
    method danio() = 40
    method destruirse() = true
    method combinar() = proyectilPenetrante
    method puedeCombinarse() = true
    
    method puedeCombinarseConNormal() = true
    method puedeCombinarseConPenetrante() = false
    method condicionParaCombinarse(otroTipo) = otroTipo.puedeCombinarseConNormal() 
    method colisionar() ={proyectil=>
        const posicionEnFrente = new MutablePosition(x = proyectil.position().x() + 1, y = proyectil.position().y())

        const objetosEnPosicion = game.getObjectsIn(proyectil.position()) + game.getObjectsIn(posicionEnFrente)

        const hayColision =  objetosEnPosicion.any({objeto => try objeto.recibeDanioEnemigo(proyectil.danio()) catch e false})
       
        if (hayColision) {
            proyectil.destruirse()
        }
    }
}


// ===============================
// Proyectil Penetrante: Implementación específica de un proyectil penetrante
// ===============================
object proyectilPenetrante {
    // Métodos públicos
    const property imagenes = ["p.proyectilHielo-frame1.png", "p.proyectilHielo-frame2.png", "p.proyectilHielo-frame3.png"]
    method danio() = 45
    method destruirse() = false
    
    method combinar() = superProyectil
    method puedeCombinarse() = true
    method puedeCombinarseConNormal() = false
    method puedeCombinarseConPenetrante() = true
    method condicionParaCombinarse(otroTipo) = otroTipo.puedeCombinarseConPenetrante() 
    method colisionar() = proyectilNormal.colisionar()
}
// ===============================
// Super Proyectil: Implementación específica de un super proyectil
// ===============================
object superProyectil {
    // Métodos públicos
    const property imagenes = ["p.superProyectil-1.png", "p.superProyectil-2.png", "p.superProyectil-3.png"]
    method danio() = 100
    method destruirse() = false
    method combinar() = self
    method puedeCombinarse() = false
    method puedeCombinarseConNormal() = false
    method puedeCombinarseConPenetrante() = false
    method condicionParaCombinarse(otroTipo)=false
    method colisionar() = proyectilNormal.colisionar()
}

object proyectilDeStop{
    const property imagenes = ["p.proyectilDeStop-frame1.png", "p.proyectilDeStop-frame2.png", "p.proyectilDeStop-frame3.png"]
    method danio() = 20
    method destruirse() = true
    method combinar() = self
    method puedeCombinarse() = false
    method puedeCombinarseConNormal() = false
    method puedeCombinarseConPenetrante() = false
    method condicionParaCombinarse(otroTipo)=false
    method colisionar() ={proyectil=>
        const posicionEnFrente = new MutablePosition(x = proyectil.position().x() + 1, y = proyectil.position().y())

        const objetosEnPosicion = game.getObjectsIn(proyectil.position()) + game.getObjectsIn(posicionEnFrente)
        const hayColision =  objetosEnPosicion.any({objeto => objeto.recibeDanioEnemigo(proyectil.danio()) && objeto.meFreno(false)})
        if (hayColision) {
            proyectil.destruirse()
        }
    }
}