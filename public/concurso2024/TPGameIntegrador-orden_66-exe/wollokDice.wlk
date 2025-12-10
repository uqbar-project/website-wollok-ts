import wollok.game.*
import interfaz.*
import colores.*
import imagenes.*
import sonidos.*
import Puntuacion.*

object wollokDice {
  var enJuego = false
  var flechasActivas = false
  var reiniciar = false
  var startGame = false
  const musicaDeFondo = new GameMusic()
  const musicaMenu = new MenuMusic()
  
  method enJuego() = enJuego
  
  method flechas() = flechasActivas
  
  method reiniciar() = reiniciar
  
  method cambiarEnJuego() {
    enJuego = not enJuego
  }
  
  method startGame(value) {
    startGame = value
  }
  
  method iniciar() {
    game.width(20)
    game.height(20)
    game.cellSize(51)
    game.title("Wollok Dice")
    game.boardGround("fondoBase.jpg")
    game.addVisual(fondoInicio)
    sonido.ejecutar(musicaMenu)
    game.start()
    self.initTeclado()
  }
  
  method initTeclado() {
    keyboard.enter().onPressDo({ self.seleccionarDificultad() })
    
    keyboard.num1().onPressDo({ self.iniciarGame("facil") })
    keyboard.num2().onPressDo({ self.iniciarGame("dificil") })
    
    keyboard.r().onPressDo({ interfaz.reiniciar() })
    keyboard.i().onPressDo({ interfaz.mostrarInstruciones() })
    keyboard.b().onPressDo({ interfaz.mostrarMenu() })
    keyboard.h().onPressDo({ interfaz.mostrarHighScore() })
    keyboard.p().onPressDo({ game.stop() })
    
    keyboard.w().onPressDo({ interfaz.addSecuenciaJugador(rojo) })
    keyboard.s().onPressDo({ interfaz.addSecuenciaJugador(azul) })
    keyboard.d().onPressDo({ interfaz.addSecuenciaJugador(verde) })
    keyboard.a().onPressDo({ interfaz.addSecuenciaJugador(amarillo) })
    
    keyboard.up().onPressDo({ interfaz.cambiarUnaLetra("restar") })
    keyboard.down().onPressDo({ interfaz.cambiarUnaLetra("sumar") })
    keyboard.left().onPressDo({ interfaz.cambiarCursor("izq") })
    keyboard.right().onPressDo({ interfaz.cambiarCursor("der") })
    
    keyboard.space().onPressDo({ interfaz.despuesDelNombre() })
  }
  
  method seleccionarDificultad() {
    if (!enJuego) {
      startGame = true
      if (game.hasVisual(fondoInicio)) game.removeVisual(fondoInicio)
      if (not game.hasVisual(seleccionDificultad)) game.addVisual(
          seleccionDificultad
        )
    }
  }
  
  method iniciarGame(unaDificultad) {
    if ((!enJuego) && startGame) {
      interfaz.setDificultad(unaDificultad)
      if (game.hasVisual(seleccionDificultad)) game.removeVisual(
          seleccionDificultad
        )
      game.addVisual(sinColores)
      puntos.addVisual()
      puntos.ubicar()
      if (sonido.enEjecucion(musicaMenu)) sonido.detener(musicaMenu)
      sonido.ejecutar(musicaDeFondo)
      enJuego = true
      reiniciar = false
      flechasActivas = false
      interfaz.prepararNivelInicial()
      self.mostrarSecuencia()
    }
  }
  
  method continuarGame() {
    self.mostrarSecuencia()
  }
  
  method mostrarSecuencia() {
    flechasActivas = false
    var time = 1000
    interfaz.removeImages([sinColores])
    interfaz.secuenciaArealizar().forEach(
      { color =>
        game.schedule(time - 500, { sinColores.mostraryOcultar() })
        game.schedule(time, { color.mostraryOcultar() })
        time += 1000
      }
    )
    if (time === 1000) {
      time += 1000
    }
    
    game.schedule(time, { game.addVisual(sinColores) })
    game.schedule(
      time,
      { if (not game.hasVisual(tuTurno)) game.addVisual(tuTurno) }
    )
    game.schedule(time, { flechasActivas = true })
  }
  
  method ocultarFlechas() {
    flechasActivas = false
  }
  
  method perdio() {
    if (sonido.enEjecucion(musicaDeFondo)) sonido.detener(musicaDeFondo)
    if (!sonido.enEjecucion(musicaMenu)) sonido.ejecutar(musicaMenu)
    reiniciar = true
  }
}
