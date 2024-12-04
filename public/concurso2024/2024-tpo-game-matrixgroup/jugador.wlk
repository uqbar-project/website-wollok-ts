import escena.*
import utiles.*
import computadora.*
import elementos.*
import tienda.*
import constantes.*
import empleado.*

object jugador {
	var property position = game.center()
	var property image = "jugador_frente.png"
	var property empleados = []
	var property sacoProducto = false
	var property barraProgresoProgramando = new BarraProgreso(
		position = computadora.position().up(2),
		listaAssets = listaAssetsBarra.reverse()
	)
	
	// -------------------- PROGRAMACION
	method programar() {
		//Arranca la cuenta regresiva cuando aprieta la E para programar
		if (position == computadora.silla().position()) {
			oficina.play("programar.mp3")
			game.onTick(
				2000,
				"Evento de progreso de Codigo",
				{ self.resultadoProgramar() }
			)
			if (barraProgresoProgramando.finalizo()) barraProgresoProgramando.reiniciar()
		}
	}
	
	method entregarProducto() {
		if ((position == mostradorU.position().right(1).up(1)) && sacoProducto) {
			producto.position(mostradorU.position().right(1))
			producto.colocarProducto()
			sacoProducto = false
		}
	}
	
	method sacaProducto() {
		if (position == producto.position().down(1)) producto.sacarProducto()
	}
	
	method resultadoProgramar() {
		barraProgresoProgramando.iniciar()
		if (barraProgresoProgramando.finalizo()) {
			//En este sector se agrega lo que tiene que pasar cuando termina de programar.
			sacoProducto = true
			producto.colocarProducto()
			game.removeTickEvent("Evento de progreso de Codigo")
			// Necesario para detener el loop
		}
	}
	
	// ---------- EMPLEADOS
	method cobrarEmpleados() {
		empleados.forEach({ empleado => empleado.cobrar() })
	}
	
	method initialize() {
		game.onTick(5000, "Cobrar empleados", { self.cobrarEmpleados() })
	}
	
	// ------------------- MOVIMIENTO
	method moverse(direccion) {
		const nuevaPosicion = direccion.siguiente(position)
		
		if (zonaValida.dentroDelLimite(nuevaPosicion) && !celdasOcupadas.estaOcupada(
			nuevaPosicion
		)) {
			position = nuevaPosicion
		}
		
		image = ("jugador_" + direccion.orientacion()) + ".png"
	}
}

object zonaValida {
	const maxHeight = 7
	const minHeight = 0
	const maxWidth = 19
	const minWidth = 0
	
	method dentroDelLimite(
		position
	) = (((position.x() >= minWidth) && (position.x() <= maxWidth)) && (position.y() >= minHeight)) && (position.y() <= maxHeight)
}

object arriba {
	method siguiente(position) = position.up(1)
	
	method orientacion() = "atras"
}

object abajo {
	method siguiente(position) = position.down(1)
	
	method orientacion() = "frente"
}

object derecha {
	method siguiente(position) = position.right(1)
	
	method orientacion() = "derecha"
}

object izquierda {
	method siguiente(position) = position.left(1)
	
	method orientacion() = "izquierda"
}