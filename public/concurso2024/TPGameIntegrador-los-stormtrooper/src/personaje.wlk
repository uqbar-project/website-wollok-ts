import objetos.*
import fantasma.*
import gameOver.*
//import wollok.game.*
import musicaSonido.*

/*--INDICE--
	-atributos
	-config teclas
	-irA (method para uvicar al personaje)
	-restar vida 
	-morir (acciona gameover)
	-animacion de sprite
		estados
		cambio de sprite
	-damage (efecto por daño)
	-barra de vida (actualiza y muestra la cantidad de corazones)
	-sacar vida (resta corazones)
	*/


object personaje {
  	var property position = game.origin()
  	var property image = "personajeR.png"
  	var property inicioDePartida = true
  	var property ubicacion = "vacio"
  	var property estado = true
	var property personajeVida = 4
	var orientacion = 1
	var property dificultad = 0
	var property graficosAltos = true

//------------------------------------------------------------------------Control del personaje
	method configurarTeclas() {
		//Left
		keyboard.a().onPressDo({ 
			if(topeIzq.position().x()+1 < self.position().x() )//puertaAComedor.position().x()+1  //&& 1 < self.position().x()
				self.position(self.position().left(1))
				image = "personajeL.png"
				orientacion = 4
			})
		//right
		keyboard.d().onPressDo({
			if(topeDer.position().x()-1 > self.position().x()) //no se //game.width()-2 > self.position().x()  && 
			 	self.position(self.position().right(1))
				image = "personajeR.png"
				orientacion = 2
			 })
		//down
		keyboard.s().onPressDo({ 
			if(topeAbajo.position().y()+1 < self.position().y())//1 < self.position().y() && 
				self.position(self.position().down(1))
				image = "personajeD.png"
				orientacion = 3
			})
		//up
		keyboard.w().onPressDo({
			if(topeArriba.position().y()-1 > self.position().y()) //no se /*game.height()-2 > self.position().y() && */
			 	self.position(self.position().up(1))
				image = "personajeU1.png"
				orientacion = 1
			 })
	}

//-------------------------------------------------------------Reubicador de personaje
  	method irA(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
//----------------------------------------------------------------------------VIDA
	method restarVida() {
	  personajeVida = personajeVida -1
	}

	method morir() {
	  if(personajeVida == 0){
		gameOver.iniciar()
	  }
	}

//---------------------------------------------------------------------------Animador de personaje
	method animacion() {
	  game.onTick(400,"estados",{=> self.estados()})
	}

	method estados() {
		if(orientacion ==1)//arriba
			self.CambioDeSprite("personajeU1.png","personajeU2.png")

		else if(orientacion ==2)//derecha
			self.CambioDeSprite("personajeR.png","personajeR2.png")

		else if(orientacion ==3)//abajo
			self.CambioDeSprite("personajeD.png","personajeD2.png")

		else if(orientacion ==4)//izquierda
			self.CambioDeSprite("personajeL.png","personajeL2.png")

	}

	method CambioDeSprite(imagen1,imagen2) {
	  	if(estado){
			image = imagen1
			estado = !estado
		}
		else{
			image = imagen2
			estado = !estado
		}
	}
}

//-------------pantallaroja de damage
object damage {
  const property image = "damage.png"
  var property position = game.origin()
}

//---------------------------actualiza los corazones cada vez que cambia de pantalla
object barraDeVida {
  method mostrarVidas() {
	if(personaje.personajeVida() ==4){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
		game.addVisual(corazon4)
	}
	else if(personaje.personajeVida() ==3){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
	}
	else if(personaje.personajeVida() ==2){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
	}
	else
		game.addVisual(corazon1)
  }
//--------------------------------elimina los corazones a medida que pierde vida
  method sacarVidas() {
	if(personaje.personajeVida() ==3){
		game.removeVisual(corazon4)
	}
	else if(personaje.personajeVida() ==2){
		game.removeVisual(corazon3)
	}
	else{
		game.removeVisual(corazon2)
	}
  }
}
