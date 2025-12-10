import protagonista.*
import sistema1.*
import wollok.game.*
import configuracionTeclas.*

object nivel1D {
  const property image = "fondoNivel1v2.png"
  var property position = game.origin()

  // const llaveUno = new Llave()

  method iniciar() {
  game.clear()
  game.addVisual(self)
  sistema.reiniciar()
  sistema.iniciarAntorchasNivelDificil()
  sistema.iniciarCofre()
  sistema.iniciarPuertaD()
  sistema.iniciarPistaDificil()
  game.addVisual(carlitos)
  teclado.config()
	game.onCollideDo(carlitos, {algo=>algo.interactuar()})
  }
}