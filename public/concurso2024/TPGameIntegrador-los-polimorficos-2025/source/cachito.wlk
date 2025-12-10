import objetos.*
import musicaFondo.*
import escenario.*
import enemigos.*
import ubicaciones.*
import escenas.*
import dificultades.*

object cachito {
	var property vida = 4
	const totems = #{}
	var property mirandoAl = sur
	var tieneInmunidad = false
	var estaEnCombate = false
	var puedeMoverse = true
	var derrotado = false
	var property puedeAtacar = false
	var property tiempoDeInmunidad = 1000
	var property ubicacion = casa
	var property position = game.origin()
	var property image = mirandoAl.imagen()
	var estaEnCuevaSalamanca = false
	
	method puedeMoverse() = puedeMoverse
	
	method derrotado() = derrotado
	
	method tieneInmunidad() = tieneInmunidad
	
	method estaEnCombate(estado) {
		estaEnCombate = estado
	}
	
	method agregarTotem(totem) {
		totems.add(totem)
	}
	
	method derrotoA(enemigo) = totems.contains(enemigo.totem())
	
	method enemigosDerrotados() = totems.size()
	
	method poscionarEn(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

	method entrarACuevaSalamanca() {
		estaEnCuevaSalamanca = true
		tieneInmunidad = false
	}

	method finalizarCuevaSalamanca() {
		ataqueFuego2.eliminarTodosLosElementos()
		estaEnCuevaSalamanca = false
		finalJuego.iniciar()
	}
	
	method configurarTeclas() {
		//Left
		keyboard.a().onPressDo({ if (oeste.puedeAvanzar()) oeste.avanzar() })
		//right
		keyboard.d().onPressDo({ if (este.puedeAvanzar()) este.avanzar() })
		//down
		keyboard.s().onPressDo({ if (sur.puedeAvanzar()) sur.avanzar() })
		//up
		keyboard.w().onPressDo({ if (norte.puedeAvanzar()) norte.avanzar() })
		//lanzar facon
		keyboard.f().onPressDo({if (estaEnCuevaSalamanca) self.lanzarFacon()})

	}
	
	method reiniciar() {
		mirandoAl = sur
		totems.clear()
		tieneInmunidad = false
		estaEnCombate = false
		puedeAtacar = false
		puedeMoverse = true
		tieneInmunidad = false
		tiempoDeInmunidad = 1000
		estaEnCuevaSalamanca = false
		derrotado = false
		self.vida(4)
		self.ubicacion(casa)
		self.actualizarImagen()
		self.position(game.origin())
	}
	
	method actualizarImagen() {
		image = mirandoAl.imagen()
	}
	
	method estaEnUnExterior() = ubicacion.esExterior()
	
	method estaEnElAgua() = ubicacion.esSalaConAgua() && (self.position().y() < 11)
	
	//COMBATE 
	method atacar() {
		animacionAtaque.iniciar()
		position = game.at(5, 1)
		pomberito.recibirDaño()
	}

	method lanzarFacon() {
		if (puedeAtacar){
			const facon = new Facon()
    		facon.position(self.position())
    		facon.disparar()
			image = norte.imagen()
			puedeAtacar = false
			game.schedule(700, { puedeAtacar = true } )
		}
	}
	
	method otorgarInmunidad() {
		tieneInmunidad = true
		game.schedule(tiempoDeInmunidad, { tieneInmunidad = false })
	}
	
	method recibirDaño() {
		if ((self.vida() > 0) && (!tieneInmunidad)) {
			vida = 0.max(vida - 1)
			barraDeVida.sacarVidas()
			self.otorgarInmunidad()
		}
		if (self.vida() == 0) {
			derrotado = true
			pantallaGameOver.iniciar()
		}
	}
	
	method bloquearMovimiento() {
		puedeMoverse = false
	}
	
	method activarMovimiento() {
		puedeMoverse = true
	}
	
	method posicionDeDefensa() {
		mirandoAl = norte
		self.actualizarImagen()
		self.activarMovimiento()
		tieneInmunidad = false
	}
	
	method posicionDeAtaque() {
		self.position(game.at(5, 1))
		mirandoAl = sur
		self.actualizarImagen()
		self.bloquearMovimiento()
		tieneInmunidad = true
	}
}

object barraDeVida {
	var property vidas = [corazon1, corazon2, corazon3, corazon4]
	
	method mostrarVidas() {
		vidas.forEach({ c => c.agregar() })
	}
	
	method reiniciar() {
		vidas = [corazon1, corazon2, corazon3, corazon4]
	}
	
	method sacarVidas() {
		vidas.find({ c => c.numero() > cachito.vida() }).remover()
		vidas.remove(vidas.find({ c => c.numero() > cachito.vida() }))
	}
}