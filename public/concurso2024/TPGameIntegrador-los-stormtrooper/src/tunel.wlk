//import entradaPrimerPiso.*
import puertas.*
import objetos.*
//import titulo.*
import personaje.*
import textos.*
//import entrada.*
//import wollok.game.*
import tablero.*
import barraItems.*
import musicaSonido.*
import ritual.*

object tunel {
  var property image = "fondoTunelV2.png" 
  var property position = game.origin()

  const musicaAmviente = salaTunel

  method reproducirMusica() {
    musicaAmviente.sonar()
    musicaAmviente.loop()
  }  

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionTunel)
    self.reproducirMusica()
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 
    
    //------------------------------------------------------estado del personaje

    ritual.estavencido(false)//desactiva el flag
    game.addVisual(katyCurse)
    katyCurse.animar()

    //------------------------------------------------------ubicacion objetos   
    //--puertas
    game.addVisual(puertaARitual)
    puertaARitual.ubicarEn(game.at(5,9))

    //--Items

    //Items en Inventario
    barraItems.refreshListaDeItems()

    //textos
    habitacion.ubicarEnTablero(objKatyCursed, 6, 7)

    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 10)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 7, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 4, 0)//x min Izquierda

    //--personaje
    personaje.ubicacion("tunel")
    habitacion.ubicarPersonaje(6, 1)
  }

}
object katyCurse {
  var property image = "katyFrente1V2.png"
  var property position = game.at(6, 7)
  var property contador=1  

  method animar() {
    game.onTick(500,"katyCurse",{self.animacion()})
  }

  method animacion() {
    if(contador !=2){
      contador += 1
      image = "katyFrente"+contador+"V2.png"
    }
    else{
      contador =1
      image = "katyFrente"+contador+"V2.png"
    }
  }
  method interaccion() {

  }
}