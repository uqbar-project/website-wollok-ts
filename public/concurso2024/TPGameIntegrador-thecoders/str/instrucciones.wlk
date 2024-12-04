import marco.*
import config.*
import configInstrucciones.*
object instrucciones {
  const property position = game.at(0,0)
  const property image = "instrucciones-nuevo-disenio.png"
  var property estaCerrado = false
  
  method aparecerInstrucciones() {
    game.addVisual(self)
    configInstrucciones.comenzarJuego()
  }

  method cerrarInstrucciones() {
    if (!estaCerrado) {
      estaCerrado = true  
      game.removeVisual(self)
      juego.desPausar()
      juego.iniciarJuego()
      game.addVisual(marco)
    }
  }
}