import wollok.game.*
import niveles.*
import fantasma.*
import personas.*
import cazafantasmas.*
import puntaje.*
import items.*
import controles.*
import pantallaInicio.*
import nivel1.*
//nivel 2 (hijo de "niveles")
class Nivel2 inherits Nivel {

  const personas = [
		new Persona(nivelActual=self),new Persona(nivelActual=self),
		new Persona(nivelActual=self),new Persona(nivelActual=self),
		new Persona(nivelActual=self),new Persona(nivelActual=self)
	]
  
  override method configurate() {//configura el nivel 2
		super()
		estadoJuego.cambiarNivelActual("nivel2")
		const fondoCasa_level2 = new Fondo(image="fondoCasa_level2.png",position = game.at(0, 0))
		game.addVisual(fondoCasa_level2)
		vidaGrimly.iniciarBarraDeVida()
		puntaje.iniciarBarraDePuntos(0)
		self.ponerElementos(2, enemigos)
		self.ponerElementos(1, pociones)
		self.ponerElementos(9, trampas)
		self.ponerElementos(6, personas)
		grimly.resetPosition()
		grimly.actualizarNivelActual(self)
		game.addVisual(grimly)
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