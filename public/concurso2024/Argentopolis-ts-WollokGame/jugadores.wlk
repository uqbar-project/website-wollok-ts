import wollok.game.*
import juego.*
import pantalla.*
import tablero.*
import cartas.*

class Player{
	var property position = game.at(game.width()-1,0)
	var property dinero = 2500
	var property deuda = 0
	var property debeFianza = false
	var prestamosDisponibles = 3
	const img
	const property nombre
	const property numero
	const misPropiedades = #{}
	var property yaTiro = false
	var property finDeTurno = false
		
	method image() = img

	method misPropiedades() = misPropiedades
	method cobrar(monto){dinero += monto}
	method pagar(monto){
		deuda = deuda + 0.max(monto-dinero)
		dinero = 0.max(dinero-monto)
	}
	method puedeComprar(unaPropiedad) = turno.playerOnTurn().dinero() >= unaPropiedad.costo()
	method mePertenece(unaPropiedad) = unaPropiedad.titular() == self
	method esTerrateniente(unaRegion) = self.currentRegion().all({p => p.titular() == turno.playerOnTurn().currentLocation().titular()})
	
	method cobrarSalario(){
	//Valida que al pasar por la salida cobren sólo después de que alguno compro una propiedad		
		if(juego.jugadores().any( { jugador => !jugador.misPropiedades().isEmpty() } )){
			self.cobrar(500)
			game.sound("register.mp3").play()
			const sueldoAnimation = new DineroModifier(img="mas500-")
			sueldoAnimation.animation(4)
			}
	}

	method tirarDados(){
		const dado = new Dado()
		if (!yaTiro){ //Valida que ya tiro
			self.yaTiro(true)
			dado.addVisual()
			game.schedule(4000, { dado.removeVisual() })
			//Avanzar paso a paso por los casilleros
			var pasosRestantes = dado.valor()
			game.onTick(300, "movimiento", {
			    if(pasosRestantes > 0) {
			      self.avanzarCasillero()
			      pasosRestantes -= 1
			    } else {
			      game.removeTickEvent("movimiento")
			    }
			})
			//Activa la reaacion en el casillero que cae
			const tiempoDeReaccion = (300*dado.valor())+1000
			game.schedule(tiempoDeReaccion,{
				self.reaccionarACasillero()
				//Permite finalizar el turno (y no antes de completar todas las acciones)
				finDeTurno = true
			})
		}
	}

	//Avanzar 1 casillero en la direccion correcta
	method avanzarCasillero() {
		position = dir.seguirCamino()
		game.sound("paso.mp3").play()
	}
	
	//Propiedad en la ubicacion del jugador actual (SE PODRA CON FILTER?)
	method currentLocation() = game.getObjectsIn(turno.playerOnTurn().position()).first()
	method currentRegion() = regiones.todasLasRegiones().filter({ r => r.contains(turno.playerOnTurn().currentLocation())}).uniqueElement()
	
	method reaccionarACasillero(){
		//Si es casilla especial se activa.
		self.currentLocation().activarCasillero()
		//Evaluá Condicion de Victoria o Derrota
		self.condicionVictoriaODerrota()
	}

	method noTienesDinero(){
		const dineroInsuficiente = new Popup(img="dineroInsuficiente.png",position=game.at(1,2))
		dineroInsuficiente.addVisual()
		game.schedule(3000,{ dineroInsuficiente.removeVisual() })
	}
	
	
//Compra-Venta al Banco
	method comprar(unaPropiedad){
		const confirmarCompra = new Popup(img="confirmarCompra.png",position=game.at(1,2))
		confirmarCompra.addVisual()
		//Valida que si no está el cartel no se pueda presionar S
		keyboard.s().onPressDo{
			if(juego.popupEnPantalla().contains(confirmarCompra)){//Valida que si no está el cartel no se pueda presionar S
			self.confirmar(unaPropiedad)
			confirmarCompra.removeVisual()
			//Crea una animacion de descuento del dinero segun compra
			turno.playerOnTurn().currentLocation().animacionCompra()
			}
		}keyboard.n().onPressDo{confirmarCompra.removeVisual()}
	}

