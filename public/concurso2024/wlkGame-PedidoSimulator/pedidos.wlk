import wollok.game.*

class Pedido {
    var property position = game.at(0,0)
    const property image = "transparente.png"
    const property nombre
    const property ganancia
    var property cliente = null
    var property fueRobado = false 

  method efectosDeColisionarContraJugador(jugador) {
    if (jugador.puedeObtenerPedido()) {
      jugador.obtenerPedido(self)
      game.say(jugador, "¡Recogiste el pedido!")
      game.removeVisual(self)
    } else {
      game.say(jugador, "¡No tengo mas espacio!")
    }
  }

  method respawnearPedido() {
    game.addVisual(self)
    fueRobado = true
  }

  method sincronizarPedidoConCliente(unCliente) {
    cliente = unCliente
  }
}