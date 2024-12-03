//import entradaPrimerPiso.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
//import entrada.*
import wollok.game.*
import tablero.*
import musicaSonido.*
import barraItems.*

object jardin {
  var property image = "fondoJardinV5.png" 
  var property position = game.origin()

  const musicaAmviente = salaJardin

  method reproducirMusica() {
    musicaAmviente.sonar()
    musicaAmviente.loop()
  }  

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self, ubicacionJardinTrasero)
    self.reproducirMusica()
    //------------------------------------------------------estado del personaje
    //personaje.ubicacion(11)

    //------------------------------------------------------ubicacion objetos
    //--Katy
    game.addVisual(katyLast)
    katyLast.animar()

    //--puertas

    //--Items
    
    //Items en Inventario
    barraItems.refreshListaDeItems()

    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 7)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 6, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 4, 0)//x min Izquierda
    
    //--personaje
    habitacion.ubicarPersonaje(5, 1)
  }
}

object katyLast {
  var property image = "katyLado1.png"
  var property position = game.at(5, 6)
  var property contador=1  

  method animar() {
    game.onTick(500,"katyCurse",{self.animacion()})
  }

  method animacion() {
    if(contador !=2){
      image = "katyLado"+contador+".png"
      contador += 1
    }
    else{
      image = "katyLado"+contador+".png"
      contador =1
    }
  }
  method interaccion() {
    game.addVisual(fraseFinal)
    game.schedule(11000, {=>
      game.removeVisual(fraseFinal)
      game.addVisual(fraseEnd)
      self.eresMillonario()
      })
    game.schedule(14000, {=>game.stop()})
  }

  method eresMillonario() {
    if(self.tengoTodasLasGemas())
      game.addVisual(fraseGemas)
  }

  method tengoTodasLasGemas() {
    return itemGema1.enInventario() && itemGema2.enInventario() && itemGema3.enInventario() && itemGema4.enInventario() && itemGema5.enInventario() && itemGema6.enInventario()
  }
}

object fraseFinal {
  method position() = game.at(5,8)
  method textColor() = "#ffffff"

  method text() = " Katyyy!! 
        Estas aquí! Pudiste escapar también!...

        ...Volvamos a casa...
        El sótano se derrumbo, 
        ya no hay nada que temer.."
}
object fraseEnd {
  method position() = game.at(5,8)
  method textColor() = "#ffffff"

  method text() =           "FIN
        ¡¡Muchas Gracias por Jugar!!"
}
object fraseGemas {
  method position() = game.at(5,3)
  method textColor() = "#ffffff"

  method text() =           "Felicitaciones!!
  No solo escapaste con vida 
  sino que ahora eres millonario!!
  Buen trabajo!!"
}