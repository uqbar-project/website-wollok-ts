import wollok.game.*
import pantalla.*
import jugadores.*
import tablero.*
import cartas.*
import balance.*
import propiedades.*
import teclado.*

object juego{
	var property popupEnPantalla = []
	const property jugadores = []
	
	method partidaIniciada() = !jugadores.isEmpty()
	
	method iniciar(){
		//Configuraciones
		game.width(9)
		game.height(9)
		game.cellSize(128)
		game.boardGround("boardground.png")
		game.title("Argentópolis")		
		
		//Pantalla Inicio
		tablero.startMenu().addVisual()
		tablero.titulo().addVisual()
		tablero.titulo().animation(2)

		//Configuraciones de teclado
		teclado.configuracion()
		
		game.start()
	}

	//Agrega Jugadores e inicia la partida.
    method iniciarPartida(players){
        tablero.generarTablero()
		jugadores.addAll(players)
        jugadores.forEach{ j => game.addVisual(j)}
        self.mostrarBalance()
        game.onCollideDo(salida, {player => turno.playerOnTurn().cobrarSalario()})
    }
	
	method mostrarBalance(){
		jugadores.forEach{ j =>
			const balance = new Balance(unJugador=j)
			balance.addVisual()
		}
	}
	
}

object turno{
	var turnoJugadorNro = 0
	
	//Retorna o establece el Nro de Jugador activo en este turno
	method turnoJugadorNro() = turnoJugadorNro+1
	method turnoJugadorNro(jugador){turnoJugadorNro = jugador}
	method playerOnTurn() = juego.jugadores().get(turnoJugadorNro)
	method playerOnTurn(jugador){juego.jugadores().get(jugador)}
	
	method endTurn(){
		//Reestablece el turno y la tirada de dados del jugador del siguiente turno
		self.playerOnTurn().yaTiro(false)
		self.playerOnTurn().finDeTurno(false)
		//Asigna el turno al siguiente jugador y lo indica en un popup
		turnoJugadorNro = if (turnoJugadorNro == juego.jugadores().size()-1) 0 else turnoJugadorNro+1
		const imgPlayerTurn = new Popup(img = self.playerOnTurn().nombre().toString() + "turn.png",position=game.at(1,2))
		imgPlayerTurn.addVisual()
		game.schedule(1000, {imgPlayerTurn.removeVisual()} )
	}

	
	
}

object song{
	const property menu = game.sound("muchachos.mp3")
	const property partida = game.sound("zambaDeMiEsperanza.mp3")
	const property win = game.sound("winSong.mp3")

	method menuSong(){
		self.menu().shouldLoop(true)
		self.menu().play()
	}

	method gameSong(){
		self.partida().shouldLoop(true)
		game.schedule(300,{self.partida().play()})
	}
}

