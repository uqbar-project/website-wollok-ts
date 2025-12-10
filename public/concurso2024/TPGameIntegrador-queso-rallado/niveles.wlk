import sonidosEfecto.*
import wollok.game.*
import unahBlocks.*
import teclasymenu.*

// ==================== [CLASE BASE NIVEL] ====================

class Nivel {
  var property cajasNivel = []
  var llaveConseguida = false
  

  method victoria(dino)
  method posicionesLlegadas()
  method obtenerPosicionesCajas()

  method llaveConseguida() = llaveConseguida
  
  method conseguirLlave() {
    llaveConseguida = true
  }
  
  method cargar(dino) {
    game.addVisual(dino)
    dino.position(self.posicionInicialPersonaje())
    cajasNivel.clear()
    llaveConseguida = false
    
    self.dibujarNivel()
    cartelFlechas.iniciar() //cambio agregado al mapa cartel indicador de controles
    cartelBoton.iniciar()
  }
  
  method posicionInicialPersonaje()
  method dibujarNivel() {
    const ancho = game.width() - 1
    const largo = game.height() - 1
    
    const posicionesParedes = self.obtenerPosicionesParedes(ancho, largo)
    const posicionesLlegadas = self.posicionesLlegadas()
    const posicionesCajas = self.obtenerPosicionesCajas()

    self.dibujarObjetosEspeciales()
    
    posicionesParedes.forEach(
      { posicionParedes => self.dibujar(new Pared(position = posicionParedes)) }
    )
    
    posicionesLlegadas.forEach(
      { posicionLlegadas => self.dibujar(new Llegada(position = posicionLlegadas, nivel = self)) }
    )
    
    posicionesCajas.forEach({ posCaja => 
      const caja = self.dibujar(new Caja(position = posCaja, llegadas = posicionesLlegadas, nivel = self))
      cajasNivel.add(caja)
    })
    
    
  }
  
  method obtenerPosicionesParedes(ancho, largo)
  method dibujarObjetosEspeciales() {} 
  
  method dibujar(dibujo) {
    game.addVisual(dibujo)
    return dibujo
  }
  
  method todasCajasUbicadas() = cajasNivel.all({ c => c.estaBienPosicionada() })
  
  method verificarVictoria(dino) {
    if (self.todasCajasUbicadas())
      self.victoria(dino)
  }
  
   //
}

// ==================== [NIVEL 1] ====================

class Nivel1 inherits Nivel {
  
  override method posicionInicialPersonaje() = game.at(15, 8)
  
  override method obtenerPosicionesParedes(ancho, largo) {
    const posiciones = []
    
    // Bordes eliminados

    
    // Recuadro Nivel 1
    (2 .. 9).forEach({ n => posiciones.add(new Position(x = 16, y = n)) })
    (2 .. 9).forEach({ n => posiciones.add(new Position(x = 8, y = n)) })
    (8 .. 16).forEach({ n => posiciones.add(new Position(x = n, y = 9)) })
    (8 .. 16).forEach({ n => posiciones.add(new Position(x = n, y = 1)) })
    
    // Paredes adicionales
    posiciones.addAll([
      new Position(x = 10, y = 3),
      new Position(x = 11, y = 3),
      new Position(x = 13, y = 3),
      new Position(x = 13, y = 4),
      new Position(x = 14, y = 3),
      new Position(x = 13, y = 7),
      new Position(x = 13, y = 8),
      new Position(x = 10, y = 5),
      new Position(x = 10, y = 6)
    ])
    
    return posiciones
  }
  
  override method posicionesLlegadas() = [
    new Position(x = 9, y = 3),
    new Position(x = 9, y = 6),
    new Position(x = 14, y = 8),
    new Position(x = 15, y = 2)
  ]
  
  override method obtenerPosicionesCajas() = [
    new Position(x = 9, y = 6),
    new Position(x = 12, y = 6),
    new Position(x = 12, y = 5),
    new Position(x = 13, y = 5)
  ]
  
