import wollok.game.*

class PositionMejorada inherits MutablePosition {
    method goLeftMejorado(pasos, limite) {
        x = (x-pasos).max(limite)
    }

    method goRightMejorado(pasos, limite) {
        x = (x+pasos).min(limite)
    }

    method horizontalMejorado(pasos, limiteIzq, limiteDer) {
        x = (x+pasos).max(limiteIzq).min(limiteDer)
    }

    method goUpMejorado(pasos, limite) {
        y = (y+pasos).min(limite) 
    }

    method goDownMejorado(pasos, limite) {
        y = (y-pasos).max(limite) 
    }

    method verticalMejorado(pasos, limiteSup, limiteInf) {
        y = (y+pasos).min(limiteSup).max(limiteInf)
    }
}

class Personaje {
    method mostrar() {
        if(!game.hasVisual(self))
            game.addVisual(self)
    }

    method ocultar() {
        if(game.hasVisual(self))
            game.removeVisual(self)
    }
}