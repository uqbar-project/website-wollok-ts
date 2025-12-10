import config.*
import musica.*
import visuales.*
import wollok.game.*
import niveles.*

class Menu inherits Visual {
    method abrir()
    method cerrar()
    method configuracionTeclado()
}

object menuInicio inherits Menu {
    var property musica = musicaDeFondo
    var property abierto = false 
    override method abrir() {
        musica.play()
        abierto = true
        game.addVisual(self)
        self.configuracionTeclado()
    }
    override method configuracionTeclado() {
        keyboard.space().onPressDo({self.cerrar()})
        if(abierto){keyboard.c().onPressDo({ menuControles.abrir()})}
        }
    override method cerrar() {
        if(!pantallaUno.abierto()){
        game.sound("open.wav").play()
        abierto = false
        game.removeVisual(self)
        musica.stop()
        juegoPorNiveles.nivelActual().initialize()
        juegoPorNiveles.nivelActual().pantalla().abrir()
        }
    }
    method initialize() {
        image = "inicio.gif"
        position = game.at(0,0)
    }
}

object menuPausa inherits Menu () {
    var property abierto = false 
    override method abrir() { 
        game.sound("pause.wav").play()
        if(!abierto and !juegoPorNiveles.nivelActual().pantalla().abierto() and !menuInicio.abierto()) {
            abierto = true
            game.addVisual(self)
            juegoPorNiveles.nivelActual().musica().pausar()
            self.configuracionTeclado()
        } else if(!menuControles.abierto()) {
            game.sound("close.wav").play()
            abierto = false
            game.removeVisual(self)
            juegoPorNiveles.nivelActual().musica().reanudar()
        }
    }
    override method cerrar() {}
    override method configuracionTeclado() {
        if(!menuInicio.abierto())keyboard.p().onPressDo({self.abrir()})
        if(abierto) { keyboard.m().onPressDo({ juegoPorNiveles.nivelActual().volverAlMenu()}) }
        if(abierto) { keyboard.c().onPressDo({menuControles.abrir()}) }
    }
    method initialize() {
        self.configuracionTeclado()
        image = "pausa.png"
        position = game.at(0,0)
    }
}

object menuGanador inherits Menu (image = "ganaste.jpg", position = game.at(0,0)) {
    var property abierto = false 
    var property musica = musicaGanadora
    override method abrir() {
        abierto = true
        game.clear()
        juegoPorNiveles.nivelActual().musica().stop()
        game.addVisual(self)
        musica.play()
        self.configuracionTeclado()
    }
    override method cerrar() {
        abierto = false
        game.removeVisual(self)
        musica.stop()
        game.sound("close.wav").play()
    }
    override method configuracionTeclado() {
        keyboard.space().onPressDo({ 
        self.cerrar()
        juegoPorNiveles.nivelActual().volverAlMenu() 
       })
    }
}

object menuPerdedor inherits Menu (image = "perdiste.jpg", position = game.at(0,0)) {
    var property abierto = false 
    var property musica = musicaPerdedora
    override method abrir() {
        abierto = true
        game.clear()
        musicaDeFondo.stop()
        musica.play()
        game.addVisual(self)
        self.configuracionTeclado()
    }
    override method cerrar() {
        abierto = false
        game.removeVisual(self)
        musica.stop()
        game.sound("close.wav").play()
    }
    override method configuracionTeclado() {
        keyboard.space().onPressDo({ 
        self.cerrar()
        juegoPorNiveles.nivelActual().volverAlMenu() 
       })
    }
}

object menuControles inherits Menu (image = "controles.png", position = game.at(0,0)) { 
    var property abierto = false
    override method abrir() {
        if(!abierto and menuPausa.abierto()){
            game.sound("pause.wav").play()
            abierto = true
            game.addVisual(self)
            self.configuracionTeclado()
        }
        else if(!abierto and menuInicio.abierto()) {
            game.sound("close.wav")
            abierto = true
            game.addVisual(self)
            self.configuracionTeclado()
        }
        else {
            abierto = false
            game.removeVisual(self)
        }
    }
    override method configuracionTeclado() {keyboard.c().onPressDo({self.abrir()})}
    override method cerrar() {}
}

object pantallaUno inherits Menu (position = game.at(0,0), image = "pantallaUno.jpg") {
    var property abierto = false
    override method abrir() {
        abierto = true
        game.addVisual(self)
        self.configuracionTeclado()
    }
    override method cerrar() {
        game.sound("pass.wav").play()
        abierto = false
        game.removeVisual(self)
        juegoPorNiveles.nivelActual().iniciarNivel()
    }
    override method configuracionTeclado() {keyboard.space().onPressDo({self.cerrar()})}
}

object pantallaDos inherits Menu (position = game.origin(), image = "pantallaDos.jpg") {
    var property abierto = false
    override method abrir() {
        game.sound("levelUp.wav").play()
        abierto = true
        game.addVisual(self)
        self.configuracionTeclado()
    }
    override method cerrar() {
        game.sound("pass.wav").play()
        abierto = false
        game.removeVisual(self)
        juegoPorNiveles.nivelActual().iniciarNivel()
    }
    override method configuracionTeclado() {keyboard.space().onPressDo({self.cerrar()})}
}

object pantallaTres inherits Menu (position = game.origin(), image = "pantallaTres.jpg") {
    var property abierto = false
    override method abrir() {
        game.sound("levelUp.wav").play()
        abierto = true
        game.addVisual(self)
        self.configuracionTeclado()
    }
    override method cerrar() {
        game.sound("pass.wav").play()
        abierto = false
        game.removeVisual(self)
        juegoPorNiveles.nivelActual().iniciarNivel()
    }
    override method configuracionTeclado() {keyboard.space().onPressDo({self.cerrar()})}
}