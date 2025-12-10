import _02juego.*
import _04visuales.*
import _05fondos.*
import _06sonidos.*
import _07harry.*
import _08dementores.*
import _09movimientos.*
import _10colisiones.*
import _11hechizo.*


class Nivel {

	method agregarVisuales() {
		game.addVisual(harry)
		movimientos.configurarControles(harry)
		movimientos.moverseDementores()
	}
	
	method comenzar()
	
		
	method jugarNivel() {
		game.clear()


	}

	method perderNivel() {
		musicaJuego.parar()
		game.removeVisual(fondo1)
		game.addVisual(perdiste)
		perdisteSound.reproducir()
		game.onTick(3000, "reiniciarNivel", {
				perdisteSound.parar()
				self.reiniciarJuego()})

	}

	method reiniciarJuego() {
		ron.reiniciar()
    	hermione.reiniciar()
		
		harry.reiniciar()
		harry.reiniciarVidas()
		harryParado.reiniciar()
        harry.reiniciarFragmentos()
        visuales.enemigos().forEach({unEnemigo => unEnemigo.reiniciar()})
        game.clear() 
		

	}
	

	method pasarDeNivel() {
		musicaJuego.parar()
		game.clear()
		harry.reiniciar()

		
	}

	

}

object nivel1 inherits Nivel() {

	override method comenzar(){
		game.clear()
		game.addVisual(instrucciones1)
		game.onTick(10000, "jugar", {
			self.jugarNivel()
		})
		keyboard.space().onPressDo({
        self.jugarNivel()
		})
	}
	override method agregarVisuales() {
		super()
		visuales.agregarDementores()
		visuales.agregarFragmentos()
		visuales.agregarVidas()
	}
	override method jugarNivel() {
		super()
	  	game.addVisual(fondo1)
		game.addVisual(hogwarts)
		colisiones.configurar(harry)
		self.agregarVisuales()			
		hechizo.deshabilitar()
	}
	


	override method reiniciarJuego() {
		super()
		harry.reiniciarFragmentos()
		visuales.enemigos().forEach({unEnemigo => unEnemigo.reiniciar()})
		self.comenzar()
	}

	override method pasarDeNivel() {
		super()	
		game.addVisual(pasasteAlDos)
		game.onTick(3000, "nivel2", {
			nivel2.comenzar()
		})
	}

	method puedePasarDeNivel() = harry.tieneInvitacionCompleta()
}

object nivel2 inherits Nivel {

  override method comenzar() {
	game.clear()
    game.addVisual(instrucciones2)               
    keyboard.space().onPressDo({ self.jugarNivel() })
    game.onTick(7000, "Jugar Nivel 2", { self.jugarNivel() })
  }
  override method agregarVisuales() {
	super()                                      
	visuales.agregarDementores()
	visuales.agregarVidas()           
  }

 override method jugarNivel() {
    super()                                      
    game.addVisual(fondoNivel2)                       
    game.removeTickEvent("Jugar Nivel 2") 
    colisiones.configurar(harry) 
    self.agregarVisuales()       
    hechizo.reset()        
    hechizo.habilitar()
}
  
    override method perderNivel() {
    hechizo.reset()
    hechizo.deshabilitar()
    super()
  }

  override method reiniciarJuego() {
    hechizo.reset()
    hechizo.deshabilitar()
	nivel1.comenzar()

    super()
  }

	override method pasarDeNivel() {
    game.clear()
	game.addVisual(instrucciones3)               

	game.onTick(3000, "nivel3",{nivel3.comenzar()})
	}

}





object nivel3 inherits Nivel {

  override method comenzar() {
    keyboard.space().onPressDo({ self.jugarNivel() })
    game.onTick(3000, "Jugar Nivel 3", { self.jugarNivel() })
  }
  override method agregarVisuales() {
	harryParado.reiniciar()
	game.addVisual(harryParado)
	game.addVisual(hermione)
	game.addVisual(ron)
	movimientos.configurarControles(harryParado)             
  }

 override method jugarNivel() {
    super()                                      
    game.addVisual(fondoFin)                       
    game.removeTickEvent("Jugar Nivel 3") 
    colisiones.configurar(harryParado) 
    self.agregarVisuales()       
    hechizo.reset()        
    hechizo.deshabilitar()
	}

	override method pasarDeNivel() {
	game.addVisual(fondoFinal) 

	keyboard.space().onPressDo({ musicaJuego.parar()
    game.clear()
	game.onTick(3000, "reiniciarJuego", { 
        self.reiniciarJuego()
	game.removeTickEvent("reiniciarJuego") 
		 })
        })
	}

	override method reiniciarJuego(){
		super()
		juego.iniciar() 
	}
	





}
