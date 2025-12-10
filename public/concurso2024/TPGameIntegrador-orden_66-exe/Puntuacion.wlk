import interfaz.*

class Numero {
  var property position = game.at(0, 0)
  var numero = 0
  
  method cambiarNumero(unNumero) {
    numero = unNumero
  }
  
  method image() = ("" + numero) + ".png"
  
  method numero() = numero
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
}

class Letra {
  var property position = game.at(0, 0)
  const letraMax = 25
  const letraMin = 0
  var letraActual = letraMin
  
  method image() = ("letra_" + letraActual) + ".png"
  
  method valor() = letraActual
  
  method reubicar(posX, posY) {
    position = game.at(posX, posY)
  }
  
  method cambiarLetra(unaLetra) {
    letraActual = unaLetra
  }
  
  method aumentarLetra() {
    const letraAux = letraActual + 1
    letraActual = if (letraAux.between(letraMin, letraMax)) letraAux
                  else self.restablecer(letraAux)
  }
  
  method disminuirLetra() {
    const letraAux = letraActual - 1
    letraActual = if (letraAux.between(letraMin, letraMax)) letraAux
                  else self.restablecer(letraAux)
  }
  
  method restablecer(unaLetra) = if (unaLetra < letraMin) letraMax else letraMin
}

class Puntaje {
  const score = [new Numero(), new Numero(), new Numero(), new Numero()]
  const nombre = [
    new Letra(
      letraActual = 0,
      position = game.at(interfaz.ubicacionLetras().get(0), 5)
    ),
    new Letra(
      letraActual = 0,
      position = game.at(interfaz.ubicacionLetras().get(1), 5)
    ),
    new Letra(
      letraActual = 0,
      position = game.at(interfaz.ubicacionLetras().get(2), 5)
    )
  ]
  
  method nombre() = nombre
  
  method score() = score
  
  method getLetra(index) = nombre.get(index)
  
  method getPunto(index) = score.get(index)
  
  method total() = (((score.get(0).numero() * 1000) + (score.get(
    1
  ).numero() * 100)) + (score.get(2).numero() * 10)) + score.get(3).numero()
  
  method escribirNombre(posicionY) {
    var posicionInicialX = 6
    nombre.forEach(
      { l =>
        l.reubicar(posicionInicialX, posicionY)
        game.addVisual(l)
        posicionInicialX += 1
      }
    )
  }
  
  method escribirPuntos(posicionNumeroX, posicionY) {
    var posicionNumeroXAux = posicionNumeroX
    score.forEach(
      { n =>
        n.reubicar(posicionNumeroXAux, posicionY)
        game.addVisual(n)
        posicionNumeroXAux += 1
      }
    )
  }
  
  method escribirHighScore(posicionY) {
    self.escribirNombre(posicionY)
    self.escribirPuntos(10, posicionY)
  }
  
  method removerHighScore() {
    nombre.forEach({ l => if (game.hasVisual(l)) game.removeVisual(l) })
    score.forEach({ n => if (game.hasVisual(n)) game.removeVisual(n) })
  }
}

object puntos {
  const property puntuacion = [
    new Numero(),
    new Numero(),
    new Numero(),
    new Numero()
  ]
  var numero = 0
  
  method addVisual() {
    puntuacion.forEach({ v => game.addVisual(v) })
  }
  
  method numero() = numero
  
  method removeVisual() {
    puntuacion.forEach({ v => game.removeVisual(v) })
  }
  
  method resetearPuntuacion() {
    numero = 0
    puntuacion.forEach({ p => p.cambiarNumero(0) })
  }
  
  method ubicar() {
    puntuacion.get(0).reubicar(15, 0)
    puntuacion.get(1).reubicar(14, 0)
    puntuacion.get(2).reubicar(13, 0)
    puntuacion.get(3).reubicar(12, 0)
  }
  
  method sumarPuntaje(unNumero) {
    numero += unNumero
    puntuacion.get(0).cambiarNumero(numero % 10)
    self.sumarDecimal()
    self.sumarCentena()
    self.sumarUnidadMil()
  }
  
  method sumarDecimal() {
    const decimal = (numero / 10).truncate(0) % 10
    puntuacion.get(1).cambiarNumero(decimal)
  }
  
  method sumarCentena() {
    const centena = (numero / 100).truncate(0) % 10
    puntuacion.get(2).cambiarNumero(centena)
  }
  
  method sumarUnidadMil() {
    const unidadMil = (numero / 1000).truncate(0) % 10
    puntuacion.get(3).cambiarNumero(unidadMil)
  }
  
  method valor() = puntuacion.get(0).numero() + (puntuacion.get(
    1
  ).numero() * 10)
  
  method puntuacion() = puntuacion
}
