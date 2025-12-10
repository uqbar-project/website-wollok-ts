import wollok.game.*
import personaje.*
import obstaculos.*
import niveles.*
import partida.*

object menu {
  const botones = [botonIniciar, botonInstrucciones, botonCreditos, botonSalir]
  const sonido = game.sound("paperboy_main_theme.mp3")
  const position = game.origin()
  
  method image() = "fondoMenu.png"

  method position() = position

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method mutearSonido() {
    sonido.volume(0)
  }

  method desmutearSonido() {
    sonido.volume(1)
  }

  method sonidoOn() {
    sonido.play()
    sonido.shouldLoop(true)
  }
  
  method sonidoOff() {
    sonido.stop()
  }
  
  method renderizarBotones() {
    botones.forEach({ b => game.addVisual(b) })
  }
  
  method limpiarBotones() {
    botones.forEach({ b => game.removeVisual(b) })
  }

  method iniciar() {
    self.sonidoOn()
    self.renderizarFondo()
    self.renderizarBotones()
    self.configurarTeclas()
    controladorDeTeclas.activarTodas()
  }

  method detener() {
    self.sonidoOff()
    self.limpiarBotones()
    self.limpiarFondo()
    controladorDeTeclas.desactivarTodas()
  }
  
  method configurarTeclas() {
    keyboard.u().onPressDo( { if (u.activo()) { botonIniciar.realizarAccion(self) self.detener() } })
    keyboard.i().onPressDo({ if (i.activo()) botonInstrucciones.realizarAccion(self) })
    keyboard.o().onPressDo({ if (o.activo()) { self.mutearSonido() botonCreditos.realizarAccion(self) } })
    keyboard.p().onPressDo({ if (p.activo()) { self.sonidoOff() game.schedule(150, { botonSalir.realizarAccion(self) }) } }) 
    // el game.schedule es para que con un mínimo delay, efectue la accion de game.stop(). De esta forma, el sonido deja de sonar.
  }
  
}

object botonIniciar {
  const position = game.at(3, 8)
  
  method image() = "btn_iniciar.png"
  
  method position() = position
  
  method realizarAccion(unMenu) {
    partida.iniciar()
  }
}

object botonInstrucciones {
  const position = game.at(3, 6)
  
  method image() = "btn_como_jugar.png"
  
  method position() = position
  
  method realizarAccion(unMenu) {
    menuInstrucciones.iniciar()
  }
}

object botonCreditos {
  const position = game.at(3, 4)
  
  method image() = "btn_creditos.png"
  
  method position() = position
  
  method realizarAccion(unMenu) {
    menuCreditos.iniciar()
  }
}
/*
  Se creo una clase abstracta para "Boton Volver" y objetos que heredan de esta clase.
  Pense en que el metodo "realizarAccion" tenga el metodo "unMenu.detener()" y hacer el override en cada objeto utilizando el super() + su acción puntual.
  El tema de esto es que la clase, por el momento no quedaria abstracta y no me gusta (Por mas que nunca instanciemos algo de dicha clase)
*/
class BotonVolver {

  const position = game.at(3, 2)

  method image() = "btn_volver.png"

  method position() = position

  method realizarAccion(unMenu)

}

object botonVolverCreditos inherits BotonVolver() {

  override method realizarAccion(unMenu) {
    unMenu.detener()
    menu.desmutearSonido()
  }

}

object botonVolverInstrucciones inherits BotonVolver() {

  override method realizarAccion(unMenu) {
    unMenu.detener()
  }
}

object botonVolverPausa inherits BotonVolver() {

  override method realizarAccion(unMenu) {
    unMenu.detener()
  }
}

object botonSalir {
  
  const position = game.at(3, 2)
  
  method image() = "btn_salir.png"
  
  method position() = position
  
  method realizarAccion(unMenu) {
    menuSalir.iniciar()
    game.stop()
  }
}

object botonGameOver {

  const position = game.at(3, 2)
  
  method image() = "btn_reiniciar.png"
  
  method position() = position
  
  method realizarAccion(unMenu) {
    menuGameOver.detener()
    menu.iniciar()
  }
}

object menuGameOver {
  const position = game.origin()

  const sonido = game.sound("gta_game_over.mp3")

  var property activo = false

  method image() = "fondo_GameOver.png"

  method position() = position

  method sonidoOn() {
    sonido.play()
  }
  
  method sonidoOff() {
    sonido.stop()
  }

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method renderizarBotones() {
    game.addVisual(botonGameOver)
  }
  
