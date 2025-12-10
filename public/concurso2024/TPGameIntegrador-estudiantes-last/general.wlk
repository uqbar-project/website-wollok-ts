import interfaz.*
import gameManager.*
import tableroYCartas.*
import wollok.game.*
import sonidosGlobales.*
import controladores.*
import highscores.*

object cursor {
  var property position = game.at(0,1)
  const image = "cursor.gif"
  var permitirAccion = true
  var keyboardActivo = false 
  var esFacil = true

  method iniciar() {game.addVisual(self) keyboardActivo=true}

  method desactivar() {
    keyboardActivo=false      
    comparador.desactivar()
    self.reiniciarAtributos()
    game.removeVisual(self)}

  method paralizarAccion() {permitirAccion = false}
  method reanudarAccion() {permitirAccion = true}

  method image() = image

  method reiniciarAtributos() {
    permitirAccion=true
    esFacil = true
    position = game.at(0,1)
    }

  //MOVIMIENTO y CONTROLES
  method iniciarControles() {
	  keyboard.left().onPressDo({if(keyboardActivo)self.moverseHaciaIzquierda()})
	  keyboard.right().onPressDo({if(keyboardActivo)self.moverseHaciaDerecha()})
	  keyboard.a().onPressDo({if(keyboardActivo)self.moverseHaciaIzquierda()})
	  keyboard.d().onPressDo({if(keyboardActivo)self.moverseHaciaDerecha()})    
  }

  method accionKeySpace() {
    if(keyboardActivo && permitirAccion) self.enviarCartaAComparador()
  }

  method accionKeyUp() {
    if(keyboardActivo)self.moverseHaciaArriba()
  }

  method accionKeyDown() {
    if(keyboardActivo)self.moverseHaciaAbajo()
  }

  method enviarCartaAComparador() {
    if(game.colliders(self).isEmpty()) {console.println("ESPACIO VACÍO")}else{
    comparador.procesarCarta(game.uniqueCollider(self))}}

  method moverseHaciaArriba() {
    if(self.position().y()==self.alturaSegunNivel()-1){self.position(game.at(self.position().x(), 1))
    }else{self.position(self.position().up(1))}
    sonidosGlobales.playCursor()}

  method moverseHaciaAbajo() {
    if(self.position().y()==1){self.position(game.at(self.position().x(), self.alturaSegunNivel() - 1))
    }else{self.position(self.position().down(1))}
    sonidosGlobales.playCursor()}

  method moverseHaciaIzquierda() {
    if(self.position().x() == 0){self.position(game.at(game.width() - 1, self.position().y()))
    }else{self.position(self.position().left(1))}
    sonidosGlobales.playCursor()}

  method moverseHaciaDerecha() {
    if(self.position().x() == game.width() - 1){self.position(game.at(0, self.position().y()))
    }else{self.position(self.position().right(1))}
    sonidosGlobales.playCursor()}

  method keyboardActivo() = keyboardActivo //PARA TEST
  method permitirAccion() = permitirAccion //PARA TEST

  method esDifFacil() {esFacil=true}
  method esDifNormal() {esFacil=false}

  method alturaSegunNivel() {if(esFacil){return game.height() -1} else {return game.height()}}
}

object comparador {
  var primerCarta = null
  var segundaCarta = null
  var tengoUnaCarta = false

  method desactivar() {self.reiniciarAtributos()}

  method procesarCarta(carta) {
    if(!tengoUnaCarta) {
      self.registarPrimerCarta(carta)
    } else {
      self.registrarSegundaCarta(carta)
    }
  }

  method registarPrimerCarta(unaCarta) {
      primerCarta = unaCarta
      tengoUnaCarta = true
      unaCarta.voltear()
  }

  method registrarSegundaCarta(unaCarta) {
    if(!unaCarta.esVisible()){
      segundaCarta = unaCarta
      tengoUnaCarta = false
      cursor.paralizarAccion()
      unaCarta.voltear()
      self.verificarPar()}
  }
  

  method verificarPar() {
    if(primerCarta.id() == segundaCarta.id()) {
      self.parCorrecto()} else {self.parIncorrecto()}
  }

  method parCorrecto() {
      cursor.paralizarAccion()
      sonidosGlobales.playCorrecto()
      puntuacionMngr.sumarPuntos()
      game.schedule(1200, { primerCarta.desactivar()
                            segundaCarta.desactivar()
                            gameManager.sumarParEncontrado()
                            cursor.reanudarAccion()
                            })
  }

  method parIncorrecto() {
      cursor.paralizarAccion()
      sonidosGlobales.playError()
      puntuacionMngr.restarPuntos()
      game.schedule(1600, { primerCarta.voltear()
                            segundaCarta.voltear()
                            cursor.reanudarAccion()
                            })
  }

  method reiniciarAtributos() {
    primerCarta=null 
    segundaCarta=null
    tengoUnaCarta=false}  

  method tengoUnaCarta() = tengoUnaCarta //PARA TEST
  method primerCarta() = primerCarta //PARA TEST
  method segundaCarta() = segundaCarta //PARA TEST
}



object paleta {
  const property verde = "009933FF"
  const property rojo = "FF0000FF"
  const property blanco = "FFFFFFFF"
  const property negro = "000000FF"
}

