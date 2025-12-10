import wollok.game.*
import personaje.*
import partida.*

class Cliente {
    var propina
    var property position = game.at(0,0)
    const property image = "transparente.png"
    const property avatar = "transparente.png"
    const property pedido  // el pedido que espera (referencia al objeto Pedido)

    var mensaje
    var pedidoEntregado = false

    const movimiento = true

    method pedidoEntregado() = pedidoEntregado

    method verSiElPedidoFueRobado() {
        if (pedido.fueRobado()) {
            self.afectarPropina()
        }
    }

    method afectarPropina() {
        propina = 0
        mensaje = "Te demoraste mucho. No hay propina para vos."
    }

    method efectosDeColisionarContraJugador(jugador) {
        if (jugador.tienePedido(pedido)) {
            self.verSiElPedidoFueRobado()
            game.say(self, mensaje )
            jugador.aumentarMonedas(propina + pedido.ganancia())
            jugador.entregarPedido(pedido)
            pedidoEntregado = true
            game.schedule(1000, { game.removeVisual(self) })
        } else {
            game.say(self, "¡Ese no es mi pedido!" )
            self.afectarPropina()
            jugador.disminuirVida(1)
        }
    }

    method movimientoAleatorio() {
        if (movimiento) {
            const nuevaPos = game.at(0.randomUpTo(game.width()).truncate(0),3.randomUpTo(game.height()).truncate(0))

            if ( zonaClientes.existeLaPosicion(nuevaPos) && game.getObjectsIn(nuevaPos).isEmpty() ) {
                position = nuevaPos
            }
        }
    }


}