	method confirmar(unaPropiedad){
		banco.misPropiedades().remove(unaPropiedad)		//Remover de misPropiedades del Banco
		misPropiedades.add(unaPropiedad)				//Añadir a misPropiedades
		self.pagar(unaPropiedad.costo())				//Pagar propiedad
		unaPropiedad.transferirA(self)					//Transferir titularidad
		//Sonido
		game.sound("register.mp3").play()
		//Popup confirmando la compra
		const compraRealizada = new Popup(img="compraRealizada.png",position=game.at(1,2))
		compraRealizada.addVisual()
		game.schedule(1500, { compraRealizada.removeVisual() })
		//Agrega un marcador del titular de la propiedad
		game.addVisual(new MarcadorDuenio())
	}
	

	method transferencia() {
		const confirmarTransferenciaPopup = new Popup(img="confirmarTransferencia.png",position=game.at(1,2))
		confirmarTransferenciaPopup.addVisual()
		keyboard.s().onPressDo{
			if (juego.popupEnPantalla().contains(confirmarTransferenciaPopup)){
				//Completa la transferencia en el siguente método
				self.confirmarTransferencia()
				confirmarTransferenciaPopup.removeVisual()
				turno.playerOnTurn().currentLocation().animacionTransferencia()
				//Popup confirmando la compra
				const compraRealizada = new Popup(img="compraRealizada.png",position=game.at(1,2))
				compraRealizada.addVisual()
				game.schedule(1500, { compraRealizada.removeVisual() })
			}
		}keyboard.n().onPressDo{ confirmarTransferenciaPopup.removeVisual() }
	}
	
	method confirmarTransferencia(){
		const inmueble = turno.playerOnTurn().currentLocation()
		const vendedor = inmueble.titular()
		//Sonido
		game.sound("register.mp3").play()
		//Le cobra al comprador el 150% de su valor original
		dinero -= inmueble.costo() * 1.5
		//Le paga al vendedor el 150% de su valor original
		vendedor.cobrar(inmueble.costo() * 1.5)
		//La elimina de misPropiedades del vendedor
		vendedor.misPropiedades().remove(inmueble)
		//La añade a misPropiedades del comprador
		misPropiedades.add(inmueble)
		//Transfiere titularidad
		inmueble.transferirA(self)
		//Remueve el marcador de propiedad actual
		self.borrarMarcadorActual()
		//Agrega un marcador del nuevo titular de la propiedad
		game.addVisual(new MarcadorDuenio())
	}
	
//Alquileres
 	method pagarAlquiler(propiedad){
 		const alquilerPago = new Popup(img="alquilerPago.png",position=game.at(1,2))
		alquilerPago.addVisual()
		game.schedule(1500,{ alquilerPago.removeVisual() })
 		//Evalúa si el dueño de la Propiedad es dueño de la Región (o de los 4 Trenes)
		const currentRegion = regiones.todasLasRegiones().filter({ r => r.contains(self.currentLocation())}).uniqueElement()
		if (currentRegion.all({p => p.titular() == self.currentLocation().titular()})){
			//Cobra el 100% del valor de la propiedad
			self.pagar(propiedad.alquiler() * 2)
			propiedad.titular().cobrar(propiedad.alquiler()*2)			
			turno.playerOnTurn().currentLocation().animacionDobleAlquiler()
		}else{
			//Paga el alquiler al dueño de la propiedad
			self.pagar(propiedad.alquiler())
			propiedad.titular().cobrar(propiedad.alquiler())
			turno.playerOnTurn().currentLocation().animacionAlquiler()
		}
		game.sound("coins.mp3").play()
	}
	
//Prestamos
	method pedirPrestamo(){
		//Para solicitar Préstamo debe tener alguno disponible y no deber mas de 1400 (porque perdería con más de 2000 de Deuda)
		if (prestamosDisponibles > 0 and deuda <= 1400){
			const prestamoAlBanco = new Popup(img="prestamoAlBanco" + prestamosDisponibles.toString() + ".png",position=game.at(1,2))
			prestamoAlBanco.addVisual()
			//Confirmo con "S" sólo si está el popup en pantalla
			keyboard.s().onPressDo{
				if(juego.popupEnPantalla().contains(prestamoAlBanco)){
				self.confirmarPrestamo()
				prestamoAlBanco.removeVisual()
				}
			}
		//Cancelo con "N", puedo volver a solicitarlo con "O"
		keyboard.n().onPressDo{ prestamoAlBanco.removeVisual() }
		}
		else{
			//Si no le quedan prestamos disponibles o debe más de 1400 abre un popup de historial crediticio.
			const historialCrediticio = new Popup(img="historialCrediticio.png",position=game.at(1,2))
			historialCrediticio.addVisual()
			game.schedule(3000,{ historialCrediticio.removeVisual() })
		}
	}

