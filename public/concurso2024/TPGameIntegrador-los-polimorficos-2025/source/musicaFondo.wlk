import objetos.*

object musicaFondo {
  var property musicaFondo = null
  var pista = null
  var loop = true
  var property volumen = 0.25
  
  method iniciar(unaPista) {
    if (unaPista != null) {
      self.detener()
      loop = true
      if (!self.seEstaReproduciendo(unaPista)) {
        musicaFondo = game.sound(unaPista.cancion())
        pista = unaPista
        volumen = unaPista.volumen()
        loop = unaPista.loop()
      }

      musicaFondo.play()
      musicaFondo.shouldLoop(loop)
      musicaFondo.volume(volumen)
    }
      }
  
  method cambiarAPista(unaPista) {
    if (unaPista != null) self.iniciar(unaPista)
  }
  
  method detener() {
    if (pista != null) {
      musicaFondo.stop()
      pista = null
      musicaFondo = null
    }
  }

  method pausar() {
    if (musicaFondo != null) {
      musicaFondo.pause()
    }
  }
  method reanudar() {
    if (musicaFondo != null) {
      musicaFondo.resume()
    }
  }
  method reestablecerPista(){ pista= null }
  method seEstaReproduciendo(num) = pista == num
}


