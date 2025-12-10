import vida.*
import wollok.game.*
import letras.*
import pantallas.*
import puntuacion.*
import sonido.*

    

object juego{
	var property estaEnMenu = true
	var property estaJugando = false
	var property perdio = false	
	var property dificultad = null
	const posicionesPosibles = []
	
	
	var posiciones = [[13,14,15,16],[25,26,27,28],[0,1,2,3],[30,31,32,33,34,35],[19,20,21,22],[7,8,9,10]]	
	
	const property musica = new Sonido(cancion = "musicaMenu2.mp3")

	const property listaLetras = #{}
    var property letrasNoEnPantalla = #{}

	
	
	method iniciar(){
		//configura el juego 		 
			game.cellSize(15)
			game.width(40)
			game.height(40)	
  			game.title("bombardeo de letras")
			game.addVisual(menu)
		// setea los botones para elegir la dificultad  	
			keyboard.num1().onPressDo({self.modoFacil()})
			keyboard.num2().onPressDo({self.modoDificil()})
			keyboard.num3().onPressDo({self.comoJugar()})
			keyboard.num4().onPressDo({self.menu()})
		// reproduce la musica, por alguna razon lo hice por separado
			self.configuracion()
			
		// inicia el juego
			game.start()			   		
	}

	method configuracion(){
		musica.reproducir(true)
			
	}
	

	method modoFacil(){
		// setea el modo facil y lo comienza
		dificultad = new Facil(vel = 1000, cant = 5, image = "modoFacil2.png",musica =new Sonido( cancion ="musicaFacil.mp3"))
		dificultad.configuracion()

		// agrega letras a la lista de las letras que no estan en pantalla
		letrasNoEnPantalla = #{ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}			
	}
	
	method modoDificil(){
		// setea el modo dificil y lo comienza
		dificultad = new Dificil(vel = 500, cant = 8 , image = "modoDificil2.png",musica = new Sonido(cancion ="musicaDificil.mp3"))		
		dificultad.configuracion()

		letrasNoEnPantalla = #{ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
		
	}

	method comoJugar(){
		game.removeVisual(menu)
		game.addVisual(comoJugar)
	}

	method menu(){
		game.removeVisual(comoJugar)
		game.addVisual(menu)
	}

	method cambiarDificultad(unaDificultad){
		// cambia la dificultad por una nueva para que 
		// la dificultad cuando se ejecuta, cambia la dificultad actual
		dificultad = unaDificultad
	}

	method reiniciar(){
		//muestra el menu, despues de la pantalla de game over
		if(perdio){			
	  		game.removeVisual(gameOver) // saca la escena del game over
			game.addVisual(menu) // muestra el menu
			puntos.removeVisual() // oculta la puntuacion final hecha por el jugador
			puntos.resetearPuntuacion() // setea la puntuacion a 0
			controlPuntaje.resetarControlPuntaje() // resetea los limites de puntajes para el aumento de dificultad
			controlPuntaje.resetearLimiteMasLetras() //resetea los limites de puntajes para la aparicion de mas letras a la vez	
			controlPuntaje.resetearLimiteColores() //resetea los limites de puntajes para la aparicion de letras de colores
			gameOver.musica().parar() // para la musica de la escena game over
			self.configuracion() // reproduce la musica de menu
	
	 		estaEnMenu = true
			perdio = false			
		}       
    }

	method rendirse(){
		// hace que se muestre la escena del game over
		gameOver.configuracion()
	}	

	method agregarLetraSiEsPosible(unaCantidad,velocidad){	

		const letra = self.abc().anyOne()
		

		if(not self.hayLetraRepetida(letra)){
			letra.cambiarPosicion(self.algunaPosicion())
			letra.addVisual()
			letra.iniciarCaida(velocidad)

			listaLetras.add(letra)	

			//listaLetras.add(letra.letra())			
			//keyboard.letter(letra.letra()).onPressDo({letra.destruir()})	
			dificultad.checkRotar(letra)
			
		}
	}

	method algunaPosicion(){		
		self.reiniciarPosiciones()		
		posicionesPosibles.add(posiciones.first())
		posiciones.remove(posiciones.first())
		return posicionesPosibles.last().anyOne()
	}

	method reiniciarPosiciones(){
		if(posiciones.isEmpty()){
		  posiciones = [[13,14,15,16],[25,26,27,28],[0,1,2,3],[30,31,32,33,34,35],[19,20,21,22],[7,8,9,10]]
		  posicionesPosibles.clear()
		}
	}
	
	method hayLetraRepetida(unaLetra){		
		return listaLetras.any({ l => l.letra() == unaLetra.letra() })
	}

	

