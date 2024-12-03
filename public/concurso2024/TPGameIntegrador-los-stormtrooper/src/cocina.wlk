import wollok.game.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
import entrada.*
import barraItems.*
import tablero.*
import musicaSonido.*
import fantasma.*

object cocina {
  var property image = "fondoCocinaV3.png" 
  var property position = game.origin()

  const musicaAmbiente = ambiente1

  method reproducirMusica() {
    musicaAmbiente.sonar()
    musicaAmbiente.loop()
  }

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionCocina)
    self.reproducirMusica() 
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 


    //------------------------------------------------------ubicacion objetos

    //--Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 10)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 11, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 1, 0)//x min Izquierda

    //--puertas
    habitacion.ubicarEnTablero(puertaAComedor, 4, 1)
    habitacion.ubicarEnTablero(puertaATunel, 9, 7)

    //--Items
    self.ubicacionDeLosItemsSegunElModo()

    //--Items en Inventario
    barraItems.refreshListaDeItems()
  
    //--Textos
    habitacion.ubicarEnTablero(objComida, 5, 6)
    habitacion.ubicarEnTablero(objReloj, 8, 9)
    habitacion.ubicarEnTablero(objSillaRota, 5, 3)

    habitacion.ubicarEnTablero(txtHeladera, 3, 8)
    habitacion.ubicarEnTablero(txtCocina, 5, 8)
    habitacion.ubicarEnTablero(txtPolvoPiso, 7, 3)

    //--fantasmas
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 500))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1400))
    self.enModoDificil()
    
    //--personaje
    personaje.ubicacion("cocina")
    habitacion.ubicarPersonaje(4, 2)
  }

  method enModoDificil() {
    if(personaje.dificultad()==2){
      game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000))
      game.addVisual(new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000))
    }
  }

  method ubicacionDeLosItemsSegunElModo() {
    if(personaje.dificultad()==1){
      habitacion.ubicarUnKeyItem(itemNota2, 9, 2)
      habitacion.ubicarUnKeyItem(itemPolvoEstrellas, 7, 8)
    }
    else{
      habitacion.ubicarUnKeyItem(itemNota3P2, 2, 8)

      if(itemLlaveMusica.enInventario())
        habitacion.ubicarUnKeyItem(itemGema2, 10, 7)

    }
  }
}