import wollok.game.*
import puertas.*
import objetos.*
//import titulo.*
import personaje.*
import textos.*
import entrada.*
import barraItems.*
import tablero.*
import fantasma.*
import musicaSonido.*

object comedor {
  var property image = "fondoComedorV5.png" 
  var property position = game.origin()

  const musicaAmbiente = ambiente1

  method reproducirMusica() {
    musicaAmbiente.sonar()
    musicaAmbiente.loop()
  }

  method iniciar() {
    //-------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionComedor)
    self.reproducirMusica()
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 

    //-------------------------------------estado del personaje
    personaje.inicioDePartida(false)//

    //-------------------------------------Ubicaciones
    //--puertas
    habitacion.ubicarEnTablero(puertaAEntrada, 10, 4)
    habitacion.ubicarEnTablero(puertaACocina, 3, 10)

    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 11)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 11, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 0, 0)//x min Izquierda

    //--Items
    self.ubicacionDeLosItemsSegunElModo()

    //Textos
    habitacion.ubicarEnTablero(objComida, 4, 6)
    habitacion.ubicarEnTablero(objRoto, 10, 7)
    habitacion.ubicarEnTablero(objCuadro, 1, 10)
    habitacion.ubicarEnTablero(objPlanta, 2, 9)

    habitacion.ubicarEnTablero(txtLamparas, 10, 1)
    habitacion.ubicarEnTablero(txtTv, 1, 5)
    habitacion.ubicarEnTablero(txtRadio, 1, 2)
    habitacion.ubicarEnTablero(txtSofa, 8, 9)    

    //Items en Inventario
    barraItems.refreshListaDeItems()

    //fantasmas
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 500))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800))
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000))
    self.enModoDificil()
    
    //--Ubicacion del personaje segun ekl lugar
    if(personaje.ubicacion() =="entrada")// desde la entrada
      habitacion.ubicarPersonaje(9, 4)
    else//desde cocina
      habitacion.ubicarPersonaje(3, 9)
    //identificador de ubicacion del personaje 
    personaje.ubicacion("comedor")
  }

  method enModoDificil() {
    if(personaje.dificultad()==2){
      game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000))
      game.addVisual(new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000))
    }
  }

  method ubicacionDeLosItemsSegunElModo() {
    if(personaje.dificultad()==1){
      habitacion.ubicarUnKeyItem(itemLlaveTerraza, 6, 5)
      habitacion.ubicarUnKeyItem(itemLlaveDormi, 5, 9)
    }
    else{
      habitacion.ubicarUnKeyItem(itemLlaveDormi, 5, 9)
      habitacion.ubicarUnKeyItem(itemLlaveMusica, 1, 8)
      habitacion.ubicarUnKeyItem(itemNota2, 2, 2)
    }
  }
}