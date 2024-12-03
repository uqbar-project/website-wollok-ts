import wollok.game.*
import juego.*
import pantalla.*
import tablero.*
import cartas.*

class Casillero{ //Clase Base
	var property position
	const img
	
	method image() = img
	method esCasilleroEspecial() = false
}

class Provincia inherits Casillero{
	var titular = banco
	
	method costo() = 400
	method alquiler() = self.costo() * 0.5
	
	method titular() = titular
	method transferirA(nuevoTitular){titular = nuevoTitular}
	method esDelBanco() = banco.misPropiedades().contains(self)
	
	method activarCasillero(){
		//Si es del banco y tienes dinero ofrece comprarla
		if (turno.playerOnTurn().puedeComprar(self) and self.esDelBanco()){
			turno.playerOnTurn().comprar(self)}
		else if (!self.esDelBanco() and !turno.playerOnTurn().mePertenece(self)){ //Si no es del banco, y no me pertenece, paga alquiler
			turno.playerOnTurn().pagarAlquiler(self)}
		else if (!turno.playerOnTurn().puedeComprar(self) and !turno.playerOnTurn().mePertenece(self)){ //Si no tienes dinero suficiente abre un popup avisandolo.
			turno.playerOnTurn().noTienesDinero()}		
	}
	
	method animacionCompra(){
		const comprarPropiedad = new DineroModifier(img="menos400-")
		comprarPropiedad.animation(4)
	}
	
	method animacionAlquiler(){
		const alquiler = new DineroModifier(img="menos200-")
		alquiler.animation(4)
	}
	
	method animacionDobleAlquiler(){
		const alquilerX2 = new DineroModifier(img="menos400-")
		alquilerX2.animation(4)
	}
	
	method animacionTransferencia(){
		const transferirPropiedad = new DineroModifier(img="menos600-")
		transferirPropiedad.animation(4)
	}
}

class Tren inherits Provincia{
	override method costo() = 1000
	
	override method animacionCompra(){
		const comprarTren = new DineroModifier(img="menos1000-")
		comprarTren.animation(4)
	}
	
	override method animacionAlquiler(){
		const alquilerTren = new DineroModifier(img="menos500-")
		alquilerTren.animation(4)
	}
	
	override method animacionDobleAlquiler(){
		const alquilerTrenX2 = new DineroModifier(img="menos1000-")
		alquilerTrenX2.animation(4)
	}
	
	override method animacionTransferencia(){
		const transferirTren = new DineroModifier(img="menos1500-")
		transferirTren.animation(4)
	}
}

object salida{
	method esCasilleroEspecial() = true
	method position() = game.at(8,0)
	method image() = "salida.png"
	
	method activarCasillero(){
		turno.playerOnTurn().cobrarSalario()
		const cobrasDoble = new Popup(img="cobrasDoble.png",position=game.at(1,2))
		cobrasDoble.addVisual()
		game.schedule(3000,{ cobrasDoble.removeVisual() })
	}
}

class CasilleroEspecial inherits Casillero{
	override method esCasilleroEspecial() = true
}

class Carcel inherits CasilleroEspecial{
	method activarCasillero(){
		turno.playerOnTurn().caePreso()
		game.sound("guardia.mp3").play()
		const preso = new Popup(img="preso.png",position=game.at(2,2))
		preso.addVisual()
		game.schedule(3000,{preso.removeVisual()})
	}
}

class CasilleroSuerte inherits CasilleroEspecial{
	method activarCasillero(){
		const randomLuckyCard = new Suerte()
		randomLuckyCard.activar()
	}
}

class CasilleroMufa inherits CasilleroEspecial{
	method activarCasillero(){
		const randomMufaCard = new Mufa()
		randomMufaCard.activar()
	}
}
