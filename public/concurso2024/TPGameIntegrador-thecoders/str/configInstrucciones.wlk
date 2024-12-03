import instrucciones.*
import config.*
import interfazJuego.*
import enemigo.*
object configInstrucciones {
  method comenzarJuego(){
      keyboard.c().onPressDo({
        instrucciones.cerrarInstrucciones()
      })
  }
}