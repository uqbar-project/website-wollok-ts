import configInstrucciones.*
import instrucciones.*
import configInterfaz.*
import personajes.*
import marco.*
import config.*

object interfaz {
  const property position = game.at(0,0)
  const property image = "selecciona-dificultad.png"
  
  method aparecerInterfaz() {
    game.addVisual(self)
    game.removeVisual(marco)
  }

  method cerrarInterfaz() {
    // Cierra la interfaz para seleccionar dificultad y abre las instrucciones
    game.removeVisual(self)
    instrucciones.aparecerInstrucciones()
  }
}