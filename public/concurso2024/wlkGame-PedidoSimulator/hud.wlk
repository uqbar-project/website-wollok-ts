import wollok.game.*
import personaje.*
object partidaHud { 
  const estrellas = [] 
  const iconosPedidos = []
  const iconosClientes = []
  
  const posX = 0
  const posY = 14
  const position = game.at(0,14)
  
  const iconPlayer = new Icono(image="icono_player.png")
  const iconBilletera = new Icono(image="billetera.png")
    
  method position() = position

  method inicializarHud(vidas,vidasMax,dinero) {
    self.limpiarEstrellas()
    self.limpiarIconosPedidos()
    self.limpiarIconosDinero()
    self.dibujarEstrellas(vidas, vidasMax)
    self.dibujarDigitosDinero(dinero)
    iconPlayer.setPosition(posX, posY)
    iconBilletera.setPosition(29, posY)
  }

    method actualizarHudVida(vidas, vidasMax) {
      self.limpiarEstrellas()
      self.dibujarEstrellas(vidas, vidasMax)
    }

    method limpiarEstrellas() {
      estrellas.forEach({ e => game.removeVisual(e) })
      estrellas.clear()
    }

  method dibujarEstrellas(vidas, vidasMax) {
    var vidasRestantes = vidas

    new Range(start=1, end=(vidasMax/2)).forEach {
      n =>
      var estrella
      if (vidasRestantes >= 2) {
          estrella = new Icono(image = "estrella_full.png")
          vidasRestantes -= 2
      } else if (vidasRestantes == 1) {
          estrella = new Icono(image = "estrella_mid.png")
          vidasRestantes -= 1
      } else {
          estrella = new Icono(image = "estrella_empty.png")
      }
      estrella.setPosition(posX + n, posY)
      estrellas.add(estrella)
    }
  }

  method mostrarIconoPedido(pedido) {
    const icono = new Icono(image = pedido.image())
    const iconoCliente = new Icono(image = pedido.cliente().avatar())
    icono.setPosition(posX, posY - 1 - iconosPedidos.size())
    iconoCliente.setPosition(29, posY - 1 - iconosClientes.size() )
    iconosPedidos.add(icono)
    iconosClientes.add(iconoCliente)
  }

  method limpiarIconosPedidos() {
    iconosPedidos.forEach({ i => game.removeVisual(i) })
    iconosClientes.forEach({ i => game.removeVisual(i) })
    iconosPedidos.clear()
    iconosClientes.clear()
  }

  method sincronizarIconosPedidos(pedidosPersonaje) {
    self.limpiarIconosPedidos()
    pedidosPersonaje.forEach({ pedido => self.mostrarIconoPedido(pedido) })
  }

  const digitos = []

  method actualizarHudDinero(dinero) {
    self.limpiarIconosDinero()
    self.dibujarDigitosDinero(dinero)
  }

  method limpiarIconosDinero() {
    digitos.forEach { d => game.removeVisual(d) }
    digitos.clear()
  }

  method dibujarDigitosDinero(dinero) {
    const texto = self.formato5Digitos(dinero.toString())
    const caracteres = texto.split("").reverse()

    new Range(start=0, end=(caracteres.size() - 1)).forEach {
      n =>

      const caracter = caracteres.get(n)

      const digito = new Icono(image = "iconos_dinero_"+caracter+".png")
      
      digito.setPosition(29 - n -1, posY)
      digitos.add(digito)
    }

    const signoPesos = new Icono(image = "iconos_dinero_$.png")
      
    signoPesos.setPosition(29 - digitos.size() -1, posY)
    digitos.add(signoPesos)

  }

  method formato5Digitos(dinero) {
    const contadorCeros = "00000" + dinero.toString()
    return contadorCeros.takeRight(5)
  }
}

class Icono {
  var property position = game.at(0,0)
  const property image

  method setPosition(dx, dy) {
    position = game.at(dx, dy)
    game.addVisual(self)
  }

  method efectosDeColisionarContraJugador(jugador) {}

}