  method limpiarBotones() {
    game.removeVisual(botonGameOver)
  }

  method iniciar() {
    self.activo(true)
    self.renderizarFondo()
    self.sonidoOn()
    self.renderizarBotones()
    self.configurarTeclas()
  }

  method detener() {
    self.activo(false)
    self.limpiarBotones()
    self.limpiarFondo()
    self.sonidoOff()
  }

  method configurarTeclas() {
    keyboard.m().onPressDo({ if (activo) botonGameOver.realizarAccion(self) })
  }
}

object menuCreditos {
  
  const position = game.origin()

  const sonido = game.sound("innerlogic.mp3")

  var property activo = false

  method image() = "menu_creditos_dev.png"
  
  method position() = position

  method sonidoOn() {
    sonido.play()
  }
  
  method sonidoOff() {
    sonido.stop()
  }

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method renderizarBotones() {
    game.addVisual(botonVolverCreditos)
  }
  
  method limpiarBotones() {
    game.removeVisual(botonVolverCreditos)
  }

  method iniciar() {
    controladorDeTeclas.desactivarTodas()
    self.activo(true)
    self.renderizarFondo()
    self.sonidoOn()
    self.renderizarBotones()
    self.configurarTeclas()
  }

  method detener() {
    self.activo(false)
    self.limpiarBotones()
    self.limpiarFondo()
    self.sonidoOff()
    controladorDeTeclas.activarTodas()
  }

  method configurarTeclas() {
    keyboard.v().onPressDo({ if (activo) botonVolverCreditos.realizarAccion(self) })
  }

}

object menuInstrucciones {

  const position = game.origin()

  var property activo = false

  method image() = "menu_instrucciones_final.png"
  
  method position() = position

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method renderizarBotones() {
    game.addVisual(botonVolverInstrucciones)
  }
  
  method limpiarBotones() {
    game.removeVisual(botonVolverInstrucciones)
  }

  method iniciar() {
    controladorDeTeclas.desactivarTodas()
    self.activo(true)
    self.renderizarFondo()
    self.renderizarBotones()
    self.configurarTeclas()
  }

  method detener() {
    self.activo(false)
    self.limpiarBotones()
    self.limpiarFondo()
    controladorDeTeclas.activarTodas()
  }

  method configurarTeclas() {
    keyboard.v().onPressDo({ if (activo) botonVolverInstrucciones.realizarAccion(self) })
  }

}

object menuPausa {

  const position = game.origin()

  var property activo = false

  var imgActual = "sin_imagen.png"

  method actualizarImgActual(imagen) {
    imgActual = imagen
  }
  method image() = imgActual

  method position() = position

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method renderizarBotones() {
    game.addVisual(botonVolverPausa)
  }
  
  method limpiarBotones() {
    game.removeVisual(botonVolverPausa)
  }

  method iniciar() {
    partida.pausaActiva(true)
    partida.mutearSonido()
    partida.limpiarTicks()
    self.activo(true)
    self.renderizarFondo()
    self.renderizarBotones()
    self.configurarTeclas()
  }

  method detener() {
    self.activo(false)
    self.limpiarBotones()
    self.limpiarFondo()
    partida.pausaActiva(false)
    partida.desmutearSonido()
    partida.cargarTicks()
  }

  method configurarTeclas() {
    keyboard.v().onPressDo({ if (activo) botonVolverPausa.realizarAccion(self) })
  }
  
}

object menuSalir {

  const position = game.origin()

  method image() = "menu_salir.png"
  
  method position() = position

  method renderizarFondo() {
    game.addVisual(self)
  }

  method limpiarFondo() {
    game.removeVisual(self)
  }

  method renderizarBotones() {}
  
  method limpiarBotones() {}

  method iniciar() {
    self.renderizarFondo()
  }

  method detener() {}

  method configurarTeclas() {}
}

//Este es el controlador de teclas para el main menu
object controladorDeTeclas {

  const teclas = [u,i,o,p]

  method desactivarTodas() {
    teclas.forEach({ t => t.activo(false) })
  }

  method activarTodas() {
    teclas.forEach({ t => t.activo(true) })
  }

  method activarTecla(unaTecla) {
    unaTecla.activo(true)
  }

  method desactivarTecla(unaTecla) {
    unaTecla.activo(false)
  }

}

object u {
  var property activo = true
}

object i {
  var property activo = true
}

object p {
  var property activo = true
}

object o {
  var property activo = true
}