	method abc(){
		const a = new Letras(image = "A0.png",letra = "A",puntaje = 1)
		const b = new Letras(image = "B0.png",letra = "B",puntaje = 3)
		const c = new Letras(image = "C0.png",letra = "C",puntaje = 1)
		const d = new Letras(image = "D0.png",letra = "D",puntaje = 1)
		const e = new Letras(image = "E0.png",letra = "E",puntaje = 1)
		const f = new Letras(image = "F0.png",letra = "F",puntaje = 1)
		const g = new Letras(image = "G0.png",letra = "G",puntaje = 2)
		const h = new Letras(image = "H0.png",letra = "H",puntaje = 2)
		const i = new Letras(image = "I0.png",letra = "I",puntaje = 2)
		const j = new Letras(image = "J0.png",letra = "J",puntaje = 2)
		const k = new Letras(image = "K0.png",letra = "K",puntaje = 2)
		const l = new Letras(image = "L0.png",letra = "L",puntaje = 2)
		const m = new Letras(image = "M0.png",letra = "M",puntaje = 2)
		const n = new Letras(image = "N0.png",letra = "N",puntaje = 2)
		const o = new Letras(image = "O0.png",letra = "O",puntaje = 3)
		const p = new Letras(image = "P0.png",letra = "P",puntaje = 3)
		const q = new Letras(image = "Q0.png",letra = "Q",puntaje = 3)
		const r = new Letras(image = "R0.png",letra = "R",puntaje = 1)
		const s = new Letras(image = "S0.png",letra = "S",puntaje = 1)
		const t = new Letras(image = "T0.png",letra = "T",puntaje = 1)
		const u = new Letras(image = "U0.png",letra = "U",puntaje = 2)
		const v = new Letras(image = "V0.png",letra = "V",puntaje = 2)
		const w = new Letras(image = "W0.png",letra = "W",puntaje = 3)
		const x = new Letras(image = "X0.png",letra = "X",puntaje = 3)
		const y = new Letras(image = "Y0.png",letra = "Y",puntaje = 3)
		const z = new Letras(image = "Z0.png",letra = "Z",puntaje = 3)		
		const letras =[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z]
		return letras
	}


	method manejarLetra(letraString) {
		if(estaJugando){
			var letraEnPantalla = null

			try{
				letraEnPantalla = listaLetras.find({ l => l.letra() == letraString })
			} catch e  {
			letraEnPantalla = null
			}

		
		if (letraEnPantalla != null) {
			
			letraEnPantalla.destruir()
			listaLetras.remove(letraEnPantalla)
			letrasNoEnPantalla.add(letraString)
		} else {
			
			self.sonidoError()
			puntos.restarPuntaje(10)
		}
		}
		
}

method sonidoError(){	
		const error = new Sonido(cancion = "error.mp3") 	
        error.cambiarVolumen(0.3)
        error.reproducir(false)    
}

method configurarTeclado() {
    keyboard.a().onPressDo({ self.manejarLetra("A") })
    keyboard.b().onPressDo({ self.manejarLetra("B") })
    keyboard.c().onPressDo({ self.manejarLetra("C") })
    keyboard.d().onPressDo({ self.manejarLetra("D") })
    keyboard.e().onPressDo({ self.manejarLetra("E") })
    keyboard.f().onPressDo({ self.manejarLetra("F") })
    keyboard.g().onPressDo({ self.manejarLetra("G") })
    keyboard.h().onPressDo({ self.manejarLetra("H") })
    keyboard.i().onPressDo({ self.manejarLetra("I") })
    keyboard.j().onPressDo({ self.manejarLetra("J") })
    keyboard.k().onPressDo({ self.manejarLetra("K") })
    keyboard.l().onPressDo({ self.manejarLetra("L") })
    keyboard.m().onPressDo({ self.manejarLetra("M") })
    keyboard.n().onPressDo({ self.manejarLetra("N") })
    keyboard.o().onPressDo({ self.manejarLetra("O") })
    keyboard.p().onPressDo({ self.manejarLetra("P") })
    keyboard.q().onPressDo({ self.manejarLetra("Q") })
    keyboard.r().onPressDo({ self.manejarLetra("R") })
    keyboard.s().onPressDo({ self.manejarLetra("S") })
    keyboard.t().onPressDo({ self.manejarLetra("T") })
    keyboard.u().onPressDo({ self.manejarLetra("U") })
    keyboard.v().onPressDo({ self.manejarLetra("V") })
    keyboard.w().onPressDo({ self.manejarLetra("W") })
    keyboard.x().onPressDo({ self.manejarLetra("X") })
    keyboard.y().onPressDo({ self.manejarLetra("Y") })
    keyboard.z().onPressDo({ self.manejarLetra("Z") })
}

	
}

