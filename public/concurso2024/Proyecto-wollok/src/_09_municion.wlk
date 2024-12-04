import wollok.game.*
import _07_personaje.*
import _04_elementosEnEscenario.*

class Municion inherits Objeto {

	const property danio
	const property velocidad
	const property id = self.identity().toString()
	var property enTablero = true

	method salirDisparada()

	method desplazarse()

	override method desactivarFuncionalidades() {
		if (enTablero) {
			game.removeVisual(self)
			game.removeTickEvent(id)
			enTablero = false
		}
	}
}

class MunicionEnemiga inherits Municion {

	override method salirDisparada() {
		game.addVisual(self)
		game.onTick(velocidad, id, { self.desplazarse()})
	}
	
	override method desplazarse() {
		position = self.position().left(1)
		if (self.position().x() < -1) {
			self.desactivarFuncionalidades()
		}
	}
	
	override method serImpactado(objeto) {
		self.desactivarFuncionalidades()
		objeto.serImpactado(self)
	}
	
	override method esMunicionEnemiga() = true

}

class MunicionHombreRobot inherits MunicionEnemiga(danio = 40, image = "arma/Bala_De_Arma_Hombre_Robot.png", velocidad = 100) {}

class MunicionRayoMortifero inherits MunicionEnemiga (danio = 30, image = "Bola_de_fuego.png", velocidad = 30) {}

class RayoNave inherits MunicionEnemiga(danio = 30, image = "Bola_de_fuego_2.png", velocidad = 30) {

	override method desplazarse() {
		position = self.position().down(1)
		if (self.position().y() < 1) {
			self.desactivarFuncionalidades()
		}
	}

}

class MunicionJuan inherits Municion(position = game.at(juan.position().x() + 2, juan.position().y())) {
	
	override method salirDisparada() {
		game.addVisual(self)
		game.onCollideDo(self, { objeto => if(!objeto.esMunicionEnemiga()) objeto.serImpactado(self) objeto.sumarPuntosPorMuerte() })
		game.onTick(velocidad, id, { self.desplazarse()})
	}
	
	override method serImpactado(objeto) {
		self.desactivarFuncionalidades()
	}

	override method desplazarse() {
		position = self.position().right(1)
		if (self.position().x() > game.width()) {
			self.desactivarFuncionalidades()
		}
	}
	
	method usar(){}
}

class BalaDeRifle inherits MunicionJuan(danio = 100, image = "arma/Bala_De_Rifle-26x12.png", velocidad = 70) {}
class BalaDeRevolver inherits MunicionJuan(danio = 50, image = "arma/Bala_De_Revolver-13x10.png", velocidad = 50) {}
class BalaDeFusil inherits MunicionJuan(danio = 40, image = "arma/Bala_De_Fusil-24x9.png", velocidad = 20) {}
