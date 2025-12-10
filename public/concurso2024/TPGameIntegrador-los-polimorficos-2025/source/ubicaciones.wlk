import escenas.*
import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*
import escenario.*
import limitadores.*
import cinematicas.*
import salasEnemigos.*
object casa {
  var property image = "casa.png"
  var property position = game.origin()
  var property pista = pistaCasa 
  method iniciar() {
    accionesTeclas.pantallaValida(false)
    game.removeVisual(spaceParaContinuar1)
    musicaFondo.cambiarAPista(pista)
    image = escenario.fondoDeSegunDificultad("casa")
    escenario.iniciarEscena(self, casaCachito)
    escenario.ubicarEnEscena(puertaSalidaCasa, 5, 1)
    escenario.colocarJugadorEn(7, 8)
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0)
    barraDeVida.mostrarVidas()
    limitadores.agregarLimitadoresEnCasa()
  }
  method esExterior() = false
  method esSalaConAgua() = false

}
object pueblo {
  var property image = "pueblo.png"
  var property position = game.origin()
  var property x = 5
  var property y = 8
  var property pista = pistaPueblo
  method iniciar() {
    musicaFondo.cambiarAPista(pista)
    image = escenario.fondoDeSegunDificultad("pueblo")
    escenario.iniciarEscena(self, teroViolado)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.colocarJugadorEn(x,y)
    escenario.ubicarEnEscena(puertaIglesia, 5, 11)
    if(not cachito.derrotoA(alien)) escenario.ubicarEnEscena(puertaAlien, 10,8)
    if(not cachito.derrotoA(luzMala))escenario.ubicarEnEscena(puertaLuzMala, 0,8)
    if(not cachito.derrotoA(nahuelito))escenario.ubicarEnEscena(puertaNahuelito, 5,0)
    escenario.ubicarEnEscena(limiteSuperior, 0, 13)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    self.agregarPersonajeAleatorio()
    limitadores.agregarLimitadoresEnPueblo()
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      self.iniciar() 
    })
  }

  method agregarPersonajeAleatorio() {
    if(cachito.enemigosDerrotados() === 3) {
      escenario.elegirPersonaje()
    }
  }
  method esExterior() = true
  method esSalaConAgua() = false  
}

object iglesia {
  const property image = "iglesia.png"
  method imagenPuerta() = if (cachito.enemigosDerrotados() == 3) "pIglesia.png" else "pIglesiaB.png"
  var property position = game.origin() 
  method iniciar() {
    escenario.iniciarEscena(self, iglesiaTeroViolado)
    cachito.ubicacion(self)
    batallaFinal.iniciarPelea()
    pomberito.iniciar()
    escenario.colocarJugadorEn(5,1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 2)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 10, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0) 
    barraDeVida.mostrarVidas()
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else{
      game.schedule(200, {cinematicaPomberito.iniciar()})
      cachito.ubicacion(self)
    }
  }
  method esExterior() = false
  method esSalaConAgua() = false
}

const cuevaSalamanca = new SalaEnemigo(
  enemigo = pomberitoPoseido,
  pista = pistaCuevaSalamanca,
  bloqueoDeMovimiento = false,
  jugadorX = 5,
  jugadorY = 1,
  lSup = 5,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)
const salaLuzMala = new SalaEnemigo(
  enemigo = luzMala,
  jugadorX = 10,
  jugadorY = 1,
  lSup = 15,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)

const salaNahuelito = new SalaEnemigo(
  enemigo = nahuelito,
  tieneAgua = true,
  jugadorX = 5,
  jugadorY = 14,
  lSup = 15,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)

const salaAlien = new SalaEnemigo(
  enemigo = alien,
  jugadorX = 0,
  jugadorY = 1,
  lSup = 12,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)
