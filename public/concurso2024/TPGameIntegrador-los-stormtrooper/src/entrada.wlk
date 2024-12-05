import wollok.game.*
import tituloJuego.*
import barraItems.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
import tablero.*
import fantasma.*
//import ritual.*
import musicaSonido.*

/*--INDICE--
  -inicio de panel
  -ubicar al personaje segun las puertas
  -identificador de habitacion

  -Objetos que se muestran en pantalla-
      puertas
      limites
      items
      textos
      inventario
      fantasmas */

object entrada {
  const property image = "fondoEntradaV8.png" 
  var property position = game.origin()
  
  //--musica--
  const musicaAmbiente = ambiente1
  method reproducirMusica() {
    musicaAmbiente.sonar()
    musicaAmbiente.loop()
  }

  method iniciar() {    
    //----------------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionEntrada)
    self.reproducirMusica()
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 
 
    //----------------------------------------------------------------Ubicaciones

    //--Puertas
    habitacion.ubicarEnTablero(puertaAComedor, 1, 4)
    habitacion.ubicarEnTablero(puertaAMusica, 10, 4)
    habitacion.ubicarEnTablero(escaleraAPrimerPiso, 5, 7)
    
    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 11)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 11, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 0, 0)//x min Izquierda

    //Textos
    habitacion.ubicarEnTablero(objNadaImportante, 3, 1)
    habitacion.ubicarEnTablero(objNadaSilla, 7, 9)
    habitacion.ubicarEnTablero(objEspejo, 2, 10)
    habitacion.ubicarEnTablero(objJarron, 4, 10)
    habitacion.ubicarEnTablero(objSillaRota, 8, 7)

    //--Items en Inventario
    barraItems.refreshListaDeItems()

    //--Items
    self.ubicacionDeLosItemsSegunElModo()  

    //--fantasmas
    game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 500))
    self.enModoDificil()

    
    //--Ubicacion del personaje segun de donde viene--
	  if(personaje.inicioDePartida())// ubicacion inicial
      habitacion.ubicarPersonaje(5, 1)
    else if(personaje.ubicacion() =="comedor")// volver del comedor
      habitacion.ubicarPersonaje(2, 4)
    else if(personaje.ubicacion() =="musica")// volver de musica
      habitacion.ubicarPersonaje(9, 4)
    else if(personaje.ubicacion() =="primerPiso")// volver de 1er piso
      habitacion.ubicarPersonaje(6, 6)
    //identificador de ubicacion del personaje 
    personaje.ubicacion("entrada")
  }

  method enModoDificil() {
    if(personaje.dificultad()==2){
      //game.addVisual(fantasmaPerseguidorEntrada1)
      game.addVisual(new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 300))
    }
  }

  method ubicacionDeLosItemsSegunElModo() {
    if(personaje.dificultad()==1){
      habitacion.ubicarUnKeyItem(itemNota3P2, 3, 9)
      
      if(itemNota3.enInventario())
        habitacion.ubicarEnTablero(objClavePolvo2, 3, 9) 
    }
    else{
      habitacion.ubicarUnKeyItem(itemDisco, 9, 9)
      
      if(itemLlaveCocina.enInventario())
        habitacion.ubicarUnKeyItem(itemGema4, 3, 2) 
    }
  }
}
