import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import nivel1.*
import nivel2.*


//configura la ventana del juego
object juego {
    method configurar() {
        game.title("GhostRevenge")
        game.width(30)
        game.height(16)
        game.cellSize(64)
        historia.configurar()
        game.start()
    }
}

//configura la pantalla que cuenta la historia
object historia {
    const fondo = new Fondo(image = "fondoHistoria.jpg") 

    method configurar() {
        musica.configurar() 
        musica.empezarMusicaInicio()
        game.addVisual(fondo)
        keyboard.m().onPressDo({ pantallaInicio.configurate() }) 
    }
}

//configuracion de la pantalla de inicio antes de elegir el nivel
object pantallaInicio {

  // La pantalla de configuración inicial
  const fondoEmpezar = new Fondo(image = "fondoInicio.jpg") 
  method configurate() {
    game.clear()
    estadoJuego.cambiarNivelActual("")
    grimly.image("fantasma_frente.png")
    grimly.resetPosition()
    posicionesInvalidas.cargarInicio()
    controles.configurarTeclas()
    game.addVisual(fondoEmpezar)
    game.addVisual(grimly)
    musica.configurar()
    musica.empezarMusicaInicio()
    keyboard.h().onPressDo({ historia.configurar() }) 
  }
}

object musica {
  const property musicaInicio = game.sound("musicaInicio.wav")
  const property musicaJuego = game.sound("musicaFondo.mp3")

  var configurada = false
  // se inicializa con el objeto nulo
  var sonidoActual = musicaNula 

  method configurar() {
  // configura la música de fondo
    if (not configurada) {
        musicaInicio.shouldLoop(true)
        musicaInicio.volume(0.20)
        musicaJuego.shouldLoop(true)
        musicaJuego.volume(0.10)
        configurada = true
    }
  }

  method cambiarASonido(nuevoSonido) {
    if (sonidoActual != nuevoSonido) {
    // detiene el sonido actual. Si es 'musicaNula', el método .stop() no hace nada.
        sonidoActual.stop()
    // actualiza el estado y empieza el nuevo sonido.
        sonidoActual = nuevoSonido
        sonidoActual.play()
    }   
  }

  method empezarMusicaInicio() {
    self.cambiarASonido(musicaInicio)
  }

  method empezarMusicaJuego() {
    self.cambiarASonido(musicaJuego)
  }

  method pararMusica(unSonido) {
    if (sonidoActual == unSonido) {
   // detiene la música y vuelve al estado nulo.
        unSonido.stop()
        sonidoActual = musicaNula
    }
  }

  method pararMusicaInicio() {
    self.pararMusica(musicaInicio)
  }

  method pararMusicaJuego() {
    self.pararMusica(musicaJuego)
  }
}

object musicaNula {
//implementa los métodos que se usan en 'sonidoActual' (ninguno hace nada)
  method stop() {} 
  method play() {}
  method shouldLoop(loop) {} 
  method volume(vol) {} 
}



