import protagonista.*
import objetos2.*
import objetos1.*
import enemigos.*
import configuracionTeclas.*
import sistema2.*

object nivel2Dificil{
    const property image = "fondoNivel2v2.png" 
    const property position = game.origin()

    method iniciar() {
    game.clear()   
    game.schedule(0, {sistema2.iniciarPantalla2D()})
    game.addVisual(self) 
    sistema2.reiniciar()
    sistema2.iniciarArmaD()
    sistema2.iniciarCuras()
    sistema2.iniciarPuerta()
    sistema2.iniciarPatoGigante()
    sistema2.aparecerLlave()
    sistema2.darleMovimientoPatoGigante()
    game.addVisual(carlitos)
    teclado.config()

    game.onCollideDo(carlitos, {algo=>algo.interactuar()})
    
    }
}


