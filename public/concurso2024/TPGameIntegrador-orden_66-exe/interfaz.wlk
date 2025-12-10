import wollok.game.*
import colores.*
import wollokDice.*
import imagenes.*
import sonidos.*
import Puntuacion.*

object interfaz {
  var nivel = 1
  var dificultad = "facil"
  const opciones = [rojo, azul, verde, amarillo]
  const property secuencias = []
  const sucuenciasJugador = []
  const puntuaciones = [] //lista de puntajes
  var ingresarNombre = false
  var property puntuacion = new Puntaje()
  const property ubicacionLetras = [8, 10, 12]
  
  method nivel() = nivel
  
  method opciones() = opciones
  
  method setDificultad(unaDificultad) {
    dificultad = unaDificultad
  }
  
  method prepararNivelInicial() {
    nivel = if (dificultad == "dificil") 4 else 1
    secuencias.clear()
    sucuenciasJugador.clear()
  }
  
  method secuenciaArealizar() {
    if (secuencias.size() < nivel) {
      secuencias.add(opciones.randomized().first())
      return self.secuenciaArealizar()
    }
    return secuencias
  }
  
  method subirDeNivel() {
    nivel += 1
    sucuenciasJugador.clear()
  }
  
  method addSecuenciaJugador(unColor) {
    if (wollokDice.flechas()) {
      const inputSound = new InputSound()
      self.removeImages([tuTurno])
      self.agregarColorYMostrar(unColor)
      sonido.ejecutar(inputSound)
      self.resolverJugada(inputSound)
    }
  }
  
  method resolverJugada(inputSound) {
    if (self.esJugadaPerdedora()) {
      if (sonido.enEjecucion(inputSound)) sonido.detener(inputSound)
      self.perder()
    } else {
      puntos.sumarPuntaje(self.puntajeASumar())
      if (self.ultimaJugada()) {
        self.subirDeNivel()
        game.schedule(500, { wollokDice.continuarGame() })
      }
    }
  }
  
  method puntajeASumar() = if (dificultad == "dificil") 1 else 2
  
  method agregarColorYMostrar(unColor) {
    unColor.mostraryOcultar()
    sucuenciasJugador.add(unColor)
  }
  
  method esJugadaPerdedora() = secuencias.take(
    sucuenciasJugador.size()
  ) != sucuenciasJugador
  
  method perder() {
    wollokDice.ocultarFlechas()
    if (self.esHighScore()) self.mostrarPantallaHightScore()
    else self.mostrarPantallaPerdio()
    wollokDice.perdio()
  }
  
  method esHighScore() = (puntos.valor() > 0) && ((puntuaciones.size() < 4) || self.esMayorPuntuacion())
  
  method esMayorPuntuacion() = puntuaciones.any(
    { p => p.total() < puntos.valor() }
  )
  
  method mostrarPantallaPerdio() {
    game.addVisual(perdiste)
  }
  
  method mostrarPantallaHightScore() {
    ingresarNombre = true
    game.addVisual(highScoreImage)
    puntuacion = new Puntaje()
    game.addVisual(puntuacion.getLetra(0))
    game.addVisual(puntuacion.getLetra(1))
    game.addVisual(puntuacion.getLetra(2))
    objCursor.titilar()
    game.addVisual(space)
  }
  
  method cambiarUnaLetra(operacion) {
    if (ingresarNombre) {
      if (operacion == "restar") puntuacion.getLetra(
          objCursor.letraActual()
        ).disminuirLetra()
      else puntuacion.getLetra(objCursor.letraActual()).aumentarLetra()
    }
  }
  
  method cambiarCursor(operacion) {
    if (ingresarNombre) {
      game.removeTickEvent("cursor")
      objCursor.ocultar()
      if (operacion == "der") {
        objCursor.aumentarLetra()
        objCursor.reubicar(ubicacionLetras.get(objCursor.letraActual()), 4.5)
        objCursor.titilar()
      } else {
        objCursor.disminuirLetra()
        objCursor.reubicar(ubicacionLetras.get(objCursor.letraActual()), 4.5)
        objCursor.titilar()
      }
    }
  }
  
  method despuesDelNombre() {
    if (ingresarNombre) {
      ingresarNombre = false
      game.removeVisual(space)
      game.removeTickEvent("cursor")
      objCursor.reiniciar()
      objCursor.reubicar(ubicacionLetras.get(0), 4.5)
      objCursor.ocultar()
      
      self.asignarPuntuacionNueva()
      
      self.reiniciar()
      self.mostrarHighScore()
    }
  }
  
  method asignarPuntuacionNueva() {
    puntuacion.getPunto(0).cambiarNumero(puntos.puntuacion().get(3).numero())
    puntuacion.getPunto(1).cambiarNumero(puntos.puntuacion().get(2).numero())
    puntuacion.getPunto(2).cambiarNumero(puntos.puntuacion().get(1).numero())
    puntuacion.getPunto(3).cambiarNumero(puntos.puntuacion().get(0).numero())
    
    puntuaciones.add(puntuacion)
    puntuaciones.sortBy({ p, p1 => p.total() > p1.total() })
    if (puntuaciones.size() > 3) {
      const puntuacionesValidas = puntuaciones.take(3)
      puntuaciones.clear()
      puntuaciones.addAll(puntuacionesValidas)
    }
  }
  
  method ultimaJugada() = sucuenciasJugador.size() == secuencias.size()
  
  method reiniciar() {
    if (wollokDice.reiniciar()) {
      nivel = 1
      secuencias.clear()
      sucuenciasJugador.clear()
      puntos.resetearPuntuacion()
      self.removeImages(
        [perdiste, sinColores, tuTurno, highScoreImage, highScoreLista]
      )
      self.ocultarTodoHighScore()
      puntos.removeVisual()
      game.addVisual(fondoInicio)
      wollokDice.cambiarEnJuego()
    }
  }
  
  method removeImages(unaListaDeImagenes) {
    unaListaDeImagenes.forEach(
      { imagen => if (game.hasVisual(imagen)) game.removeVisual(imagen) }
    )
  }
  
  method mostrarInstruciones() {
    if (!wollokDice.enJuego()) {
      wollokDice.startGame(false)
      game.removeVisual(fondoInicio)
      game.addVisual(intrucciones)
    }
  }
  
  method mostrarMenu() {
    if (!wollokDice.enJuego()) {
      if (game.hasVisual(intrucciones)) game.removeVisual(intrucciones)
      self.ocultarTodoHighScore()
      if (!game.hasVisual(fondoInicio)) game.addVisual(fondoInicio)
    }
  }
  
  method mostrarHighScore() {
    wollokDice.startGame(false)
    if ((!wollokDice.enJuego()) || wollokDice.reiniciar()) {
      game.removeVisual(highScoreImage)
      game.removeVisual(fondoBase)
      if (!game.hasVisual(highScoreLista)) game.addVisual(highScoreLista)
      if (puntuaciones.size() == 0) {
        if (not game.hasVisual(sinHighScore)) game.addVisual(sinHighScore)
      } else {
        self.escribirHighScore()
      }
    }
    if (!wollokDice.enJuego()) game.addVisual(volver)
    else game.addVisual(volverR)
  }
  
  method escribirHighScore() {
    var posicionY = 13
    puntuaciones.forEach({ p =>  p.escribirHighScore(posicionY)posicionY -= 3})
  }
  
  method ocultarTodoHighScore() {
    self.removeImages([volverR, volver, sinHighScore])
    puntuaciones.forEach({ p => p.removerHighScore() })
    if (game.hasVisual(highScoreLista)) game.removeVisual(highScoreLista)
  }
}
