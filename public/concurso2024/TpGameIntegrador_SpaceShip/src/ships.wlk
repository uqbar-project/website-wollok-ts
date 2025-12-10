import wollok.game.*
import weapons.*
import juego.*
import sonidos.*
import vidas.*

class Nave {
	var property color 
	var impactado = false
	method disparar()
	
	method explotar()
	method impactado() = impactado
	method impactoLaser() {
		impactado = true
		self.explotar()
		explosion.play()
		self.desaparecer()
	}

	method desaparecer() {
		game.schedule(500, { 
			if(game.hasVisual(self))game.removeVisual(self)
		})
	}
	method cambiarColor(){
	     self.color(self.color().siguiente())
	}
}

class MainShip inherits Nave {
   var position = game.at(game.width() / 2, 0)
   method configurar() {
   	keyboard.space().onPressDo{ self.disparar()}
   	
   }
	method configurarCambio() {
		keyboard.z().onPressDo{self.cambiarColor()}
	}
	
	method image() = if(self.impactado()) "image/explosion-soldado.png" else "image/Main_Ship_" + self.color().toString() + ".png"

	method position() = position

	method position(nuevaPosicion) {
		position = nuevaPosicion
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(color=color, position = game.at(position.x(), position.y() + 1.5))
			sonidoDisparos.play()
			game.addVisual(unLaser)
			unLaser.moverArriba()
		}
	}

	override method impactoLaser() {
		game.sound("assets/whoosh.mp3").play()
		vidas.perderVida()
		if (vidas.vidas() == 0) super()
	}

	override method explotar() {
		
	
	}

	method reiniciar() {
		
		impactado = false
	}

}

class EnemyShip inherits Nave {

	var cuenta = 0
	const limiteCuenta = 11
	var moverADerecha = true
	var property position

	method position() = position

	method moverDerecha() {
		self.position(self.position().right(1))
	
	}

	method moverIzquierda() {
		self.position(self.position().left(1))
	
	}

	method moverAlternado() {
		if (moverADerecha) self.moverDerecha() else self.moverIzquierda()
		moverADerecha = !moverADerecha
	}

	method moverNormal() {
		if (cuenta != limiteCuenta and moverADerecha) {
			self.moverDerecha()
			cuenta += 1
		} else if (cuenta != limiteCuenta and !moverADerecha) {
			self.moverIzquierda()
			cuenta += 1
		} else {
			cuenta = 0
			moverADerecha = !moverADerecha
		}

	}
	
	method dispararCadaCiertoTiempo(){
		const randomInterval = 3000.randomUpTo(6000)
				game.onTick(randomInterval, "enemyFire" + self.identity().toString(), { self.disparar()})
	}
	
	method moverse(){game.onTick(1000, "moverAlternado", { self.moverNormal()})}

	override method impactoLaser() {
		super()
		juego.sumarPunto()
	}

	override method disparar() {
		if (!impactado) {
			const unLaser = new Laser(color=blanco, position = game.at(position.x(), position.y() - 1))
			game.addVisual(unLaser)
			unLaser.moverAbajo()
		}
	}

}

class Capitan inherits EnemyShip {

	var image = "image/captain_" + self.color().toString()+ ".png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		self.image("image/explosion-soldado.png")
	}

}

class Soldado inherits EnemyShip {

	var image = "image/soldier_" + self.color().toString() + ".png"

	method image() = image

	method image(nuevaImagen) {
		image = nuevaImagen
	}

	override method explotar() {
		color=blanco
		self.image("image/explosion-soldado.png")
	}

}

class MotherShip inherits EnemyShip {

	method image() = if (self.impactado()) "image/explosion-soldado.png" else "image/motherShip_"+ self.color().toString() +".png"

	

	

	override method disparar() {
		if (!impactado) {
			const x = 0.randomUpTo(game.width()).truncate(0)
			const unLaser = new Laser(color=blanco, position = game.at(x, position.y() - 1.5))
			
			game.addVisual(unLaser)
			unLaser.moverAbajo()
		}
	}
	
	override method impactoLaser() {
		if (!impactado) {
			vidasMotherShip.perderVida()
			if (vidasMotherShip.vidasMother() == 0) {
				self.explotar()
				juego.youWin()
			}
		}
	}

	override method explotar() {
		game.removeVisual(self)
	}

}
object blanco {
	
	method siguiente() = rojo
}
object rojo {
	method siguiente() = verde
}

object verde {
	method siguiente() = azul
}
object azul {
	method siguiente() = rojo
}

