import instrucciones.*
import enemigo.*
import personajes.*
import game.*
import interfazJuego.*
import configInterfaz.*
import tablero.*
import marco.*
import oro.*

object config{
    var property maximoTropas = 0
    method configurarTeclas() {
        self.controlesMarco()
        self.elegirCarta()
        self.reinicio()
        self.pausa()
	}

    method controlesMarco(){
		keyboard.left().onPressDo({marco.intentarMoverA(marco.position().left(1))})
		keyboard.right().onPressDo({marco.intentarMoverA(marco.position().right(1))})
		keyboard.up().onPressDo({marco.intentarMoverA(marco.position().up(1))})
		keyboard.down().onPressDo({marco.intentarMoverA(marco.position().down(1))})
    }
    
    method elegirCarta(){
        keyboard.num1().onPressDo({tablero.intentarAgregarEntidad(new Monje(position = marco.position(),equipo = equipoAzul))})
        keyboard.num2().onPressDo({tablero.intentarAgregarEntidad(new Arquero(position = marco.position(),equipo = equipoAzul))})
        keyboard.num3().onPressDo({tablero.intentarAgregarEntidad(new Infanteria(position = marco.position(),equipo = equipoAzul))})
    }

    method reinicio() {
        keyboard.r().onPressDo({juego.reiniciar()})     
    }
    method pausa() {
        var estaPausado = false
        keyboard.p().onPressDo({
            estaPausado != estaPausado
            if (!estaPausado and instrucciones.estaCerrado()) {
                estaPausado = true
                juego.pausar()
            } else{
                juego.desPausar()
                estaPausado = false
            }
        })
    }
}

object paleta {
    const property verde = "00FF00FF"
    const property rojo = "FFC900"
    const property white = "FAFAFA"
}

// Las notificaciones podríamos hacerlas una clase

object notificacionDeVictoria {
    method position() = game.at(0,0)
    method image() = "notificacion-victoria.png"
    method mostrarNotificacion() {
        game.addVisual(self)
    }
    method ocultarNotificacion() {
        game.removeVisual(self)
    }
}

object notificacionDeDerrota {
    method position() = game.at(0,0)
    method image() = "mensaje-derrota.png"
}

object notificacionDePausa {
    method position() = game.at(0,0)
    method image() = "nuevo-mensaje-pausa.png"
    method mostrarNotificacion() {
        game.addVisual(self)
    }
    method ocultarNotificacion() {
        game.removeVisual(self)
    }
}

object notificacionNoHayOro {
    var property seEstaMostrando = false
    method position() = game.center()
    method text() = 'No hay oro suficiente'
    method textColor() = paleta.rojo()
    method mostrarNotificacion() {
        if (!seEstaMostrando) {
            game.addVisual(self)
            seEstaMostrando = true
        }
        game.schedule(2000, {game.removeVisual(self)})
        game.schedule(2000, {self.seEstaMostrando(false)})
    }
}

object notificacionDeAlertaMaximaEntidades {
    var property seEstaMostrando = false
    method position() = game.center()
    method text() = 'Máximo de tropas alcanzadas'
    method textColor() = paleta.rojo()
    method mostrarNotificacion() {
        if (!seEstaMostrando) {
            game.addVisual(self)
            seEstaMostrando = true
        }
        game.schedule(2000, {game.removeVisual(self)})
        game.schedule(2000, {self.seEstaMostrando(false)})
    }
}

object juego {
    var property estaIniciado = false
    var property partidaTerminada = false
    const musicaAmbiente = game.sound('musica-ambiente.mp3')
    method iniciarJuego(){
        if (!estaIniciado){
            estaIniciado = true
            tablero.agregarEntidad(new Torre(position = game.at(16,9),equipo = equipoRojo))
            tablero.agregarEntidad(new Torre(position = game.at(20,5),equipo = equipoRojo))
            tablero.agregarEntidad(new Torre(position = game.at(16,1),equipo = equipoRojo))
            tablero.agregarEntidad(new Torre(position = game.at(5,9),equipo = equipoAzul))
            tablero.agregarEntidad(new Torre(position = game.at(1,5),equipo = equipoAzul))
            tablero.agregarEntidad(new Torre(position = game.at(5,1),equipo = equipoAzul))
            tablero.agregarTeclasInstrucciones(teclaPausa)
            tablero.agregarTeclasInstrucciones(teclaReinicio)
            oro.mostrarOro()
            musicaAmbiente.volume(0.3)
            musicaAmbiente.shouldLoop(true)
            musicaAmbiente.play()
        }
    }
    method ganar(){
        if (!partidaTerminada) {
            partidaTerminada = true   
            self.pararJuego()
            const sonidoVictoria = game.sound("sonido-victoria.mp3")
            sonidoVictoria.volume(0.3)
            sonidoVictoria.play()
            game.addVisual(notificacionDeVictoria)
            game.removeTickEvent('regenerarOro')
        }
    }
    method reiniciar(){
        if(estaIniciado){
            // Sacamos las alertas de victoria o derrota
            game.removeVisual(notificacionDeVictoria)
            game.removeVisual(notificacionDeDerrota)

            // Reiniciamos las flags
            estaIniciado = false
            partidaTerminada = false
            instrucciones.estaCerrado(false)

            // Pausamos la música
            musicaAmbiente.stop()
        
            // Limpiamos el juiego
            self.pararJuego()
            game.removeTickEvent('regenerarOro')
            oro.borrarOro()
            tablero.limpiar()
            tablero.reiniciarOro()
            
            // Visualizar interfaz otra vez
            interfaz.aparecerInterfaz()
            configInterfaz.reiniciar()
            configInterfaz.seleccionarDificultad()
        }
        else {
            partidaTerminada = false
        }
    }
    method pausar(){
        self.pararJuego()
        notificacionDePausa.mostrarNotificacion()
        
    }
    method desPausar(){
        self.continuarJuego()
        notificacionDePausa.ocultarNotificacion()
    }

    method pararJuego(){
        game.removeTickEvent("regenerarOro")
        game.removeTickEvent("comportamiento")
        marco.puedeMoverse(false)
    }
    method continuarJuego(){
        enemigo.iniciar()
        marco.puedeMoverse(true)
        tablero.descongelarEntidades()
        game.onTick(1500, 'regenerarOro', {tablero.regenerarOro()})
    }

    method perder(){
        // Inicializamos la constante de sonido derrota acá para que no haya problemas al reiniciar
        if (!partidaTerminada) {
            partidaTerminada = true
            const sonidoDerrota = game.sound("sonido-derrota.mp3")
            sonidoDerrota.volume(0.3)
            sonidoDerrota.play()
            self.pararJuego()
            game.addVisual(notificacionDeDerrota)
            game.removeTickEvent('regenerarOro')
        }
    }
}

class Teclas {
    method image()
    method position()
}

object teclaPausa inherits Teclas {
    override method image() = "tecla-pausaer.png"
    override method position() = game.at(25,15)
}

object teclaReinicio inherits Teclas {
    override method image() = "tecla-reinicio.png"
    override method position() = game.at(25,12)
}