	method confirmarPrestamo() {
		//Agrega 500 al dinero y anota una deuda de 600, resta 1 prestamo disponible
		dinero += 500
		deuda += 600
		prestamosDisponibles -= 1
		//Sonido
		game.sound("register.mp3").play()
		//Animacion de modificacion del dinero
		const prestamoConfirmado = new DineroModifier(img="mas500-")
		game.schedule(1000, {prestamoConfirmado.animation(4)})
		//Si no es un casillero especial ni es de otro jugador vuelve a ofrecer comprar
		if (!self.currentLocation().esCasilleroEspecial() and self.currentLocation().esDelBanco()){
			game.schedule(2000, {self.reaccionarACasillero()})
		}
	}

	method pagarDeudas(){
		//Condición para que sólo se active si pidió algún prestamo
		if (dinero >= 600 and prestamosDisponibles < 3){
			//Descuenta el dinero, salda la deuda, y añade un préstamo disponible
			dinero -= 600
			deuda -= 600
			prestamosDisponibles +=1
			//Sonido
			game.sound("register.mp3").play()
			//Animacion de modificacion del dinero
			const prestamoConfirmado = new DineroModifier(img="menos600-")
			game.schedule(1000, {prestamoConfirmado.animation(4)})
			//Popup de confirmación de pago de préstamo
			const pagarPrestamo = new Popup(img="pagarPrestamo.png",position=game.at(1,2))
			pagarPrestamo.addVisual()
			game.schedule(3000,{ pagarPrestamo.removeVisual() })
		}else if (dinero >= self.deuda()){
			//Sonido
			game.sound("register.mp3").play()
			//Si acumuló deudas pero no debe fianza ni pidió prestamos. Paga el saldo de la deuda completo.
			self.pagar(self.deuda())
			deuda = 0
			//Popup de confirmación de deudas saldadas.
			const deudasCanceladas = new Popup(img="deudasCanceladas.png",position=game.at(1,2))
			deudasCanceladas.addVisual()
			game.schedule(3000,{ deudasCanceladas.removeVisual() })
		}
		//Consulta por la condicion de victoria o derrota al pagar una deuda.
		self.condicionVictoriaODerrota()
	}
	
	
	method caePreso(){
		//Agrega una deuda de 1000 y establece que debe una fianza.
		self.debeFianza(true)
		deuda += 1000
	}
	
