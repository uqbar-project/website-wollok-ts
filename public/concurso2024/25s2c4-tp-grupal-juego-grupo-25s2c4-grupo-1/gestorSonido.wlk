import wollok.game.*
import niveles.*
object gestorSonido {
    const musicaDelJuego = game.sound("musicaNivel1.mp3")
    const musicaDelMenu = game.sound("sundMenu.mp3")
//*==========================| Musica |==========================

    method musicaNivelUno () {
        musicaDelJuego.shouldLoop(true)
		game.schedule(500, { musicaDelJuego.play()} )
        musicaDelJuego.volume(0.5)
    }
    method musicaDelJuegoDetener() {
        // precondicion la musica debe estar sonando
        musicaDelJuego.stop()
    }
    method musicaMenu(){
        musicaDelMenu.shouldLoop(true)
		game.schedule(500, { musicaDelMenu.play()} )
        musicaDelMenu.volume(0.2)
    }
    method musicaMenuDetener() {
        // precondicion la musica debe estar sonando
        musicaDelMenu.stop()
    }
    method quitaMusicaSiJuegoAunNoTermino() {
      if(not gestorNiveles.seTermino()){
        self.musicaDelJuegoDetener()
      }
    }


//*==========================| Sonido |==========================

    method sonidoBoton() {
      game.sound("boton.mp3").play()
    }
    method sonidoCruzarPuerta() {
      game.sound("cruzar_puerta.mp3").play()
    }
    method sonidoFraseFormada() {
      game.sound("seFormaFrase.mp3").play()
    }
    method sonidoDerrota(){
      game.sound("sonidoDerrota.mp3").play()   
    }
    method sonidoVictoria(){
      game.sound("sonidoVictoria.mp3").play()
    }


  
}