//import entradaPrimerPiso.*
import wollok.game.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
//import entrada.*
import barraItems.*
import tablero.*
import musicaSonido.*
import fantasma.*

object dormitorio {
  var property image = "fondoDormitorioV5.png" 
  var property position = game.origin()

  const musicaAmbiente = ambiente2

  method reproducirMusica() {
    musicaAmbiente.sonar()
    musicaAmbiente.loop()
  }

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionDormitorio)
    self.reproducirMusica()
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 


    //------------------------------------------------------ubicacion objetos    
    //--puertas
    habitacion.ubicarEnTablero(puertaABiblioteca, 5, 2)

    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 10)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 1)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 9, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 0, 0)//x min Izquierda

    //--Items
    self.ubicacionDeLosItemsSegunElModo() 

    //Items en Inventario
    barraItems.refreshListaDeItems()

    //textos
    habitacion.ubicarEnTablero(objClaveEspejo, 3, 9)
    habitacion.ubicarEnTablero(objClaveReloj, 2, 9)
    habitacion.ubicarEnTablero(objPuertaSinUso, 1,6)

    habitacion.ubicarEnTablero(txtAlfombra, 4,5)
    habitacion.ubicarEnTablero(txtSofa, 1,4)
    habitacion.ubicarEnTablero(txtMesitas, 8,2)
    //habitacion.ubicarEnTablero(textoHayAlgoPero, 7,5)
    
    //fantasmas
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 500))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 900))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1200))//op
    self.enModoDificil()
    
    //--personaje
    personaje.ubicacion("dormitorio")    
    habitacion.ubicarPersonaje(5, 3)

  }

  method enModoDificil() {
    if(personaje.dificultad()==2){
      game.addVisual(new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000))
    }
  }

  method ubicacionDeLosItemsSegunElModo() {
    if(personaje.dificultad()==1){
      habitacion.ubicarUnKeyItem(itemLlaveSotano, 8, 8)
      habitacion.ubicarEnTablero(objCofreDormi, 5, 8)
    }
    else{
      habitacion.ubicarUnKeyItem(itemLlaveSotano, 8, 8)
      habitacion.ubicarUnKeyItem(itemNota3, 3, 4)
      
      if(itemLlaveTerraza.enInventario())
        habitacion.ubicarUnKeyItem(itemGema1, 5, 8) 
    }
  }

}