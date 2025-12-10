import menus.*
import config.*
import musica.*
import visuales.*
import corazones.*
import movimientos.*
import proyectiles.*
import wollok.game.*

class Nivel inherits Visual (position = game.origin()) {
  const enemigos = [gusano, caracol, demonio]
  var property pincho
  var property enemigo
  var property pantalla
  var property musica 
  var property columnas
  var property iniciado = false
  method iniciarNivel() {
      game.clear()
      iniciado = true
      menuPausa.configuracionTeclado()
      menuControles.configuracionTeclado()
      game.addVisual(self)
      self.musica().play()
      mago.resetear()
      game.addVisual(mago)
      mago.mostrarCorazones()
      mago.configuracionTeclado()
      enemigo.resetear()
      game.addVisual(enemigo)
      enemigo.mostrarCorazones()
      enemigo.comboEnemigo()
      self.agregarColumnas()
      self.agregarPincho()
    }
  method volverAlMenu() {
    iniciado = false
    musica.reanudar()
    musica.stop()
    game.clear()
    mago.resetearVidas()
    enemigos.forEach({e => e.resetearVidas()})
    juegoPorNiveles.indice(0)
    menuPausa.abierto(false)
    menuInicio.abrir()
  }
  method estaGanado() = enemigo.estaMuerto()
  method enemigoVivoEn(unaPosicion) = enemigo.position() == unaPosicion
  method agregarColumnas()
  method agregarPincho()
}

object nivelUno inherits Nivel (pincho = new Pincho(segundos = 5000)) {
  override method agregarPincho() {
    pincho = new Pincho(segundos = 5000)
    idPincho.actualizarUltimoID()
    pincho.aparece()
  }
  override method agregarColumnas() { columnas.forEach({c => game.addVisual(c)}) }
  method initialize() {
    enemigo = gusano 
    pantalla = pantallaUno
    image = "escenarioUno.png"
    musica = musicaNivel1
    columnas = [columna1N1, columna2N1, columna3N1]
  }
}

object nivelDos inherits Nivel (pincho = new Pincho(segundos = 3000)) {
  override method agregarPincho() {
    pincho = new Pincho(segundos = 3000)
    idPincho.actualizarUltimoID()
    pincho.aparece()
  }
  override method agregarColumnas() { columnas.forEach({c => game.addVisual(c)}) }
  method initialize() {
    enemigo = caracol
    pantalla = pantallaDos
    image = "escenarioDos.png"
    musica = musicaNivel2
    columnas = [columna1N2, columna2N2]
  }
}

object nivelTres inherits Nivel (pincho = new Pincho(segundos = 1500)) {
  override method agregarPincho() {
    pincho = new Pincho(segundos = 2000)
    idPincho.actualizarUltimoID()
    pincho.aparece()
  }
  override method agregarColumnas() { columnas.forEach({c => game.addVisual(c)}) }
  method initialize() {
    enemigo = demonio
    pantalla = pantallaTres
    image = "escenarioTres.png"
    musica = musicaNivel3
    columnas = [columna1N3]
  }
}

class Columna inherits Visual {
  method bloqueaAlMago(pos) {
    const x = position.x()
    const y = position.y()
    return 
      (pos.x() == x && pos.y() == y) ||
      (pos.x() == x && pos.y() == y - 1) ||
      (pos.x() == x && pos.y() == y + 1)
  }
  method bloqueaPincho(pos, columnaPos, radio) =
    (pos.x() - columnaPos.x()) <= radio &&
    (pos.y() - columnaPos.y()) <= radio

}

// columnas - nivel 1
const columna1N1 = new Columna(image = "columna1.png", position = game.at(12,9))
const columna2N1 = new Columna(image = "columna1.png", position = game.at(8,12))
const columna3N1 = new Columna(image = "columna1.png", position = game.at(6,6))

// columnas - nivel 2
const columna1N2 = new Columna(image = "columna2.png", position = game.at(12,12))
const columna2N2 = new Columna(image = "columna2.png", position = game.at(6,6))

// columnas - nivel 3
const columna1N3 = new Columna(image = "columna3.png", position = game.at(8,12))