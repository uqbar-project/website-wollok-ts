import barraItems.*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
//import wollok.game.*
import fantasma.*
//import ritual.*

/*--INDICE--Habitacion
  -siEstaEnInventario(unItem) muestra el item en la zona de inventario
  -iniciarHabitacion(unaUbicacion,textoUbicacion) Borra todo lo que estaba en la pantalla, inicia fondo y agrega el nombre a la zona
  -ubicarEnTablero(puertaA, x, y)
  -ubicarUnKeyItem(unItem, x, y)
  -ubicarPersonaje(x, y)
  -UbicarPersonajePuertasCant2(ubicacion1, x1, y1, x2, y2) --sin uso--
  -borrarTodo(unFondo) 
  */

object habitacion {
  
  //--metodos para borrar las escenas-----------------------------------------------
  var property listaDeVisualesEnEscena =[]

  method cargarListaconVisuales() {
    listaDeVisualesEnEscena = game.allVisuals()
  }

  method borrarTodaLaListaDeVisuales() {
    listaDeVisualesEnEscena.forEach({a=>game.removeVisual(a)})
  }
  method borrarEscena() {
    self.cargarListaconVisuales()
    self.borrarTodaLaListaDeVisuales()
  }

  //--metodos para cerrar las puertas al reiniciar el juego-------------------------
  const property listadePuertasAbiertas =[]

  method cargarListaconPuertas(unaPuerta) {
    listadePuertasAbiertas.add(unaPuerta)
  }
    method borrarListaconPuertas() {
    listadePuertasAbiertas.clear()
  }
  method cerrarPuertasAbiertas() {
    listadePuertasAbiertas.forEach({a=>a.cerrarPuerta()})
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  method siEstaEnInventario(unItem) {//ubicador de items inventario
    if(unItem.loTengo())
      game.addVisual(unItem)
  }

  method iniciarHabitacion(unaUbicacion,textoUbicacion) {//borra todo y carga el fondo
    
    //--borra la lista de escena y carga la visual del fondo--
    self.borrarEscena()
    game.addVisual(unaUbicacion)
    
    //--texto indicador de lugar--
    game.addVisual(textoUbicacion)
    barraDeVida.mostrarVidas()
  }

  method ubicarEnTablero(puertaA, x, y) {//ubica objetos en la pantalla
    game.addVisual(puertaA)
    puertaA.ubicarEn(game.at(x,y))
  }

  method ubicarUnKeyItem(unItem, x, y) {//ubica item que luego desaparecen
    if(!unItem.enInventario())
      game.addVisual(unItem)
      unItem.ubicarEn(game.at(x,y))
  }

  method ubicarPersonaje(x, y) {//ubica al personaje 
      game.addVisual(personaje)//Character
      personaje.irA(game.at(x,y))
  }
}