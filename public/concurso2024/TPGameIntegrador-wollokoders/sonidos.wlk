class Sonido {
    var estaSilenciado = false
    const path

    method play() {
        if (not estaSilenciado) game.sound(path).play()
    }

    method estaSilenciado(bool) {
        estaSilenciado = bool
    }
}

class SonidoLoop inherits Sonido {
    const sound = game.sound(path)

    override method play() {
        sound.shouldLoop(true)
        sound.volume(0.5)
        game.schedule(500, { sound.play() })
    }

    method estaPausado() = sound.paused()

    method playPause() {
        if(estaSilenciado) sound.pause()
        else sound.resume()
    }
}

object sonidos {
    const direcciones = [
        new Sonido(path="desplazar-derecha.mp3"),
        new Sonido(path="desplazar-izquierda.mp3"),
        new Sonido(path="desplazar-arriba.mp3"),
        new Sonido(path="desplazar-abajo.mp3")
    ]

    const misc = [
        new Sonido(path="correcto.mp3"),
        new Sonido(path="incorrecto.mp3"),
        new Sonido(path="win.mp3"),
        new SonidoLoop(path="copatheme.mp3")
    ]

    method derecha() = direcciones.get(0)
    method izquierda() = direcciones.get(1)
    method arriba() = direcciones.get(2)
    method abajo() = direcciones.get(3)
    method correcto() = misc.get(0)
    method incorrecto() = misc.get(1)
    method ganar() = misc.get(2)
    method fondo() = misc.get(3)

    method silenciarTodo(bool) {
        (direcciones + misc).forEach({s => s.estaSilenciado(bool)})
        self.fondo().playPause()
    }
}