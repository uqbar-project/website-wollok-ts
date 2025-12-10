import oleadas.*
import rey.*
import images.*

class Pieza {
    var property imagePieza
    var property position = game.at(0, 0)
    var property vidas = 1
    var muerto = false
    var property valor = 0
    var property ultimaFila
    const property color
    const accesorio = null

    method image() = if(muerto) images.piezaMuerta() else imagePieza

    method mover(posiciónx, posicióny) {
        if (self.estaDentroDelTablero(game.at(posiciónx, posicióny))){
            position = game.at(posiciónx, posicióny)}
    }
    
    method estaDentroDelTablero(posicion) = (((posicion.x() >= 0) and (posicion.x() < 5)) and (posicion.y() >= 0)) and (posicion.y() < game.height())
    
    method posicionValida(posicion) {
        return self.estaDentroDelTablero(posicion) && !self.hayPiezaCompañera(posicion)
    }

    method hayPiezaCompañera(posicion) {
        return color.hayPieza(posicion)
    }

    method esUltimaFila() {
        return ultimaFila == position.y()
    }

    method posicionesCapturables() = []

    method perderVida() {
        if (vidas > 0) {
            vidas = vidas - 1
        } else {
            self.desaparece(500)
        }
    }

    method desaparece(tiempo) {
        muerto = true
        if (game.hasVisual(accesorio)) {
            game.removeVisual(accesorio)
        }
        game.schedule(tiempo, { game.removeVisual(self) })
    }

    method intentarCapturar() {
        var capturado = false

        self.posicionesCapturables().forEach { pos =>  
            if (self.puedeCapturar(pos) && !capturado) {
                const pieza = color.piezaContrariaEn(pos)
                self.capturar(pieza)
                capturado = true
            }
        }
    }

    method puedeCapturar(pos) {
        return self.posicionValida(pos) && color.hayPiezaContraria(pos)
    }

    method capturar(pieza) {
        const posicionCaptura = pieza.position()
        self.mover(posicionCaptura.x(), posicionCaptura.y())
        pieza.desaparece(500)
    }

    method hayPiezaDeColor(_color, pos) {
       return _color.hayPieza(pos)
    }
}


class Color {
    const property deposito
    const property rival

    method piezasActivas() {return deposito.piezasActivas()}

    method hayPieza(pos) {
        return self.piezasActivas().any({pieza => pieza.position() == pos})
    }

    method piezaEn(pos) {
        return self.piezasActivas().findOrElse({pieza => pieza.position() == pos}, { false })
    }

    method hayPiezaContraria(pos) {
        return rival.hayPieza(pos)
    }

    method piezaContrariaEn(pos){
        return rival.piezaEn(pos)
    }
}
object negro inherits Color (deposito = oleada, rival = blanco) {
}

object blanco inherits Color (deposito = reyBlanco, rival = negro) {
}