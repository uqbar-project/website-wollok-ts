import rey.*
import enemigos.*
import wollok.game.*
import UI.*
import aliado.*
import images.*
import proyectiles.*
import timers.*

class PeonBlanco inherits Aliado(valor = 20, imagePieza = images.peonBlanco()) {
    override method posicionesCapturables() = [self.position().up(1).left(1), self.position().up(1).right(1)]
}

class CaballoBlanco inherits Aliado(valor = 50, imagePieza = images.caballoBlanco()) {
    override method posicionesCapturables() = [self.position().up(2).left(1), self.position().up(2).right(1), self.position().up(1).left(2), self.position().up(1).right(2)]//, self.position().down(2).left(1), self.position().down(1).left(2), self.position().down(2).right(1), self.position().down(1).right(2)]
}

class TorreBlanca inherits Proyectil (
    valor = 100,
    imagePieza = images.torreBlanco()) {
    override method posicionesCapturables() = [self.position().up(2), self.position().up(1)]
}

class AlfilBlanco inherits Proyectil (
    valor = 70,
    imagePieza = images.alfilBlanco()
){
    override method posicionesCapturables() = [self.position().up(1).right(1), self.position().up(1).left(1)]
    
    override method avanzarYComer() {
        if (self.tickName() == null) {
            self.tickName(timers.nextName("mov_alfil"))
            game.onTick(250, self.tickName(), {
                const miPos = self.position()
                const random = #{1, -1}.anyOne()
                self.mover(miPos.x()+random, miPos.y()+1)
                self.intentarCapturar()
                self.intentarCoronar()
            })
        }

    }

}