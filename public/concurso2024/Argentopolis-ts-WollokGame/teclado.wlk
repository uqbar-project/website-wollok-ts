import wollok.game.*
import juego.*
import pantalla.*
import jugadores.*
import tablero.*


object teclado{
	
	method configuracion(){
		//Movimientos de Selector
		keyboard.up().onPressDo{
			if (!juego.partidaIniciada())
			tablero.selector().moveUp()
		}
		keyboard.down().onPressDo{if (!juego.partidaIniciada())
			tablero.selector().moveDown()}
	
		//Empezar partida (Selecciona cantidad de jugadores, elimina Start Menu y genera el tablero)
		keyboard.enter().onPressDo{
			if (game.hasVisual(tablero.selectPlayerScreen())){
				const player1 = new Player(img = "jugador1.png", nombre="player1",numero=1)
				const player2 = new Player(img = "jugador2.png", nombre="player2",numero=2)
				const player3 = new Player(img = "jugador3.png", nombre="player3",numero=3)
				const player4 = new Player(img = "jugador4.png", nombre="player4",numero=4)
		
				if (!juego.partidaIniciada() and tablero.selector().position().y() == 8){
					juego.iniciarPartida([player1,player2])
				}
				else if (!juego.partidaIniciada() and tablero.selector().position().y() == 7){
					juego.iniciarPartida([player1,player2,player3])
				}
				else if (!juego.partidaIniciada() and tablero.selector().position().y() == 6){
					juego.iniciarPartida([player1,player2,player3,player4])
				}
			}
			else{
				tablero.generarMenu()
			}
		}
		
		//Mostrar instrucciones
		keyboard.i().onPressDo{
			if (!game.hasVisual(tablero.instrucciones1()) and
				!game.hasVisual(tablero.instrucciones2()) and
				!game.hasVisual(tablero.teclas())
			){game.addVisual(tablero.instrucciones1())}
			else if(game.hasVisual(tablero.instrucciones1())){
				game.removeVisual(tablero.instrucciones1())
			}else if(game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
			}else {game.removeVisual(tablero.teclas())}
		}
		
		keyboard.right().onPressDo{
			if (game.hasVisual(tablero.instrucciones1())){
				game.removeVisual(tablero.instrucciones1())
				game.addVisual(tablero.instrucciones2())}
			else if (game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
				game.addVisual(tablero.teclas())}
		}
		keyboard.left().onPressDo{
			if (game.hasVisual(tablero.teclas())){
				game.removeVisual(tablero.teclas())
				game.addVisual(tablero.instrucciones2())}
			else if (game.hasVisual(tablero.instrucciones2())){
				game.removeVisual(tablero.instrucciones2())
				game.addVisual(tablero.instrucciones1())}
		}
		
		//Tirar dados
		keyboard.space().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty()){
				turno.playerOnTurn().tirarDados()}
			}
		
		//Comprar propiedad a otro jugador
		keyboard.t().onPressDo{
			//Retorna la región actual
//			const currentRegion = regiones.todasLasRegiones().filter({ r => r.contains(turno.playerOnTurn().currentLocation())}).uniqueElement()
			
			if (juego.partidaIniciada() and !turno.playerOnTurn().currentLocation().esCasilleroEspecial()){ //Valida que no sea casillero especial
				if (turno.playerOnTurn().dinero() < turno.playerOnTurn().currentLocation().costo()*1.5){
					const dineroInsuficiente = new Popup(img="dineroInsuficiente.png",position=game.at(1,2))
					dineroInsuficiente.addVisual()
					game.schedule(1500,{ dineroInsuficiente.removeVisual() })
				}
				else if (!turno.playerOnTurn().currentLocation().esDelBanco() and //Valida si el dueño de la ubicación actual es dueño de la region completa
					turno.playerOnTurn().esTerrateniente(turno.playerOnTurn().currentRegion())){
					const terrateniente = new Popup(img="terrateniente.png",position=game.at(1,2))
					terrateniente.addVisual()
					game.schedule(2000,{ terrateniente.removeVisual() })
				}
				else if (!juego.jugadores().isEmpty() and
						!turno.playerOnTurn().currentLocation().esDelBanco() and
						!turno.playerOnTurn().mePertenece(turno.playerOnTurn().currentLocation())){
					turno.playerOnTurn().transferencia()
				}
			}
		}

		//Pedir Prestamo y Pagar Deudas
		keyboard.o().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty()){
				turno.playerOnTurn().pedirPrestamo()}
		}
		keyboard.p().onPressDo{
			if (!juego.jugadores().isEmpty() and juego.popupEnPantalla().isEmpty() and turno.playerOnTurn().deuda() > 0){
				if (turno.playerOnTurn().debeFianza()) turno.playerOnTurn().pagarFianza()
				else turno.playerOnTurn().pagarDeudas()}
		}
		
		//Finalizar turno
		keyboard.f().onPressDo{
			if (juego.partidaIniciada() and		//Valida que haya comenzado la partida 
				juego.popupEnPantalla().isEmpty() and	//Valida que no hay otro popup abierto
				turno.playerOnTurn().finDeTurno())	//Valida que ya terminó el turno
					{turno.endTurn()}
		}
		
	}
}