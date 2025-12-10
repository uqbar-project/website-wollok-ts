import salasEnemigos.*
import escenario.*
import textos.*
import objetos.*
import musicaFondo.*
import cachito.*
import enemigos.*
import ubicaciones.*
import cinematicas.*
import dificultades.*
import calidades.*

//======================PANTALLAS========================//
object controles{
  var property image = "controles.png"
  var property position = game.origin()
  method accionTecla() { seleccionCalidadGrafica.iniciar()}
  const tecla = keyboard.space()
  method iniciar() {
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla,null,null)
    accionesTeclas.actualizarPantalla(self)
    game.addVisual(self)
    accionesTeclas.accion()
  }
}

object seleccionCalidadGrafica {
  var property image = "calidadGraf.png"
  var property position = game.origin()
  const tecla1 = keyboard.l()
  const tecla2 = keyboard.h()
  method accionTecla() {calidadBaja.configurar() self.siguiente()}
  method accionTecla2() {calidadAlta.configurar() self.siguiente()}
  
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla1, tecla2, null)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }

  method siguiente() {
    musicaFondo.iniciar(select)
    game.schedule(800,{inicio1.iniciar()})
  }
}

object portada {
  var property image = "portada.png"
  var property position = game.origin()
  const tecla = keyboard.e()
  method accionTecla() {
    cartelIniciar.detenerAnimacion()
    seleccionDeDificultad.iniciar()
    }
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    game.onTick(500, "actualizarPuertas", { escenario.actualizarPuertas() })
    game.addVisual(iniciar1)
    cartelIniciar.animar()
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla , null, null)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
}

object seleccionDeDificultad {
  var property image = "dificultad.png"
  var property position = game.origin()
  const tecla1 = keyboard.f()
  const tecla2 = keyboard.d()
  method accionTecla() {dificultadFacil.configurar() self.siguiente()}
  method accionTecla2() {dificultadDificil.configurar() self.siguiente()}
  
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla1, tecla2, null)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }

  method siguiente() {
    musicaFondo.iniciar(selectDiff)
    game.schedule(3000,{lore1.iniciar()})
  }
}
//=========================Cinematica Inicial=========================//
const inicio1 = new PantallaCinematica(nombreImagen="portada", inicio=1, fin=6, siguiente=portada, pistaMusical=pistaTitulo)
//=========================Cinematica Lore=========================//
const lore1 = new PantallaCinematica(nombreImagen="lore", inicio=1, fin=5, siguiente=lore2, pistaMusical=pistaLore)
const lore2 = new PantallaCinematicaEspecial(image="lore5.png", siguiente=lore3)
const lore3 = new PantallaCinematica(nombreImagen="lore", inicio=6, fin=11, siguiente=lore4)
const lore4 = new PantallaCinematicaEspecial(image="lore12.png", siguiente=lore5)
const lore5 = new PantallaCinematica(nombreImagen="lore", inicio=13, fin=17, siguiente=lore6)
const lore6 = new PantallaCinematicaEspecial(image="lore18.png", siguiente=casa)

//===========================Cinematica Entrada a la iglesia========================//
const cinematicaPomberito = new PantallaCinematica(delay = 1500 ,nombreImagen="escenaPomberito",inicio=1, fin=3,
siguiente=iglesia, pistaMusical=pistaFinalBoss, delaySiguiente=6000)

//===========================Cinematicas Ataque============================//
object animacionAtaque {
  var property image = "ataque1.png"
  var property position = game.origin()
  method iniciar() {
    game.addVisual(self)
    game.schedule(1800, { self.siguienteImagen(2) })
    musicaFondo.volumen(0.05)
  }
  
  method siguienteImagen(img) {
    if (img < 5) {
      image = ("ataque" + img) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(1800, { self.siguienteImagen(img + 1) })
    } else {
      game.sound("grito.mp3").play()
      game.schedule(
        1500,
        { 
          game.removeVisual(self)
          musicaFondo.volumen(0.25)
          image = "ataque1.png"
        }
      )
    }
  }
  
  method duracion() = 9000
}
//===========================PRE FINAL==============================//
const preFinal = new PantallaCinematica(delay=1500, nombreImagen="preFinal", inicio=1, fin=7, siguiente=introCuevaSal, pistaMusical=pistaTitulo, delaySiguiente=2000)
const introCuevaSal = new PantallaCinematica(delay=3000, nombreImagen="introCuevaSal", inicio=1, fin=8, siguiente=portadaCuevaSalamanca, pistaMusical=pistaIntroCueva, delaySiguiente=5000)
const portadaCuevaSalamanca = new PantallaCinematica(nombreImagen="portadaCuevaSalamanca", inicio=1, fin=1, siguiente=faconGet, pistaMusical=pistaPortadaSalamanca, delaySiguiente=11000)
const faconGet = new PantallaCinematica(nombreImagen="faconGet", inicio=1, fin=1, siguiente=cuevaSalamanca, pistaMusical=pistaFaconGet, delaySiguiente=4900)
//===========================Pantalla Game Over - Creditos ===============================//
const finalJuego = new PantallaCinematica(nombreImagen="fin", inicio=1, fin=4, siguiente=creditos, pistaMusical=pistaFinal, esFinal=true, delaySiguiente=5000)

object pantallaGameOver {
  var property image = "gameOver.png"
  var property position = game.origin()
  const tecla1 = keyboard.y()
  const tecla2 = keyboard.n()
  const tecla3 = keyboard.c()
  method accionTecla() { self.reiniciarJuego() }
  method accionTecla2() { self.finalizarJuego() }
  method accionTecla3(){ escenario.dificultad().cambiar() self.reiniciarJuego()}
  method iniciar() {
    escenario.enGameOver(true) 
    escenario.borrarEscena() 
    game.addVisual(self)
    musicaFondo.detener()
    musicaFondo.iniciar(pistaGameOver)
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("disparar")
    game.removeTickEvent("disparar roca")
    game.removeTickEvent("actualizarPuertas")
    game.removeTickEvent("ataque4Pomberito")
    game.removeTickEvent("ataque3Pomberito")
    game.removeTickEvent("ataquePomberitoPoseido")
    game.removeTickEvent("ataque1PomberitoPoseido")
    game.addVisual(reiniciar1)
    cartelReiniciar.animar()
    escenario.mostrarDificultad()
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla1, tecla2, tecla3)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }

  method reiniciarJuego() {
    musicaFondo.detener()
    musicaFondo.volumen(0.25)
    escenario.borrarEscena()
    cachito.reiniciar()
    nahuelito.reiniciar()
    musicaFondo.reestablecerPista()
    casa.iniciar()
    escenario.enGameOver(false)
    game.onTick(500, "actualizarPuertas", { escenario.actualizarPuertas() })
    barraDeVida.reiniciar()
    cartelReiniciar.detenerAnimacion()
  }

  method finalizarJuego() {
    image = "fin6.png"
    game.removeVisual(self)
    cartelReiniciar.detenerAnimacion()
    game.addVisual(self)
    game.schedule(1000,{ game.stop() })
  }
}
object creditos {
  var property image = "fin5.png"
  var property position = game.origin()
  const tecla = keyboard.f()
  method accionTecla() {image = "fin6.png"; game.schedule(3000, {game.stop()})}
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTeclas(tecla, null,null)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
}