  override method victoria(dino) {
    game.clear()
    const nivelSiguiente = new Nivel2()
    nivelSiguiente.cargar(dino)
    movimientoTeclado.configurar(dino, nivelSiguiente)
    game.sound("victory.mp3").play()
    game.addVisual(cartelVictoria)
    game.schedule(2500, { game.removeVisual(cartelVictoria) })
  }
}
// cambio se eliminaron los bordes delimitantes del ancho y largo del juego

// ==================== [NIVEL 2] ====================

class Nivel2 inherits Nivel {
  const llave = new Llave(position = new Position(x = 11, y = 7), nivel = self)
  const puerta = new Puerta(position = new Position(x = 13, y = 6), nivel = self)
  
  override method conseguirLlave() {
    super()
    game.removeVisual(llave)
    game.schedule(500, { self.dibujar(cartelLlave) })
  }
  
  override method posicionInicialPersonaje() = game.at(13, 2)
  
  override method cargar(dino) {
    super(dino)
    game.say(dino, "Nivel 2")
  }
  
  override method obtenerPosicionesParedes(ancho, largo) {
    const posiciones = []
    
    // Bordes

    
    // Recuadro Nivel 2
    (2 .. 10).forEach({ n => posiciones.add(new Position(x = 15, y = n)) })
    (2 .. 10).forEach({ n => posiciones.add(new Position(x = 8, y = n)) })
    (8 .. 15).forEach({ n => posiciones.add(new Position(x = n, y = 10)) })
    (8 .. 15).forEach({ n => posiciones.add(new Position(x = n, y = 1)) })
    
    // Paredes adicionales
    posiciones.addAll([
      new Position(x = 11, y = 3),
      new Position(x = 11, y = 4),
      new Position(x = 11, y = 5),
      new Position(x = 13, y = 7),
      new Position(x = 13, y = 8),
      new Position(x = 12, y = 7),
      new Position(x = 12, y = 8),
      new Position(x = 9, y = 4),
      new Position(x = 9, y = 5),
      new Position(x = 9, y = 6),
      new Position(x = 9, y = 7),
      new Position(x = 9, y = 8),
      new Position(x = 9, y = 9),
      new Position(x = 9, y = 3)
    ])
    
    return posiciones
  }
  
  override method posicionesLlegadas() = [
    new Position(x = 9, y = 2),
    new Position(x = 11, y = 9),
    new Position(x = 14, y = 9),
    new Position(x = 14, y = 4),
    new Position(x = 13, y = 6)
  ]
  
  override method obtenerPosicionesCajas() = [
    new Position(x = 11, y = 9),
    new Position(x = 11, y = 6),
    new Position(x = 11, y = 7),
    new Position(x = 13, y = 5),
    new Position(x = 12, y = 5)
  ]
  
  override method dibujarObjetosEspeciales() {
    self.dibujar(llave)
    self.dibujar(puerta)
  }
  
  override method victoria(dino) {
    game.clear()
    game.sound("victory.mp3").play()
    musicaFondo.detener()
    menu.reiniciarMusicaActivada()
    pantallaFinal.reiniciarPantallaFinal()
    pantallaFinal.iniciar()
    cartelBoton.reiniciarCartelBoton()
    game.schedule(9000, { self.volverAlMenu() }) //cambio aumento de duracion (primero se reproduce gif y dsp vuelve al menu)
  }
  
  method volverAlMenu() {
    game.clear()
    menu.mostrar()
  }
}

// ==================== [CLASE BASE OBJETO] ====================

class Objeto {
  var property position
  
  method movete(direccion) // Método abstracto
  method puedePisarte(quien) // Método abstracto
  method image() // Método abstracto
}

// ==================== [PARED] ====================

class Pared inherits Objeto {
  
  override method movete(direccion) {
    throw new DomainException(
      message = "No puedo mover paredes.",
      source = dino
    )
  }
  
  override method puedePisarte(_) = false
  
  override method image() = "muro.png"
}

// ==================== [CAJA] ====================

class Caja inherits Objeto {
  var property nivel
  const property llegadas
  
  override method movete(direccion) {
    self.validarLugarLibre(direccion)
    position = direccion.siguiente(position)
    if(self.estaBienPosicionada()){
      game.sound("cajaEnLlegada.mp3").play()
      self.mostrarBrillo() //cambio agregado de brillo al ubicar la caja en su lugar
    }
  }
  
