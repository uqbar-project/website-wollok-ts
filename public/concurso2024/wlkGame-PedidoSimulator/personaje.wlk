import wollok.game.*
import menus.*
import partida.*
import hud.*

object personaje {
  var property position = game.at(7,9)
  var vida = 10
  var vidaMax = 10
  var monedas = 0
  var capacidad = 1

  var pedidosEntregados = 0

  const pedidos = []  // lista de pedidos que lleva el jugador -> La pase a constante porque nunca va a dejar de ser una lista
  
  var imgActual = "personaje4.png"
  
  method image() = imgActual

  method cambiarVehiculo(unVehiculo){
    if (monedas >= unVehiculo.monedasNecesarias()) {
      imgActual = unVehiculo.image()
      capacidad = unVehiculo.capacidad()
      vida = unVehiculo.vida()
      vidaMax = unVehiculo.vida()
    } else {
      game.schedule(4000, { game.say(self, "Necesito ganar unos mangos mas")})  
    }
  }

  method updatePosition(dx, dy) {
    position = game.at(dx, dy)
  }

  method setPosition(dx, dy) {
    position = game.at(dx, dy)
    game.addVisual(self)
  }
  
  method aumentarVida(valor) {
    vida = (vida + valor).min(1000)
  }

  method disminuirVida(valor) {
    if ((vida-valor <= 0)) {
      partida.gameOver()
    } else {
      vida = (vida - valor).max(0)
      partidaHud.actualizarHudVida(vida, vidaMax)
    }
  }

  method aumentarMonedas(valor){
    monedas = monedas + valor
    partidaHud.actualizarHudDinero(monedas)
    game.say(self, "Gracias por la propina Vieja")
  }

  method disminuirMonedas(valor){
    monedas = (monedas - valor).max(0)
    partidaHud.actualizarHudDinero(monedas)
  }

  method setDin(cantidad){
    monedas = cantidad
  }

  method monedas() = monedas

  method interactuarCon(obstaculo) {
    obstaculo.efectosDeColisionarContraJugador(self)
  }
  
  method configurarTeclas() {
    keyboard.w().onPressDo({ self.mover(0, 1) })
    keyboard.s().onPressDo({ self.mover(0, -1) })
    keyboard.a().onPressDo({ self.mover(-1, 0) })
    keyboard.d().onPressDo({ self.mover(1, 0) })

    keyboard.z().onPressDo({ partida.pasarSiguienteNivel() }) // Cheats
  }

  method mover(dx, dy) {
    const proxPosicion = game.at(position.x() + dx, position.y() + dy)
    const objetos = game.getObjectsIn(proxPosicion)

    if (!objetos.isEmpty()) {
      self.interactuarCon(objetos.first())
    } else if (!zonaNoJugable.existeLaPosicion(proxPosicion)){
      position = proxPosicion
    }
  }

  method puedeObtenerPedido() {
    return pedidos.size() < capacidad
  }

  method obtenerPedido(unPedido) {
    pedidos.add(unPedido)
    partidaHud.sincronizarIconosPedidos(pedidos)
  }

  method entregarPedido(unPedido) {
    pedidos.remove(unPedido)
    pedidosEntregados += 1
    partidaHud.sincronizarIconosPedidos(pedidos)
    partida.puedePasarDeNivel(pedidosEntregados)
  }

  method pedidos() = pedidos

  method tienePedido(unPedido) = pedidos.contains(unPedido)

  method pedidoRobado() {
    if (!pedidos.isEmpty()) {
      const pedidoRobado = pedidos.last()
      pedidoRobado.respawnearPedido()
      pedidos.remove(pedidoRobado)
      partidaHud.sincronizarIconosPedidos(pedidos)
    }
  }
  
  method reiniciarPedidosEntregados() {
    pedidosEntregados = 0
    if (!pedidos.isEmpty()) {
      pedidos.clear()
    }
  }

}

object personajeCreditos {
  
  var property position = game.at(-6,1)
  
  method image() = "personaje_moto_pantallaFinal_ok.png"

  method llegarAPosicion() {
    position = game.at(position.x()+1,position.y())
  }

  method estaEnPosicion() = position == game.at(10,1)

  method hablar() {
    game.addVisual(mensajeFinal)
  }

}

object mensajeFinal {

  const property position = game.at(12,6)
  
  method image() = "mensajeFinal.png"

}


object pie {

  method capacidad() = 1

  method vida() = 10

  method image() = "personaje.png"

  method monedasNecesarias() = 0
  
}

object bici {

  method capacidad() = 2

  method vida() = 16

  method image() = "personaje_bicicleta.png"

  method monedasNecesarias() = 10000
  
}

object moto {
  
  method capacidad() = 3

  method vida() = 20

  method image() = "personaje_moto_dev.png"

  method monedasNecesarias() = 13000
  
}