/*
import puertas.*
import objetos.*
import titulo.*
import personaje.*
import textos.*
import wollok.game.*
*/

object barraItems {
  const property listaDeItems = []
  const property listaDeEstadosDeItems =[]

  method agregarAlaLista(unItem,itemEstado) {
    listaDeItems.add(unItem)
    listaDeEstadosDeItems.add(itemEstado)
  }
  method mostrarListaDeItems() {
    listaDeItems.forEach({a=>game.addVisual(a)})
  }
  method esconderListaDeItems() {
    listaDeItems.forEach({a=> game.removeVisual(a)})
  }
  method ResetItemsDeInventario() {
    listaDeEstadosDeItems.forEach({a=>a.enInventario(false)})
    listaDeEstadosDeItems.clear()
    listaDeItems.clear()
  }

  method refreshListaDeItems() {
    self.esconderListaDeItems()
    self.mostrarListaDeItems()
  }
}