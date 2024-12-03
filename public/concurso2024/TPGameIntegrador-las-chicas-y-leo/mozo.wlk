import niveles.*
import wollok.game.*
import configuracion.*
import clientes.*
import elementos.*
import pedidos.*

// este script contiene el modelo del MOZO, nuestro personaje principal

object mozo {
	var position = game.at(1,1)

	var image = "fantasmaFrenteSinCafe.png"

	var clientesPerdidos = 0
	var clienteAtendido = 0

	var property tieneCafeEnMano = false // cambiar

	var condicionPerdida = 3

	method position() = position

	method image() = image

	method condicionPerdida() = condicionPerdida

	method actualizarCondicionPerdida(unNumero) {
		condicionPerdida = unNumero
	}

	method clienteAtendido() = clienteAtendido

	method clientesPerdidos() = clientesPerdidos

	method reiniciarMozo() {

		clienteAtendido = 0
		clientesPerdidos = 0
		tieneCafeEnMano = false
		image = "fantasmaFrenteSinCafe.png"
		position = game.at(1,1)

	}

	method celdasLindantes() = [self.position().left(1),
							   self.position().right(1),
							   self.position().up(1),
							   self.position().down(1)]

	method irA(nuevaPosicion) {

		if (not config.hayColision(nuevaPosicion)) { // se verifica que en la posición a moverse NO se genere una colisión entre el mozo y un elemento sólido
			position = nuevaPosicion // se actualiza la posición
		}
		else {position = self.position()} // si hay una colisión, el mozo se queda en la posición actual
	}

	method sumarClienteAtendido() {
		clienteAtendido += 1
	}
	
	method perderCliente() {
		clientesPerdidos += 1
		if (clientesPerdidos >= self.condicionPerdida()){
			game.schedule(3000, {game.clear() reinicio.reiniciarTodoElNivel() derrota.iniciar()})
		}
	}
	
	method crearPedidoEnBarra(unPedidoDeBarra) {
		unPedidoDeBarra.position(unPedidoDeBarra.encontrarLugarLibreEnBarra())
		game.addVisual(unPedidoDeBarra)
    }

	method quitarPedido() {
		game.removeVisual(self.elFantasmaLindante().miPedido()) // Elimina la burbuja de pedido
	}

	// FANTASMAS LINDANTES

	method hayFantasma(unaPosicion) {
		return cliente.fantasmasVisibles().any({f=>f.position() == unaPosicion})
	}

	method hayFantasmaEnCeldaLindante() {
		return self.celdasLindantes().any({c => self.hayFantasma(c)})
	}

	method posicionDelFantasmaLindante() {
		return self.celdasLindantes().find({c => self.hayFantasma(c)})
	}

	method elFantasmaLindante() {
		return game.getObjectsIn(self.posicionDelFantasmaLindante()).get(1)
	}

	method hayFantasmaParaTomarPedido() {
		return self.hayFantasmaEnCeldaLindante() and game.hasVisual(self.elFantasmaLindante().miPedido())
	}

	// PEDIDOS EN BARRA

	method hayPedidoEnBarra(unaPosicion) {
		return barra.posiciones().any({p => p == unaPosicion and game.getObjectsIn(unaPosicion).size() == 1})
	}
	
	method hayPedidoEnBarraEnCeldaLindante() {
		return self.celdasLindantes().any({c => self.hayPedidoEnBarra(c)})
	}

	method hayPedidoEnBarraParaTomar() {
		return self.hayPedidoEnBarraEnCeldaLindante() and not self.tieneCafeEnMano()
	}

	method borrarPedidoEnBarra() {
		game.removeVisual(self.elPedidoEnBarraLindante())
	}

	method elPedidoEnBarraLindante() {
		return game.getObjectsIn(self.posicionDelPedidoEnBarraLindante()).get(0)
	}

	method posicionDelPedidoEnBarraLindante() {
		return self.celdasLindantes().find({c => self.hayPedidoEnBarra(c)})
	}

	// CAFE EN LA MESA

	method puedeDejarPedido() {
		return self.hayFantasmaEnCeldaLindante() and self.tieneCafeEnMano() and not game.hasVisual(self.elFantasmaLindante().miPedido()) and self.elFantasmaLindante().tienePedidoEnCurso()
	}

	method ponerPedidoEnMesa() {
		//self.elFantasmaLindante().pedidoEnCurso(false)
		const laSilla = game.getObjectsIn(self.posicionDelFantasmaLindante()).get(0)
		if (laSilla.orientacion() == "derecha")
			game.addVisual(new TazaMesa(position=self.posicionDelFantasmaLindante().left(1)))
		else
			game.addVisual(new TazaMesa(position=self.posicionDelFantasmaLindante().right(1)))
	}

	method hayCafeEnMesa(unaPosicion) {
		return game.getObjectsIn(unaPosicion).size() == 2
	}

	method hayCafeEnLaLindanteAlFantasma() {
		return self.elFantasmaLindante().celdasALosLados().any({c => self.hayCafeEnMesa(c)})
	}

	method cafeEnLaLindanteAlFantasma() {
		return game.getObjectsIn(self.posicionDelCafeEnFantasmaLindante()).get(1)
	}

	method posicionDelCafeEnFantasmaLindante() {
		return self.elFantasmaLindante().celdasALosLados().find({c => self.hayCafeEnMesa(c)})
	}

	method borrarPedidoEnMesa() {
		game.removeVisual(self.cafeEnLaLindanteAlFantasma())
	}

	// ACTUALIZACION DE IMAGENES

	method actualizarImagenMozoASinCafe() {
		image = image.replace("ConCafe.png", "SinCafe.png")
	}

	method actualizarImagenMozoAConCafe() {
		image = image.replace("SinCafe.png", "ConCafe.png")
	}

	method mostrarImagenIzquierda() {
		if (self.tieneCafeEnMano()) image = "fantasmaIzquierdaConCafe.png" else image = "fantasmaIzquierdaSinCafe.png"
	}

	method mostrarImagenDerecha() {
		if (self.tieneCafeEnMano()) image = "fantasmaDerechaConCafe.png" else image = "fantasmaDerechaSinCafe.png"
	}

	method mostrarImagenFrente() {
		if (self.tieneCafeEnMano()) image = "fantasmaFrenteConCafe.png" else image = "fantasmaFrenteSinCafe.png"
	}

	method mostrarImagenEspalda() {
		if (self.tieneCafeEnMano()) image = "fantasmaEspaldaConCafe.png" else image = "fantasmaEspaldaSinCafe.png"
	}
}