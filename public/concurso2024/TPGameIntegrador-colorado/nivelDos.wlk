import protagonista.*
import objetos2.*
import objetos1.*
import enemigos.*
import configuracionTeclas.*
import sistema2.*
import nivelUno.*

object nivel2{
    const property image = "fondoNivel2v2.png" 
    const property position = game.origin()

    method iniciar() {
    game.clear()
    game.schedule(0, {sistema2.iniciarPantalla2()})
    game.addVisual(self)
    sistema2.reiniciar()
    sistema2.iniciarArma()
    sistema2.iniciarCuras()
    sistema2.iniciarPatos()
    sistema2.iniciarPuerta()
    sistema2.darleMovimientoAPatos()
    sistema2.aparecerLlave()
    game.addVisual(carlitos)
    teclado.config()
    game.onCollideDo(carlitos, {algo=>algo.interactuar()})
    }
}






