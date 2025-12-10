import wollok.game.*

class Musica {
    var property sonido
    var property archivo
    var property estado = false
    method play() {
        if(!estado) {
            estado = true
            sonido = game.sound(archivo)
            sonido.shouldLoop(true)
            sonido.volume(0.4)
            sonido.play()
        }
    }
    method pausar() { if(estado) {sonido.pause()}}
    method reanudar() {if(estado && sonido != null) {sonido.resume()}
}
    method stop() {
        if(estado) {
            estado = false
            sonido.stop()
        }
    }
}

object musicaDeFondo inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("menu.mp3")
        archivo = "menu.MP3"
    }
}

object musicaNivel1 inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("nivelUno.ogg")
        archivo = "nivelUno.ogg"
    }
}

object musicaNivel2 inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("nivelDos.mp3")
        archivo = "nivelDos.mp3"
    }
}

object musicaNivel3 inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("nivelTres.wav")
        archivo = "nivelTres.wav"
    }
}

object musicaGanadora inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("memoryReboot.mp3")
        archivo = "memoryReboot.mp3"
    }
}

object musicaPerdedora inherits Musica {
    method initialize() {
        estado = false
        sonido = game.sound("afterDark.mp3")
        archivo = "afterDark.mp3"
    }
}