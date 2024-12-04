import wollok.game.*
import configuracion.*
import elementos.*
import mozo.*
import pedidos.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
    const property nroFantasma
  
    var position = game.origin()

    var property image = "f6.png"

    var property tienePedidoEnCurso = false

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["clienteNORMAL.png", "clienteNORMAL1.png","clienteNORMAL2.png","clienteNORMAL3.png","clienteNORMAL4.png", "f6.png"]
    const property animacionDesaparecerEnojado = ["clienteENOJADO.png", "clienteENOJADO1.png","clienteENOJADO2.png","clienteENOJADO3.png","clienteENOJADO4.png", "f6.png"]

    var property miPedido = new PedidoFantasma(fantasmaAsignado=self) // burbuja de pedido
    
    var tiempoAsignado = 30
    var tiempo = tiempoAsignado
    method position() = position
    method tiempo() = tiempo
    method tiempoAsignado() = tiempoAsignado
	method reiniciar() {
		tiempo = tiempoAsignado
        image = "clienteNORMAL.png"
	}
    method reiniciarYParar(nombreTick) {
        tiempo = tiempoAsignado
        game.removeTickEvent(nombreTick)
    }
	method pasarSegundo() {
		tiempo -= 1
	}
    method actualizarRelojFantasma(unTiempo) {
        tiempoAsignado = unTiempo
        tiempo = unTiempo
    }
	method correrTiempo(nombreTick) {
		game.onTick(1000, nombreTick, {
		self.pasarSegundo()
		if (tiempo == 15)
			self.enojarse()
		if (tiempo == 0)
            self.desaparecerEnojado()
		})
	}
    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        self.borrarPedidoEnMesa()
        mozo.sumarClienteAtendido()
        game.schedule(3000,{game.removeVisual(self)})
        self.aparecerNuevoFantasma()
        cliente.fantasmasVisibles().remove(self)
    }

    method desaparecerEnojado() {
        self.tienePedidoEnCurso(false)
        self.reiniciarYParar("relojCliente"+nroFantasma)
        config.reproducirAnimacion(self, animacionDesaparecerEnojado, "animacionDesaparecerEnojado")
        mozo.perderCliente()
        if (game.hasVisual(miPedido)) {
            game.removeVisual(miPedido)
        }
        game.schedule(3000,{game.removeVisual(self)})
        self.aparecerNuevoFantasma()
        cliente.fantasmasVisibles().remove(self)
    }

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
        self.mostrarPedido()
        self.correrTiempo("relojCliente"+nroFantasma)
    }

    method aparecerNuevoFantasma() {
        game.schedule(7000, { cliente.todosLosFantasmas().find({f => not cliente.fantasmasVisibles().contains(f)}).aparecer() })
    }

    method celdasALosLados() = [self.position().left(1), self.position().right(1)]

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method mostrarPedido() {
        self.miPedido().reiniciarPosicion()
        game.schedule(6000,{game.addVisual(miPedido)})
    }

    method recibirPedido() {
        self.tienePedidoEnCurso(false)
        self.reiniciarYParar("relojCliente"+nroFantasma)
        image = "clienteNORMAL.png"
        game.schedule(6000, {self.desaparecer()})
    }

    method enojarse() {
        image = "clienteENOJADO.png"
    }

    // CAFE EN MESA
    
	method hayCafeEnMesa(unaPosicion) {
		return game.getObjectsIn(unaPosicion).size() == 2
	}

	method hayCafeEnLaLindanteAlFantasma() {
		return self.celdasALosLados().any({c => self.hayCafeEnMesa(c)})
	}

	method cafeEnLaLindante() {
		return game.getObjectsIn(self.posicionDelCafeLindante()).get(1)
	}

	method posicionDelCafeLindante() {
		return self.celdasALosLados().find({c => self.hayCafeEnMesa(c)})
	}

	method borrarPedidoEnMesa() {
		game.removeVisual(self.cafeEnLaLindante())
	}
}

// CLIENTE LISTAS E INSTANCIAS
object cliente {
    const property todosLosFantasmas = [fantasma1, fantasma2, fantasma3, fantasma4, fantasma5, fantasma6]
    const property fantasmasVisibles = []

    const property fantasma1 = new Cliente(nroFantasma="1")
    const property fantasma2 = new Cliente(nroFantasma="2")
    const property fantasma3 = new Cliente(nroFantasma="3")
    const property fantasma4 = new Cliente(nroFantasma="4")
    const property fantasma5 = new Cliente(nroFantasma="5")
    const property fantasma6 = new Cliente(nroFantasma="6")
}