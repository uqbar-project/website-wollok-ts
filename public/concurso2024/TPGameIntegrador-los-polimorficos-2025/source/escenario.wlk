import source.enemigos.*
import wollok.game.*
import cachito.*
import musicaFondo.*
import textos.*
import objetos.*
import ubicaciones.*
import escenas.*
import dificultades.*
import calidades.*


object escenario {
  var property elementosEnEscena = []
  var property obstaculosAnimados = []
  var property animar = false
  var property enGameOver = false
  var property enFinal = false
  var property dificultad = dificultadFacil
  var property calidad = calidadBaja
  var property enDificil = false
  const property puertas = [
    puertaIglesia,
    puertaNahuelito,
    puertaAlien,
    puertaLuzMala
  ]
  
  method reiniciarEstados() {
    animar = false
    enGameOver = false
  }
  
  method cargarListaconElementos() {
    elementosEnEscena = game.allVisuals()
  }
  
  method borrarTodaLaListaDeelementos() {
    elementosEnEscena.forEach({ a => game.removeVisual(a) })
    obstaculosAnimados.forEach({ o => o.remover() })
    elementosEnEscena.clear()
    obstaculosAnimados.clear()
  }
  
  method borrarEscena() {
    self.cargarListaconElementos()
    self.borrarTodaLaListaDeelementos()
  }
  
  method iniciarEscena(unaUbicacion, textoUbicacion) {
    self.borrarEscena()
    game.addVisual(unaUbicacion)
    game.addVisual(textoUbicacion)
  }
  
  method ubicarEnEscena(elementoA, x, y) {
    game.addVisual(elementoA)
    elementoA.ubicarEn(x, y)
  }
  
  method colocarJugadorEn(x, y) {
    game.addVisual(cachito)
    cachito.poscionarEn(game.at(x, y))
  }
  
  method actualizarPuertas() {
    puertas.forEach({ puerta => puerta.actualizarImagen() })
  }
  
  method animarCartel(c1, c2) {
    if (game.hasVisual(c1) && animar) {
      game.removeVisual(c1)
      game.addVisual(c2)
      game.schedule(600, { self.animarCartel(c1, c2) })
    } else {
      if (game.hasVisual(c2) && animar) {
        game.removeVisual(c2)
        game.addVisual(c1)
        game.schedule(600, { self.animarCartel(c1, c2) })
      }
    }
  }
  
  method detenerAnimacion(c1, c2) {
    animar = false
    if (game.hasVisual(c1)) game.removeVisual(c1)
    if (game.hasVisual(c2)) game.removeVisual(c2)
  }
  
  method probabilidadAleatoria() {
    const numeros = [1, 2, 3, 4, 5, 6]
    return numeros.anyOne().even()
  }
  
  method elegirPersonaje() {
    if (self.probabilidadAleatoria()) self.ubicarEnEscena(gauchitoGil, 4, 5)
    else self.ubicarEnEscena(mujerCachito, 4, 5)
  }
  
  method fondoDeSegunDificultad(ubicacion) {
    if (self.enDificil()) {
      return  ubicacion + "-dificil.png"
    } else {
      return ubicacion + ".png"
    }
  }
  method mostrarDificultad() {
    if (self.enDificil()) {
      cartelDificil.mostrar()
    } else {
      cartelFacil.mostrar()
    }
  }
}

object accionesTeclas {
  var pantalla = null
  var property pantallaValida = false
  var property tecla = null
  var property tecla2 = null
  var property tecla3 = null
  
  method asignarTeclas(teclaN1, teclaN2, teclaN3) {
    tecla = teclaN1
    tecla2 = teclaN2
    tecla3 = teclaN3
  }
  
  method actualizarPantalla(nuevaPantalla) {
    pantalla = nuevaPantalla
  }
  
  method accion() {
    tecla.onPressDo({ if (pantallaValida) pantalla.accionTecla() })
    if (tecla2 != null) tecla2.onPressDo(
        { if (pantallaValida) pantalla.accionTecla2() }
      )
    if (tecla3 != null) tecla3.onPressDo(
        { if (pantallaValida) pantalla.accionTecla3() }
      )
  }
}