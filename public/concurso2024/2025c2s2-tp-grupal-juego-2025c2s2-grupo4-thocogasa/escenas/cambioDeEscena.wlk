import wollok.game.*

object managerEscena {
  var property escenaActual = null
  
  method cargar(escena) {
    if (escenaActual != null) {escenaActual.ocultar()}
    
    
      escenaActual = escena
      escenaActual.mostrar()
    }

}

class Escena {
  var property visuales = []
  
  method mostrar()
  
  method ocultar(){
    visuales.forEach({v => if(game.hasVisual(v)) game.removeVisual(v)})
    game.boardGround(null)
    visuales.clear()
  }
}