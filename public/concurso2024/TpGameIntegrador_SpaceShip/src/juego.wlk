import wollok.game.*
import ships.*
import sonidos.*
import tablero.*
import vidas.*

object juego {

	
	var property modo = normal
	var property puntos = 0
	const tableroInicial = new Tablero(position=game.at(0,0), image="image/inicio.png")
	const tableroGameOver = new Tablero(position=game.at(9, 10), image="image/gameOver.png")
	const tableroYouWin = new Tablero(position=game.at(5, 5), image="image/tableroWin.png")
	const tableroInstrucciones = new Tablero(position=game.at(0, 0), image="image/intrucciones2.jpeg")
	

	method configurar() {
		game.cellSize(32)
		game.height(20)
		game.width(32)
		game.title("Space Ship")
		game.boardGround("image/spaceBG.jpg")
	}

	method iniciarJuego() {
		musicaDeFondo.iniciar()
		self.configurar()
		self.pantallaInicial()
		game.start()
		
	}

	method pantallaInicial() {
		keyboard.enter().onPressDo{ self.juegoPrincipal()}
		keyboard.down().onPressDo{ modo = dificil}
		keyboard.up().onPressDo{ modo = normal}
		keyboard.space().onPressDo{ self.pantallaInstrucciones()}
		game.addVisual(tableroInicial)
		game.addVisual(tableroDificultad)
		
	}

	method pantallaInstrucciones() {
		keyboard.x().onPressDo{ game.removeVisual(tableroInstrucciones)}
		game.addVisual(tableroInstrucciones)
	}

	method juegoPrincipal() {
		game.clear()
		self.iniciar()
	}

	method iniciar() {
	    self.modo().agregarCapitanes(15)
	    self.modo().agregarSoldados(13)
	    self.modo().agregarPlayer()
	
		game.addVisual(vidas)
	}

	method gameOver() {
		game.clear()
		game.addVisual(tableroGameOver)
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
		musicaDeFondo.sacarMusica()
		sonidoGameOver.play()
	}

	method youWin() {
		game.clear()
		musicaDeFondo.sacarMusica()
		sonidoWin.play()
		game.addVisual(tableroYouWin)
		keyboard.enter().onPressDo{ self.reiniciarJuego()}
	}

	method jefeFinal() {
		game.clear()
		self.modo().agregarMotherShip()
		self.modo().agregarPlayer()
		vidas.reiniciarVidas()
		game.addVisual(vidas)
	}

	method reiniciarJuego() {
		game.clear()
		musicaDeFondo.reiniciar()
		vidas.reiniciarVidas()
		vidasMotherShip.reiniciarVidas() // Reiniciar las vidas
		self.reiniciarPuntos() // Reiniciar los puntos
	
		self.pantallaInicial() // Iniciar el juego principal
		
	}
	
	method sumarPunto() {
		puntos = puntos + 1
		if (puntos == 12) self.jefeFinal()
	}

	method reiniciarPuntos() {
		puntos = 0
	}

}
object normal {

	method agregarPlayer() {
			const mainShip = new MainShip(color = blanco)
			game.addVisualCharacter(mainShip)
			mainShip.configurar()
		
	}
	
	method agregarMotherShip() {
		const motherShip = new MotherShip(color = blanco, position = game.at(6, 16))
		
		game.addVisual(motherShip)
		game.addVisual(vidasMotherShip) // agrega las vidas
		motherShip.moverse()
		game.onTick(200, "enemyFire" + self.identity().toString(), { motherShip.disparar()})
		
	}
	method agregarSoldados(ejeY) {
		const filaSoldados = [ new Soldado(color=blanco, position=game.at(3,ejeY)), new Soldado(color=blanco, position=game.at(6,ejeY)), new Soldado(color=blanco, position=game.at(9,ejeY)), new Soldado(color=blanco, position=game.at(12,ejeY)), new Soldado(color=blanco, position=game.at(15,ejeY)), new Soldado(color=blanco, position=game.at(18,ejeY)) ]
		
		filaSoldados.forEach{ soldier =>
				game.addVisual(soldier)
				soldier.moverse()
				soldier.dispararCadaCiertoTiempo()		
			}
	
	}
	method agregarCapitanes(ejeY) {
		const filaCapitan = [ new Capitan(color=blanco, position=game.at(1,ejeY)), new Capitan(color=blanco, position=game.at(4,ejeY)), new Capitan(color=blanco, position=game.at(7,ejeY)), new Capitan(color=blanco, position=game.at(10,ejeY)), new Capitan(color=blanco, position=game.at(13,ejeY)), new Capitan(color=blanco, position=game.at(16,ejeY)), new Capitan(color=blanco, position=game.at(19,ejeY)) ]
	
			filaCapitan.forEach{ soldier =>
				game.addVisual(soldier)
				soldier.moverse()
				soldier.dispararCadaCiertoTiempo()
			}
		
	}
}

object dificil {
	method agregarPlayer() {
			const mainShip = new MainShip(color = rojo)
			game.addVisualCharacter(mainShip)
			mainShip.configurar()
			mainShip.configurarCambio()
		
	}
	method agregarMotherShip() {
		const motherShipCol = new MotherShip(color = rojo, position = game.at(6, 16))
		
			game.addVisual(motherShipCol)
			game.addVisual(vidasMotherShip) // agrega las vidas
			motherShipCol.moverse()
			game.onTick(200, "enemyFire" + self.identity().toString(), { motherShipCol.disparar()})
			game.onTick(1200, "alternarColores" + self.identity().toString(), { motherShipCol.cambiarColor()})
	
	}

	method agregarSoldados(ejeY) {
		const filaSoldadosCol = [ new Soldado(color=verde, position=game.at(3,ejeY)), new Soldado(color=verde, position=game.at(6,ejeY)), new Soldado(color=verde, position=game.at(9,ejeY)), new Soldado(color=verde, position=game.at(12,ejeY)), new Soldado(color=verde, position=game.at(15,ejeY)), new Soldado(color=verde, position=game.at(18,ejeY)) ]

			filaSoldadosCol.forEach{ soldier =>
				game.addVisual(soldier)
				soldier.moverse()
				soldier.dispararCadaCiertoTiempo()
			}
		
	}

	method agregarCapitanes(ejeY) {
		const filaCapitanCol = [ new Capitan(color=rojo, position=game.at(1,ejeY)), new Capitan(color=azul, position=game.at(4,ejeY)), new Capitan(color=rojo, position=game.at(7,ejeY)), new Capitan(color=azul, position=game.at(10,ejeY)), new Capitan(color=rojo, position=game.at(13,ejeY)), new Capitan(color=azul, position=game.at(16,ejeY)), new Capitan(color=rojo, position=game.at(19,ejeY)) ]
	
			filaCapitanCol.forEach{ soldier =>
				game.addVisual(soldier)
				soldier.moverse()
				soldier.dispararCadaCiertoTiempo()

		}
	
	}
}