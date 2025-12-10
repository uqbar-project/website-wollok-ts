import wollok.game.*
import ships.*

class Laser {
	
	var property color
	var property position


	method position() = position
	method esDelMismoColor(algo) {
		return self.color() == algo.color()
	}
	method image() = "image/laser_"+ self.color().toString() + ".png"
	method moverArriba() {
		game.onTick(50, self.identity().toString(), { self.desplazarArriba()})
		game.onCollideDo(self, { algo =>
			if(self.esDelMismoColor(algo)){
				algo.impactoLaser()
				self.impactoLaser()
			}
		})
	}

	method moverAbajo() {
		game.onTick(200, self.identity().toString(), { self.desplazarAbajo()})
		game.onCollideDo(self, { algo =>
			algo.impactoLaser()
			self.impactoLaser()
		})
	}

	method impactoLaser() {
		game.removeTickEvent(self.identity().toString())
		game.removeVisual(self)
	}

	method desplazarArriba() {
		if (position.y() >= game.height()) {
			self.impactoLaser()
		} else position = position.up(1)
	}

	method desplazarAbajo() {
		if (position.y() < 0) {
			self.impactoLaser()
		} else {
			position = position.down(2)
		}
	}

}

