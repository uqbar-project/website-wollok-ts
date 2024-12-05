import gameOver.*
import barraItems.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
//import wollok.game.*
import tablero.*
import fantasma.*
import entrada.*
import musicaSonido.*
import intro.*
import ritual.*

object tituloJuego {
  const property image = "tituloJuegoV4.png" 
  var property position = game.origin()
  
  var property activarMenu = true //activa o desactiva los botones del menu
  //var property activarSubMenu = false
  
  method iniciar() {  
    habitacion.borrarEscena()
    game.addVisual(self)
    //ritual.estavencido(false)///////////
    
    personaje.personajeVida(4)
    personaje.inicioDePartida(true)
    barraItems.ResetItemsDeInventario()
    activarMenu = true
    
    //boton-1 --> Modo Normal
    keyboard.num(1).onPressDo({if(activarMenu){
      game.sound("xfxSelect.mp3").play()
      activarMenu = false
      //activarSubMenu = true
      self.modoNormal()
      //self.intro()
    }})
    //boton-2 --> Modo Dificil
    keyboard.num(2).onPressDo({if(activarMenu){
      game.sound("xfxSelect.mp3").play()
      activarMenu = false
      //activarSubMenu = true
      self.modoDificil()
      //self.intro()
    }})

    //boton-3 -->Salir
    keyboard.num(3).onPressDo({if(activarMenu){game.stop()}})

    //boton 6 -->graficos Altos
    keyboard.num(6).onPressDo({if(activarMenu){
      personaje.graficosAltos(true)
      game.addVisual(graficosAltos)
      game.schedule(2000, {=> game.removeVisual(graficosAltos)})
    }})
    //boton 7 -->graficos Bajos
    keyboard.num(7).onPressDo({if(activarMenu){
      personaje.graficosAltos(false)
      game.addVisual(graficosBajos)
      game.schedule(2000, {=> game.removeVisual(graficosBajos)})
    }})
  }

  method interaccion() {  }//nada
  
  //--modo normal
  method modoNormal() { 
    personaje.dificultad(1)
    //game.schedule(1000, {=>self.intro()})
    game.schedule(500, {=>intro.iniciar()})
    //self.intro()
   }

  //--modo dificil
  method modoDificil() {
    personaje.dificultad(2)
    game.schedule(500, {=>intro.iniciar()})
    //game.schedule(1000, {=>self.intro()})
    //self.intro()
  }
}
//------------------------------------------------------------texto graficos
object graficosAltos {
  method text() = "Graficos Altos"
  const property position = game.at(9,0)
  method textColor() = "#ffffff"
}

object graficosBajos {
  method text() = "Graficos Bajos"
  const property position = game.at(9,0)
  method textColor() = "#ffffff"
}