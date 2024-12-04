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
//import jardin.*
import tunel.*

object intro {
  const property image = "introduccionV4.png"
  const property position = game.origin() 
  var property activarSubMenu = false


  method iniciar() {
    activarSubMenu = true
    habitacion.borrarEscena()
    game.addVisual(self)
    //game.sound("titulo.mp3").play()
    //tituloM.sonar()//
    
    keyboard.space().onPressDo({
        if(activarSubMenu){
            //tituloM.stop()
            habitacion.borrarEscena()
            activarSubMenu = false
            
            entrada.iniciar()
            //tunel.iniciar() //pruebas
            //jardin.iniciar() //pruebas
        }})
  }
}



