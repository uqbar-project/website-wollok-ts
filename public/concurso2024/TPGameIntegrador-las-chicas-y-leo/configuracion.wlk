import temporizador.*
import wollok.game.*
import mozo.*
import clientes.*
import elementos.*
import niveles.*
import pedidos.*
import sonido.*
import textoystatsvisuales.*


// este script contiene la CONFIGURACIÓN de las teclas, colisiones, etc.

object config {
	method configurarTeclas() {
		// TECLAS DE MOVIMIENTO
		// Actualiza la posición del mozo si puede moverse + su imagen orientada en dicha dirección

		keyboard.left().onPressDo( {mozo.irA((mozo.position().left(1))) mozo.mostrarImagenIzquierda()} )
		keyboard.right().onPressDo( {mozo.irA(mozo.position().right(1)) mozo.mostrarImagenDerecha()} )
		keyboard.up().onPressDo( {mozo.irA(mozo.position().up(1)) mozo.mostrarImagenEspalda()} )
		keyboard.down().onPressDo( {mozo.irA(mozo.position().down(1)) mozo.mostrarImagenFrente()} )

		// TECLAS DE INTERACCIÓN

		keyboard.w().onPressDo({self.interaccionTomarPedidoAFantasma()}) // Toma el pedido del cliente en la celda lindante

		keyboard.a().onPressDo({self.interaccionTomarPedidoDeBarra()}) // Toma el pedido de la barra en la celda lindante

		keyboard.d().onPressDo({self.interaccionServirPedidoAFantasma()}) // Sirve el pedido en mano al cliente en la celda lindante

    }

	// MÉTODOS DE INTERACCIÓN

	method interaccionTomarPedidoAFantasma() {
		if (mozo.hayFantasmaParaTomarPedido()){ // Se asegura que haya un fantasma en la lindante para tomar un pedido
			mozo.quitarPedido() // Elimina la burbuja del pedido
			mozo.crearPedidoEnBarra(new PedidoDeBarra(position = game.origin())) // Crea el pedido en la barra
			mozo.elFantasmaLindante().tienePedidoEnCurso(true) // Setea el curso del pedido del fantasma
			mozo.elFantasmaLindante().reiniciar() // reinicia el "reloj" del cliente para que no se continue enojando luego de ser atendido
        }
	}

	method interaccionTomarPedidoDeBarra() {
	    if (mozo.hayPedidoEnBarraParaTomar()){ // Se asegura que haya un pedido en la barra para tomar
			mozo.tieneCafeEnMano(true) // Setea el mozo a tiene café en mano
			mozo.borrarPedidoEnBarra() // Borra el pedido de la barra
			mozo.actualizarImagenMozoAConCafe() // Actualiza la imagen del mozo CON UN CAFÉ en la celda actual, para dar un efecto visual en tiempo real
		}
	}

	method interaccionServirPedidoAFantasma() {
    
		if (mozo.puedeDejarPedido()){ // Se asegura que puede dejare un pedido en la celda lindante
			mozo.tieneCafeEnMano(false) // Setea el mozo a NO tiene café en mano
			mozo.ponerPedidoEnMesa() // Pone el pedido en la mesa del fantasma de la celda lindante
			mozo.actualizarImagenMozoASinCafe() // Actualiza la imagen del mozo SIN CAFÉ en la celda actual, para dar un efecto visual en tiempo real
			mozo.elFantasmaLindante().recibirPedido() // El fantasma de la celda lindante recibe el pedido
		}
	}

	// COLISIONES

	method hayBorde(posicionAMover) {
		// DETECTAR SI HAY BORDE
		// Este método devuelve si la posición dada contiene alguno de los ejes donde se encuentra el borde de la escena

		return posicionAMover.x() == 0 ||
		       posicionAMover.x() == 17||
			   posicionAMover.y() == 0 ||
			   posicionAMover.y() == 11
	}

	method hayColision(posicionAMover) {
		// DETECTAR SI HAY COLISIÓN

		return elementoSolido.todosLosElementosSolidos().any({elemento => elemento.position() == posicionAMover}) || self.hayBorde(posicionAMover) || barra.hayBarra(posicionAMover) || stats.hayCuadroStats(posicionAMover)
		// Este método devuelve si algún elemento sólido de la escena es IGUAL a la posición dada
		// Lo utilizamos para sensar el movimiento del mozo
		// si la posición a la que SE MOVERÁ el mozo es LA MISMA que la de algún elemento sólido de la escena
		// si es verdadero, entonces habrá colisión
	}

	// ANIMACIONES

	method reproducirAnimacion(objetoAAnimar, listaDeAnimacion, nombreTick) {
		// Este método reproduce una serie de imágenes de una lista

        var indiceAni = 0

        game.onTick(500,nombreTick,{
            objetoAAnimar.image(listaDeAnimacion.get(indiceAni))
            indiceAni += 1
            if (indiceAni == listaDeAnimacion.size())
                game.removeTickEvent(nombreTick)
            })
	}

	// INICIALIZACIÓN

	var indice = 0

	method iniciarFantasmas(unTiempo) {
		game.onTick(unTiempo,"anadir fantasma",{
			cliente.todosLosFantasmas().get(indice).aparecer()
			indice += 1
			if (cliente.fantasmasVisibles().size() == 3)
				game.removeTickEvent("anadir fantasma")
		})
	}

	method tiempoAlAzar() {
		return 3000.randomUpTo(6000)
	}

	method reiniciarIndice() {
		indice = 0
	}
}

object reinicio {
	method reiniciarTodoElNivel() {
		temporizador.reiniciar()
		mozo.reiniciarMozo()
		cliente.fantasmasVisibles().forEach({f => f.reiniciarYParar("relojCliente"+f.nroFantasma())})
		cliente.fantasmasVisibles().forEach({f => f.image("f6.png")})
		cliente.fantasmasVisibles().clear()
		config.reiniciarIndice()
	}
}