	method pagarFianza(){
		if (dinero >= 1000){
			//Elimina la Deuda descontando el dinero.
			self.debeFianza(false)
			dinero -= 1000
			deuda -= 1000
			//Animacion de modificacion del dinero
			const prestamoConfirmado = new DineroModifier(img="menos1000-")
			game.schedule(1000, {prestamoConfirmado.animation(4)})
			//Sonido
			game.sound("register.mp3").play()
			//Popup de confirmación de pago de fianza
			const fianza = new Popup(img="fianza.png",position=game.at(1,2))
			fianza.addVisual()
			game.schedule(3000,{fianza.removeVisual()})
		}
	}

//Victoria, Derrota, y Evaluación de Condición.
	method condicionVictoriaODerrota(){
		if( juego.jugadores().any({ j => j.dinero() >= 5000 and j.deuda() == 0})){
			juego.jugadores().max({ j => j.dinero() }).victoria()			
		}else if(self.deuda() > 2000){
			self.derrota()
		}
	}

	method victoria(){
		//Crea una nueva pantalla de victoria con el jugador indicado (con animación y música)
		game.clear()
		const winner = new WinScreen(fps=500)
		winner.addVisual()
		game.schedule(500, { song.win().play()} )
		game.schedule(500,{winner.animation(2)})
		game.schedule(32500, {game.stop()})
		//Detiene la canción de la partida
		song.partida().stop()
	}

	method derrota(){
		//Elimina todos los marcadores de duenio del jugador
		self.borrarMarcadores()
		//Agrega todas las propiedades a misPropiedades del Banco
		banco.todasDelBanco(misPropiedades)
		//Transfiere la titularidad de cada una al banco
		misPropiedades.forEach{propiedad => propiedad.transferirA(banco)}
		//Borra las propiedades del jugador
		misPropiedades.clear()
		//Asigna el turno al siguiente jugador		
		const sigTurno = if (turno.turnoJugadorNro() < juego.jugadores().size()) turno.turnoJugadorNro()-1 else 0
		turno.turnoJugadorNro(sigTurno)
		//Remueve al jugador de la lista de jugadores
		juego.jugadores().remove(self)
		//Elimina el jugador de la visual
		game.schedule(2000, {game.removeVisual(self)} )
		//Popup derrota
		const frasesDeDerrota = [0,1,2,3,4,5,6,7,8,9]
		const derrotado = new Popup(img="derrota" + frasesDeDerrota.anyOne().toString() + ".png",position=game.at(2,2))
		game.schedule(3000, { derrotado.addVisual() } )
		game.schedule(3000, { game.sound("lose.mp3").play() })
		game.schedule(7500,{ derrotado.removeVisual() })
		//Evalua si queda un solo jugador y le da la victoria
		game.schedule(7500, { if (juego.jugadores().size() == 1) juego.jugadores().first().victoria() })
		//Dinero y Deudas en 0 (mejora visual del balance en el tablero)
		game.schedule(8000, {self.dinero(0) self.deuda(0)})
	}
	
	method borrarMarcadorActual(){
		game.removeVisual(game.getObjectsIn(turno.playerOnTurn().position()).last())
	}
	
	method borrarMarcadores(){
		//Mapea todas las propiedades del jugador para encontrar los marcadores y los elimina
		const ubicaciones = misPropiedades.map({  p => p.position()  })
		const borrado = ubicaciones.map({u => game.getObjectsIn(u).last()})
		borrado.forEach({
			marcador => game.removeVisual(marcador) 
		})
	}
}

object dir{
	method seguirCamino() =
		if (self.oeste()) turno.playerOnTurn().position().left(1)
		else if (self.norte()) turno.playerOnTurn().position().up(1)
		else if (self.este()) turno.playerOnTurn().position().right(1)
		else turno.playerOnTurn().position().down(1)
	
	method oeste() = turno.playerOnTurn().position().y() == 0 and turno.playerOnTurn().position().x() > 0
	method norte() = turno.playerOnTurn().position().x() == 0 and turno.playerOnTurn().position().y() < game.height()-1
	method este() = turno.playerOnTurn().position().y() == game.height()-1 and turno.playerOnTurn().position().x() < game.width()-1
}
