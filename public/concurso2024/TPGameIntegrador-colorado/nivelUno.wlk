import objetos1.*
import protagonista.*
import sistema1.*
import configuracionTeclas.*

object nivel1 {
  const property image = "fondoNivel1v2.png"
  var property position = game.origin()

  // const llaveUno = new Llave()

  method iniciar() {
  game.clear()
  sistema.reiniciar()
  game.addVisual(self)
  sistema.iniciarAntorchas()
  sistema.iniciarCofre()
  sistema.iniciarPuerta()
  sistema.iniciarPista()
  game.addVisual(carlitos)
  teclado.config()
	game.onCollideDo(carlitos, {algo=>algo.interactuar()})
  }
}


