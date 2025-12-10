import wollok.game.*
import general.*
import tableroYCartas.*
import interfaz.*
import mainMemoTest.*
import sonidosGlobales.*
import controladores.*
import highscores.*

object gameManager {
  var paresTotales = 1
  var esSoloDibujos = true
  var paresEncontrados = 0
  var juegoIniciado = false
  var reinicioHabilitado = true
  
  method configurarEscenario() {
    game.title("LeMemoTé")
    game.cellSize(140)
    game.height(5)
    game.width(5)
    game.boardGround("fondo.png")
  }
  
  method configurarControles() {
    self.iniciarControles()
    cursor.iniciarControles()
    tableroSiete.iniciarControles()
    menuInicio.iniciarControles()
    sonidosGlobales.iniciarControles()
    menuCrearHighscore.iniciarControles()
  }
  
  method iniciarControles() {
    keyboard.r().onPressDo({ if(reinicioHabilitado) self.reiniciarTodo() })
    keyboard.space().onPressDo({cursor.accionKeySpace() menuCrearHighscore.accionKeySpace()})
    keyboard.up().onPressDo({cursor.accionKeyUp() highscoreMngr.accionKeyUp()})
	  keyboard.down().onPressDo({cursor.accionKeyDown() highscoreMngr.accionKeyDown()})
    keyboard.w().onPressDo({cursor.accionKeyUp() highscoreMngr.accionKeyUp()})
	  keyboard.s().onPressDo({cursor.accionKeyDown() highscoreMngr.accionKeyDown()})    
    keyboard.o().onPressDo({fadeOut.iniciar()})
    keyboard.p().onPressDo({fadeIn.iniciar()})
  }
  
  method iniciar() {
    self.reiniciarAtributos()
    menuInicio.iniciar()
    sonidosGlobales.iniciarMusicaMenu()
  }
  
  method inicioDelJuego(numeroPares, tipoDeJuego) {
    paresTotales = numeroPares
    esSoloDibujos = tipoDeJuego
    juegoIniciado = true 
    sonidosGlobales.detenerMusicaMenu()
    sonidosGlobales.iniciarMusicaJuego()
    cursor.iniciar()
    tableroSiete.iniciar()
    fondoPuntajes.iniciar()
    puntuacionMngr.iniciar()
    tiempoMngr.iniciar()
    turnosMngr.iniciar()
    
  }
  
  method sumarParEncontrado() {
    paresEncontrados += 1
    self.analizarFinDelJuego()
  }
  
  method analizarFinDelJuego() {
    if (paresTotales == paresEncontrados) self.irACrearHighscore()
  }
  
  method irACrearHighscore() {
    sonidosGlobales.detenerMusicaJuego()
    sonidosGlobales.playVictoria()
    game.schedule(4000, {sonidosGlobales.iniciarMusicaMenu()})
    sombra.desactivar()
    cursor.desactivar()
    tiempoMngr.pausar()
    menuCrearHighscore.iniciar()
  }
  
  method reiniciarAtributos() {
    paresTotales = 1
    paresEncontrados = 0
    esSoloDibujos = true
    juegoIniciado = false
    reinicioHabilitado = true
  }
  
  method reiniciarTodo() {
    fadeOut.iniciar() 
    game.schedule(1100,{self.reiniciar()})
  }

  method reiniciar() {
    tableroSiete.desactivar()
    menuInicio.desactivar()
    cursor.desactivar()
    fondoPuntajes.desactivar()
    menuFinal.desactivar()
    puntuacionMngr.desactivar()
    tiempoMngr.desactivar()
    turnosMngr.desactivar()
    menuTuto.desactivar()
    sombra.desactivar()
    sonidosGlobales.detenerMusicaJuego()

    self.iniciar()
  }

  method habilitarReinicio() {reinicioHabilitado=true}
  method deshabilitarReinicio() {reinicioHabilitado=false}
  
  method paresTotales() = paresTotales
  method tipoDeJuego() = esSoloDibujos

  method juegoIniciado() = juegoIniciado //PARA TEST
  method paresEncontrados() = paresEncontrados//PARA TEST
}