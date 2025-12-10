import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import pantallaInicio.*


//nivel 1 (hijo de "niveles")
class Nivel1 inherits Nivel {

	const personas = [
			new Persona(nivelActual=self),new Persona(nivelActual=self),
			new Persona(nivelActual=self),new Persona(nivelActual=self),
			new Persona(nivelActual=self),new Persona(nivelActual=self)

		]

	override method configurate() {//configura el nivel 1
		super()
		estadoJuego.cambiarNivelActual("nivel1")
		const fondoCasa_level1 = new Fondo(image="fondoCasa_level1.png",position = game.at(0, 0))
		game.addVisual(fondoCasa_level1)
		vidaGrimly.iniciarBarraDeVida()
		puntaje.iniciarBarraDePuntos(0)
		self.ponerElementos(1, enemigos)
		self.ponerElementos(2, pociones)
		self.ponerElementos(5, trampas)
		self.ponerElementos(6, personas)
		grimly.resetPosition()
		game.addVisual(grimly)
		grimly.actualizarNivelActual(self)
		enemigos.forEach({e => e.acercarseA(grimly)
							   game.whenCollideDo(e, {grimly => e.atrapar(grimly)})
		 })

		trampas.forEach({t => game.whenCollideDo(t, {grimly => grimly.accionarObjeto(t)})})
		personas.forEach({p => p.moverseAleatorio() })
		pociones.forEach({po => game.whenCollideDo(po, {grimly => grimly.accionarObjeto(po)})})
    	
    }	
	override method personas(){
		return personas
	}

}