  method validarLugarLibre(direccion) {
    const posAlLado = direccion.siguiente(position)
    const lugarLibre = game.getObjectsIn(posAlLado).all(
      { obj => obj.puedePisarte(self) }
    )
    if (!lugarLibre) {
      throw new DomainException(
        message = "No puedo mover el huevo.",
        source = dino
      )
    }
  }

  method mostrarBrillo() { //cambio inicializa un gif cuando estaBienPosicioanda
    const brillo = new Brillo(position = position)
    game.addVisual(brillo)
    game.schedule(600, { game.removeVisual(brillo) })
}
  
  override method puedePisarte(_) = false
  
  override method image() = if (self.estaBienPosicionada()) "cajaBienUbicada.png"
                            else "caja.png"
  
  method estaBienPosicionada() = nivel.posicionesLlegadas().any(
    { llegada => llegada == position }
  )
}

// ==================== [LLEGADA] ====================

class Llegada inherits Objeto {
  var property nivel
  
  override method movete(direccion) {
    // No hace nada
  }
  
  override method puedePisarte(_) = true
  
  override method image() = "llegada.png"
}

// ==================== [PUERTA] ====================

class Puerta inherits Objeto {
  var property nivel
  
  override method movete(direccion) {
    self.validarSiTieneLlave()
    game.sound("sacarPuerta.mp3").play()
    game.removeVisual(self)
    game.removeVisual(cartelLlave)
  }
  
  method validarSiTieneLlave() {
    if (!nivel.llaveConseguida()) {
      throw new DomainException(
        message = "No tengo la llave",
        source = dino
      )
    }
  }
  
  override method puedePisarte(_) = false
  
  override method image() = "gate.png"
}

// ==================== [LLAVE] ====================

class Llave inherits Objeto {
  var property nivel
  
  override method movete(direccion) {
    game.sound("llaveEncontrada.mp3").play()
    nivel.conseguirLlave()
  }
  
  override method puedePisarte(_) = true
  
  override method image() = "key.png"
}

// ==================== [CARTELES] ====================

object cartelVictoria {
  method position() = game.at(5, 5)
  method image() = "victoria1.gif"
}

object cartelLlave {
  method position() = game.at(1, 9)
  method image() = "llave conseguida.png"
}

object pantallaFinal { // cambio agregado de pantalla al agregar el juego
  var property imagen = "pantallaFinalAnimacion.gif" //se hace var porque primero vale GIF y dsp PNG
  method reiniciarPantallaFinal() {
    imagen = "pantallaFinalAnimacion.gif"
  }
  
  method position() = game.origin()
  method image() = imagen
  
  method iniciar() {
    game.addVisual(self)
    game.schedule(duracionGif, { self.cambiarAPNG() }) //una vez que termine el gif cambia A PNG
  }
  
  method cambiarAPNG() {
    imagen = "pantallaFinal.png" 
  }
  
  const duracionGif = 5010  //duracion establecida para el gif
}

// ==================== [INSTANCIAS DE NIVELES] ====================
// Crear instancias para usar desde el menú

const nivel1 = new Nivel1()
const nivel2 = new Nivel2()

class Brillo {
  const property position 
  method image() = "Brillo.gif"
}

object cartelFlechas {
  const duracionGif = 5010
  var property imagen = "flechasAnimacion.gif"  //misma logica pantallaFinal cambio de GIF a PNG
  
  method position() = game.at(game.width() - 6, 1)
  
  method image() = imagen
  
  method iniciar() {
    game.addVisual(self)
    game.schedule(duracionGif, { self.cambiarAPNG() })
  }
  
  method cambiarAPNG() {
    imagen = "flechas.png"
  }
  
  
}

object cartelBoton {
  var property imagen = "botonAnimacion.gif"
  
  method position() = game.at(1, 1)  
  
  method image() = imagen
  
  method iniciar() {
    game.addVisual(self)
    game.schedule(5010, { self.cambiarAPNG() })
  }
  
  method cambiarAPNG() {
    imagen = "boton.png"
  }
  
  method reiniciarCartelBoton() {
    imagen = "botonAnimacion.gif"
  }
  
  const duracionGif = 5010
}
