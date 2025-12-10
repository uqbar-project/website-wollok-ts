import gameManager.*
import general.*
import interfaz.*
import controladores.*

object tableroSiete {
  const cartas = []
  const cartaNumero = []
  const celdas = []
  var x = -1
  var y = 1
  
  method iniciar() {
    self.generarTodasCartaNumero()
    self.crearCartas(gameManager.paresTotales(), gameManager.tipoDeJuego())
    cartas.forEach({ c => self.asignarPosicionAzar(c) })
    self.generar()}
  
  method generar() {cartas.forEach({ c => c.generar() })}
  
  method iniciarControles() {keyboard.t().onPressDo({self.verTodo()})}
  
  method desactivar() {self.reiniciarAtributos()}
  
  method crearCartas(n, tipo) {
    (n * 2).times({ i => self.generarUnaCelda() })
    n.times({ i => self.generarParCarta(tipo) })
  }
  
  method generarUnaCelda() {
    celdas.add(self.coordenada())
  }
  
  method coordenada() {
    x += 1
    if (x != 5) {return game.at(x, y)} else {
      x = 0
      y += 1
      return game.at(x, y)}
  }
  
  method generarParCarta(tipo) {
    if (tipo) self.generarParCartaDibujo()
    else self.generarParCartaMixta()
  }
  
  method generarParCartaDibujo() {
    const cartaN = cartaNumero.anyOne()
    
    cartas.add(new CartaDibujo(id = cartaN))
    cartas.add(new CartaDibujo(id = cartaN))
    
    cartaNumero.remove(cartaN)
  }
  
  method generarParCartaMixta() {
    const cartaN = cartaNumero.anyOne()
    
    cartas.add(new CartaDibujo(id = cartaN))
    cartas.add(new CartaTexto(id = cartaN))
    
    cartaNumero.remove(cartaN)
  }
  
  method asignarPosicionAzar(unaCarta) {
    const posicion = celdas.anyOne()
    
    unaCarta.nuevaPosicion(posicion)
    celdas.remove(posicion)
  }
  
  method verTodo() {
    //HACER TRAMPA shhh quién dijo eso?
    cartas.forEach({ c => c.voltear() })
  }
  
  method reiniciarAtributos() {
    x = -1
    y = 1
    cartas.forEach({ c => c.desactivar() })
    cartas.clear()
    celdas.clear()
    cartaNumero.clear()
  }

  method generarTodasCartaNumero() {
    20.times({ i => cartaNumero.add(i) })
  }

  method cartas() = cartas
  method celdas() = celdas
  method cartaNumero() = cartaNumero
}

class Carta {
  var position = null
  const id
  var ima = "Reverso.png"
  var visible = false
  
  method generar() {
    game.addVisual(self)
  }
  
  method desactivar() {
    game.removeVisual(self)
  }
  
  method image() = ima
  
  method voltear()
  
  method nuevaPosicion(nueva) {
    position = nueva
  }
  
  method position() = position
  
  method id() = id
  
  method esVisible() = visible
  
  method generarDiseno() {
    visible = true
  }
  
  method ocultarDiseno() {
    visible = false
    ima = "Reverso.png"
  }
}

class CartaDibujo inherits Carta {
  override method voltear() {
    if (!visible) self.generarDiseno() else self.ocultarDiseno()
  }
  
  override method generarDiseno() {
    super()
    ima = ("Sprite" + id.toString()) + ".png"
  }
}

class CartaTexto inherits Carta {
  override method voltear() {
    if (!visible) self.generarDiseno() else self.ocultarDiseno()
  }
  
  override method generarDiseno() {
    super()
    ima = ("SpriteT" + id.toString()) + ".png"
  }
}