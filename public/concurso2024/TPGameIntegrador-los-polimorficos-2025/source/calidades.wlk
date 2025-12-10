import objetos.*
import escenario.*

object calidadBaja {
    method configurar() {
        escenario.calidad(self)
    }
    method espinasDelAlien(posX , posY) {
        return new Espina(position = game.at(posX, posY))
    }

    method humo(posX , posY) {
        return new HumoEstatico(position = game.at(posX, posY))
    }

    method fuego(posX , posY) {
        return new FuegoEstatico(position = game.at(posX, posY))
    }

}

object calidadAlta {
    method configurar() {
        escenario.calidad(self)
    }
    method espinasDelAlien(posX , posY) {
       return new EspinaAnimada(position = game.at(posX, posY))
    }

    method humo(posX , posY) {
        return new Humo(position = game.at(posX, posY))
    }

    method fuego(posX , posY) {
        return new LlamaAnimada2(position = game.at(posX, posY))
    }
}