import wollok.game.*
import _07_personaje.*
import _09_municion.*
import _04_elementosEnEscenario.*

class ArmaDeJuan {
	var property estaSobrecalentado = false
	const property cadencia
	
	method atacar()
	method enfriar() {
		self.estaSobrecalentado(true)
		game.schedule(cadencia, {self.estaSobrecalentado(false)})
	}
	method juanApuntando()
	method juanArmaReposo()
}

object rifle inherits ArmaDeJuan (cadencia = 700){

	override method atacar() {
		const proyectil = new BalaDeRifle()
		proyectil.salirDisparada()
		self.enfriar()
	}
     override method juanApuntando() = "juanSalvo/Juan_Rifle_Apuntar-176x192.png"
     override method juanArmaReposo() = "juanSalvo/Juan_Rifle-Reposo-176x192.png"
}

object revolver inherits ArmaDeJuan (cadencia = 500) {
	
	override method atacar() {
		const proyectil = new BalaDeRevolver()
		proyectil.salirDisparada()
		self.enfriar()
	}
	override method juanApuntando() = "juanSalvo/Juan_Revolver_Apuntar-176x192.png"
	override method juanArmaReposo() = "juanSalvo/Juan_Revolver_Reposo-176x192.png"
}

object fusil inherits ArmaDeJuan (cadencia = 300) {
	override method atacar() {
		const proyectil = new BalaDeFusil()
		proyectil.salirDisparada()
		self.enfriar()
	}
	override method juanApuntando() = "juanSalvo/Juan_Fusil_Apuntar-176x192.png"
	override method juanArmaReposo() = "juanSalvo/Juan_Fusil_Reposo-176x192.png"
}

class RayoTerrenal inherits Objeto {
	var property cadencia

	method atacar() {
		game.schedule(cadencia, { const rayo = new MunicionRayoMortifero(position = game.at(self.position().x() - 1, self.position().y()))
			rayo.salirDisparada()
		})
	}
	
	override method serImpactado(objeto) {
		vidaEscudoRayo.danioRecibido(objeto)
	}
	
	method explotar() {
		image = "explosion.png"
		game.removeVisual(self)
		game.addVisual(self)
	}
}

object rayo1 inherits RayoTerrenal(position = game.at(16, 1), image = "lanza_rayos (2) (1).png", cadencia = (0 .. 1000).anyOne()) {}
object rayo2 inherits RayoTerrenal(position = game.at(16, 3), image = "lanza_rayos (2) (1).png", cadencia = (1000 .. 2000).anyOne()) {}


object nave inherits Objeto(position = game.at(18, 8), image = "nave_alien.png"){
	var property cadencia = 1000

	method atacar() {
		position = game.at((0 .. 14).anyOne(), game.height() - 2)
		game.addVisual(self)
		const rayo = new RayoNave(position = game.at(self.position().x(), self.position().y() - 1))
		rayo.salirDisparada()
		game.schedule(cadencia, { game.removeVisual(self)})
	}
}