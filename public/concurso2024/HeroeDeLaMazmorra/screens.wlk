import nivelManager.*
import nivel1.*
import nivel2.*

object menuInicial {
  method image() = "fondoMenu.png"
  
  method position() = game.at(0, 0)
  
  method setup() {

    if(game.hasVisual(self)){
      game.removeVisual(self)
      game.addVisual(self)
    } else {
      game.addVisual(self)
    }

    if(game.hasVisual(bordeMenu)){
      game.removeVisual(bordeMenu)
      game.addVisual(bordeMenu)
    } else {
      game.addVisual(bordeMenu)
    }

    if(game.hasVisual(titulo)){
      game.removeVisual(titulo)
      game.addVisual(titulo)
    } else {
      game.addVisual(titulo)
    }

    if(game.hasVisual(btnIniciar)){
      game.removeVisual(btnIniciar)
      game.addVisual(btnIniciar)
    } else {
      game.addVisual(btnIniciar)
    }

    if(game.hasVisual(helpKey)){
      game.removeVisual(helpKey)
      game.addVisual(helpKey)
    } else {
      game.addVisual(helpKey)
    }

    keyboard.enter().onPressDo({ nivel1.setup() })
    helpScreen.activarInput()
  }
  
  method removeElements() {
    if(game.hasVisual(self)) game.removeVisual(self) // fondoMenu.png
    if(game.hasVisual(bordeMenu)) game.removeVisual(bordeMenu)
    if(game.hasVisual(titulo)) game.removeVisual(titulo)
    if(game.hasVisual(btnIniciar)) game.removeVisual(btnIniciar)
    if(game.hasVisual(helpKey))game.removeVisual(helpKey)
  }
}

object titulo {
  var posicion = game.at(8, 3)
  
  method image() = "tituloMenu.png"
  
  method position() = posicion
  
  method pantallaFinal() {
    posicion = game.at(2, 3)
  }

  method menuInicial() {
    posicion = game.at(8, 3)
  }
}

object btnIniciar {
  method image() = "botonJugar.png"
  
  method position() = game.at(8, -1)
}

object helpKey {

  method image() = "helpKey.png"
  
  method position() = game.at(1, 0)
}

object helpScreen {
  method mostrarseYOcultarse(){
    if(!game.hasVisual(self) and !game.hasVisual(gameOver)){
      game.addVisual(helpScreenBg) 
      game.addVisual(self)
      nivelManager.pausarJuego()
    } else if(!game.hasVisual(gameOver)){
      game.removeVisual(helpScreenBg) 
      game.removeVisual(self)
      nivelManager.reanudarJuego()
    }
  }

  method activarInput(){
    keyboard.h().onPressDo({ self.mostrarseYOcultarse() })
  }

  var instanciaActual = 0

  method reiniciarInstancia(){
    instanciaActual = 0
    imagen = "helpScreenLvl" + instanciaActual +".png"
  }

  method instanciaActual() = instanciaActual

  method cambiarInstanciaA(unaInstancia){
    instanciaActual = unaInstancia
    imagen = "helpScreenLvl" + instanciaActual +".png"
  }

  var imagen = "helpScreenLvl" + instanciaActual +".png"
  method image() = imagen

  var position = game.at(16, 2)
  
  method position() = position

  method posicionNiveles(){
    position = game.at(8, 2)
  }

  method reiniciarPosicion(){
    position = game.at(16, 2)
  }
}

object helpScreenBg {
  method image() = "helpScreenBg.png"
  
  method position() = game.at(0, 0)
}

object bordeMenu {
  method image() = "bordeMenu.png"
  
  method position() = game.at(0, 0)
}

object fondoNivel1 {
  method esHostil() = false
  
  method esLaPuertaAlNivel2() = false
  
  method image() = "fondoNivel1.png"
  
  method position() = game.at(0, 0)
}

object fondoNivel2 {
  method esHostil() = false
  
  method esLaPuertaAlNivel2() = false
  
  method esLaPuertaFinal() = false
  
  method esPicoCorrupto() = false
  
  method image() = "fondoNivel2.png"
  
  method position() = game.at(0, 0)
}

object cartelNivel1 {
  method esHostil() = false
  
  method esLaPuertaAlNivel2() = false
  
  method image() = "cartelNivel1.png"
  
  method position() = game.at(11, 0)
}

object cartelNivel2 {
  method esHostil() = false
  
  method esLaPuertaAlNivel2() = false
  
  method esPicoCorrupto() = false
  
  method image() = "cartelNivel2.png"
  
  method position() = game.at(11, 0)
}

object gameOver {
  method esHostil() = false
  method esLaPuertaAlNivel2() = false
  
  method image() = "gameOver.png"
  
  method position() = game.at(9, 5)
}

object fondoEscape {
  method esHostil() = false
  
  method esLaPuertaAlNivel2() = false
  
  method image() = "fondoEscape.png"
  
  method position() = game.at(0, 0)
}

object menuKey {
  method image() = "menuKey.png"
  method esHostil() = false
  method esLaPuertaAlNivel2() = false
  method esLaPuertaFinal() = false
  method esPicoCorrupto() = false
  
  var position = game.at(10, 2)
  method position() = position

  method pantallaFinal() {
    position = game.at(19, 1)
  }

  method menuInicial() {
    position = game.at(10, 2)
  }
}