import wollok.game.*
import weapons.*
import juego.*
import ships.*
import sonidos.*
import tablero.*

object vidas {

	const position = game.at(1, 18)
	var property vidas = 2

	method image() = "image/"+self.vidas().toString()+"vidas.png"

	method vidas() = vidas

	method position() = position

	method perderVida() {
		vidas = vidas - 1
		if (vidas == 0) game.schedule(1000, {juego.gameOver()})
	}

	method reiniciarVidas() {
		vidas = 2
	}
	method impactoLaser(){
		//para que no cause problemas el impacto del laser
	}
	
	method color() = ""

}

object vidasMotherShip {

	const position = game.at(25, 18)
	var vidasMother = 4

	method image() = "image/barra"+ vidasMother.toString() + ".jpeg"

	method vidasMother() = vidasMother

	method position() = position

	method perderVida() {
		vidasMother = vidasMother - 1
		
		if (vidasMother == 0) {
			juego.youWin()
		}
	}
	method reiniciarVidas(){
		vidasMother = 4
		
	}
	method color(){
	
	}
}
