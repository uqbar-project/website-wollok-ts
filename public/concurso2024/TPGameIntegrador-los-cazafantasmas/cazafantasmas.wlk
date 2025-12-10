import nivel1.*
import puntaje.*
import controles.*
import wollok.game.*
import fantasma.*
import niveles.*
import nivel2.*

// los cazafantasmas que van a ser enemigos
class Cazafantasma {
  var position = game.at(0, 0)
  var image = "cazafantasmas.png"
  var nivelActual
  method esInteractivo() = true
  // el jugador puede interactuar (o sea pueden colisionar)
  
  method image() = image
  
  method image(nueva) {
    image = nueva
  }
  
  method position() = position
  
  method position(nueva) {
    position = nueva
  }
  
  method asustarse(jugador) {}
  
  method esCazador() = true
  
  method instanciar(posicion, cantidad) {
    // crea al cazador
    self.image("cazafantasmas.png")
    self.position(posicion)
  }
  
  // hace daño al jugador y le resta puntos
  method atrapar(jugador) {
		jugador.recibirDaño(puntaje.puntosCazador())
        if(self.position()== grimly.position() ){   //si el cazador esta en la posicion inicial del fantasma, retrocede 3 celdas
            self.position(game.at(14, 4))
        }
	}
    method actualizarNivelActual(nivel){
    nivelActual=nivel
  }

  method accionarObjeto(objeto) {}
  
  method recibirDaño(cant) {}
  
  method acercarseA(jugador) { // inicia el ciclo de persecución automático (ejecutando la lógica cada 500ms).
    self.intentarMoverseHacia(jugador)
    game.schedule(700, { self.acercarseA(jugador) })
  }
  
  method intentarMoverseHacia(jugador) {
    // calcula la diferencia absoluta para decidir qué eje priorizar.
    const diferenciaX = (self.position().x() - jugador.position().x()).abs()
    const diferenciaY = (self.position().y() - jugador.position().y()).abs()
    
    // prioriza el eje donde la diferencia es mayor.
    if (diferenciaX > diferenciaY) {
        self.intentarMover(self.proximaPosicionHorizontal(jugador))
    }
    else {
        self.intentarMover(self.proximaPosicionVertical(jugador))
    }
  }
  
  method intentarMover(nuevaPosicion) {
    const esValida = invalida.noEsPosicionInvalida(nuevaPosicion.x(),nuevaPosicion.y()) && self.noHayOtroCazador(nuevaPosicion)
    if (esValida) {
        self.position(nuevaPosicion)
    }
  }
  
  method proximaPosicionHorizontal(unElemento) = 
    if (unElemento.position().x() > self.position().x()){
        self.position().right(1)
    }
    else {
        self.position().left(1)
    }
  
  method proximaPosicionVertical(unElemento) = 
    if (unElemento.position().y() > self.position().y()){
        self.position().up(1)
    }
    else {
        self.position().down(1)
    }
  //methodo para evitar que losc azadores esten siempre en la misma posicion
  method noHayOtroCazador(nuevaPosicion) = game.getObjectsIn(game.at(nuevaPosicion.x(), nuevaPosicion.y())).count({ o => o.esCazador() }) < nivelActual.cantEnemigos() 
}