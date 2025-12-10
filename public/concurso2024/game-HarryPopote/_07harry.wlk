import _04visuales.*
import _06sonidos.*
import _03niveles.*


class Personaje {
	
	var property position = game.origin()

	method reiniciar()

	method moverseHaciaArriba(){
		if(self.position().y() < game.height() - 1){ 
		   self.position(self.position().up(1))
		}
	}

	method moverseHaciaAbajo(){
		if(self.position().y() > 0){ // El límite inferior es 0
		   self.position(self.position().down(1))
		}
	}	
	method moverseHaciaIzquierda(){
		if(self.position().x() > 0){ // El límite izquierdo es 0
		   self.position(self.position().left(1))
		}
	}	
	method moverseHaciaDerecha(){
		if(self.position().x() < game.width() - 1){ // El límite derecho es 17
		   self.position(self.position().right(1))
		}
	}

  
  	method colisionarConHarry(){}

}

object harry inherits Personaje {
	var property image = "harry.png"
	var property vidas = 3
	const property fragmentosEncontrados = #{}
	
	override method reiniciar() {
		position = game.origin()
		image = "harry.png"
	}

	method vida() = vidas
	method reiniciarVidas(){vidas = 3}
	method reiniciarFragmentos(){fragmentosEncontrados.clear()}
	
	method perderVida() {    
		vidas = (vidas - 1).max(0)
		game.say(self, "Ups! Me quedan " +vidas+ " vidas")
		if(vidas == 2){
				vida3.remove()
			}else if(vidas == 1){
				vida2.remove()
			}
		position = game.origin()
		if (self.sinVidas()) {
				game.say(self, "Se me terminaron las vidas!!!")
				game.clear()
				nivel1.perderNivel()}
	}
		
	override method moverseHaciaIzquierda(){
		image = "harry2.png"
		super()
	}	
	override method moverseHaciaDerecha(){
		image = "harry.png"
		super()
	}
	
	method mensajeHogwarts() = "Aun no puedes entrar a Hogwarts" 

	method irAHogwarts(){
			game.whenCollideDo(hogwarts, {actor => 

				if (nivel1.puedePasarDeNivel()) {
					nivel1.pasarDeNivel()

				}else{
					game.say(self, self.mensajeHogwarts())
				}
			})
	}

	method sinVidas() = vidas == 0

	method encontrarFragmento(unFragmento){
		fragmentosEncontrados.add(unFragmento)
		if (self.tieneInvitacionCompleta()){
			game.say(self, "Fragmento " + fragmentosEncontrados.size() +"/2")
			game.say(hogwarts, "PUEDES ENTRAR A HOGWARTS")
			self.irAHogwarts()
		}else{
		 	game.say(self, "Fragmento " + fragmentosEncontrados.size() +"/2")		 
		}
		
	}
	method entrarAHogwarts(){		
		nivel2.pasarDeNivel()
	}

	method tieneInvitacionCompleta() = fragmentosEncontrados.size() == visuales.cantidadDeFragmentos()
}



object harryParado inherits Personaje{
	var property image="harryFrente.png"


	override method reiniciar() {
		position = game.at(7,8)
		image = "harryFrente.png"

		}

	override method moverseHaciaIzquierda(){
		image="harryParadoIzquierda.png"
		super()
	}	
	override method moverseHaciaDerecha(){
		image="harryParadoDer.png"
		super()
	}

	override method moverseHaciaArriba(){
		image = "harryEspalda.png"
		super()
	}


	override method moverseHaciaAbajo(){
		image="harryFrente.png"
		super()
	}	
}