import vida.barraDeVida
import pantallas.*
import pantallasPack.gameOver.*
import pantallasPack.juego2.*
import pantallasPack.pantalla.Pantallas
import letrasPack.letraSimple.*
import sonido.*
import letrasPack.*
import puntuacion.*
import pantallasPack.*

class ModoDeJuego inherits Pantallas {   
     
    var velocidadCaida = 0
    var cantidadLetras = 0
    var velocidadAparacion = 0
	const va = new GameOver()   
	const letraEnPantalla = #{}  

	
	method iniciarGameOver(){
		
		self.ocultar()
		letraEnPantalla.clear()        
		game.removeTickEvent("agregarLetras")
		letraEnPantalla.forEach({l => self.abc().get(l).ocultar()})
		juego2.cambiarEscena(va)
	}
	
	override
	method comportamiento(){
		self.doAgregarLetra()
		self.letrasTecladoSeteadas()
		keyboard.enter().onPressDo({self.iniciarGameOver()})
	//	puntos.ubicar()
	//	barraDeVida.addVisual()
	}

	method doAgregarLetra(){
		game.onTick(velocidadAparacion, "agregarLetras", {self.agregarLetraSiEsPosible()})
	}  

	method agregarLetraSiEsPosible(){
		/*
			El metodo que se encarga de poner letras en pantalla y hacer que 
			hagan su comportamiento
		*/	

		const letras = self.abc().keys() // obtiene una lista de letras

		const caracter = letras.anyOne() // obtiene una letras de la lista de letras

		const objeto = self.abc().get(caracter) // obtiene el objeto referido a la letra

		if(letraEnPantalla.size() <= cantidadLetras and not self.hayLetraRepetida(caracter)){ 
		//las muestra en pantalla solo si no esta en pantalla 
		//y si la cantidad en pantalla no supera a la posible

			objeto.doComportamiento(posiblesPosiciones.posicionXDisponible(), velocidadCaida)
			// le da una posicion X a la letra y su velocidad de caida
			

			letraEnPantalla.add(caracter)
			// la agrega a lista de letras en pantalla			

		}
	}

	
	
	method hayLetraRepetida(unaLetra){		
		/*
			Indica si la letra unaLetra existe en la lista letraEnPantalla
		*/
		return letraEnPantalla.contains(unaLetra)
	}


    method abc(){

		const letras = new Dictionary();
		const a = new LetraSimple(letra = "A",puntaje = 1)
		const b = new LetraSimple(letra = "B",puntaje = 3)
		const c = new LetraSimple(letra = "C",puntaje = 1)
		const d = new LetraSimple(letra = "D",puntaje = 1)
		const e = new LetraSimple(letra = "E",puntaje = 1)
		const f = new LetraSimple(letra = "F",puntaje = 1)
		const g = new LetraSimple(letra = "G",puntaje = 2)
		const h = new LetraSimple(letra = "H",puntaje = 2)
		const i = new LetraSimple(letra = "I",puntaje = 2)
		const j = new LetraSimple(letra = "J",puntaje = 2)
		const k = new LetraSimple(letra = "K",puntaje = 2)
		const l = new LetraSimple(letra = "L",puntaje = 2)
		const m = new LetraSimple(letra = "M",puntaje = 2)
		const n = new LetraSimple(letra = "N",puntaje = 2)
		const o = new LetraSimple(letra = "O",puntaje = 3)
		const p = new LetraSimple(letra = "P",puntaje = 3)
		const q = new LetraSimple(letra = "Q",puntaje = 3)
		const r = new LetraSimple(letra = "R",puntaje = 1)
		const s = new LetraSimple(letra = "S",puntaje = 1)
		const t = new LetraSimple(letra = "T",puntaje = 1)
		const u = new LetraSimple(letra = "U",puntaje = 2)
		const v = new LetraSimple(letra = "V",puntaje = 2)
		const w = new LetraSimple(letra = "W",puntaje = 3)
		const x = new LetraSimple(letra = "X",puntaje = 3)
		const y = new LetraSimple(letra = "Y",puntaje = 3)
		const z = new LetraSimple(letra = "Z",puntaje = 3)	

		letras.put("A", a)
		letras.put("B", b)
		letras.put("C", c)
		letras.put("D", d)
		letras.put("E", e)
		letras.put("F", f)
		letras.put("G", g)
		letras.put("H", h)
		letras.put("I", i)
		letras.put("J", j)
		letras.put("K", k)
		letras.put("L", l)
		letras.put("M", m)
		letras.put("N", n)
		letras.put("O", o)
		letras.put("P", p)
		letras.put("Q", q)
		letras.put("R", r)
		letras.put("S", s)
		letras.put("T", t)
		letras.put("U", u)
		letras.put("V", v)
		letras.put("W", w)
		letras.put("X", x)
		letras.put("Y", y)
		letras.put("Z", z)			
		
		return letras
	}

	method explosionSiErrorSino(unaLetra){
		/*
			Prueba metodo explosion cuando hay letra en pantalla (conjunto letraEnPantalla) 
            Y resta puntos y reproduce sonido de error cuando no estan en pantalla
		*/	


		if(letraEnPantalla.contains(unaLetra)){

			const objeto = self.abc().get(unaLetra) // obtiene el objeto referido a la letra

			objeto.doExplosion()
			letraEnPantalla.remove(unaLetra)
			console.println("si")

		}else{
			
			console.println("no")
			self.error()

		}

	}	

	method error(){
		/*
			metodo que reproduce sonido de explosion
		*/
		const explo = new Sonido(cancion="error.mp3")
		explo.reproducir(false)
		explo.cambiarVolumen(0.2)
		puntos.restarPuntaje(20)
	}

	method letrasTecladoSeteadas(){
		/*
			Metodo de prueba para implementar metodo explosionSiErrorSino() y setearlo a letras
			del teclado
		*/

		keyboard.a().onPressDo({self.explosionSiErrorSino("A")})
		keyboard.b().onPressDo({self.explosionSiErrorSino("B")})
		keyboard.c().onPressDo({self.explosionSiErrorSino("C")})
		keyboard.d().onPressDo({self.explosionSiErrorSino("D")})
		keyboard.e().onPressDo({self.explosionSiErrorSino("E")})
		keyboard.f().onPressDo({self.explosionSiErrorSino("F")})
		keyboard.g().onPressDo({self.explosionSiErrorSino("G")})
		keyboard.h().onPressDo({self.explosionSiErrorSino("H")})
		keyboard.i().onPressDo({self.explosionSiErrorSino("I")})
		keyboard.j().onPressDo({self.explosionSiErrorSino("J")})
		keyboard.k().onPressDo({self.explosionSiErrorSino("K")})
		keyboard.l().onPressDo({self.explosionSiErrorSino("L")})
		keyboard.m().onPressDo({self.explosionSiErrorSino("M")})
		keyboard.n().onPressDo({self.explosionSiErrorSino("N")})
		keyboard.o().onPressDo({self.explosionSiErrorSino("O")})
		keyboard.p().onPressDo({self.explosionSiErrorSino("P")})
		keyboard.q().onPressDo({self.explosionSiErrorSino("Q")})
		keyboard.r().onPressDo({self.explosionSiErrorSino("R")})
		keyboard.s().onPressDo({self.explosionSiErrorSino("S")})
		keyboard.t().onPressDo({self.explosionSiErrorSino("T")})
		keyboard.u().onPressDo({self.explosionSiErrorSino("U")})
		keyboard.v().onPressDo({self.explosionSiErrorSino("V")})
		keyboard.w().onPressDo({self.explosionSiErrorSino("W")})
		keyboard.x().onPressDo({self.explosionSiErrorSino("X")})
		keyboard.y().onPressDo({self.explosionSiErrorSino("Y")})
		keyboard.z().onPressDo({self.explosionSiErrorSino("Z")})
		
	} 	

    method aumentarDificultad(){
       const metodos = [{self.aumentarCantidadLetras()}, {self.aumentarVelocidadAparacion()}, {self.aumentarVelocidadCaida()}]

        metodos.anyOne().apply()       
    }

    method aumentarCantidadLetras()
    method aumentarVelocidadCaida()
    method aumentarVelocidadAparacion()
    
    
	
	

    

      

}


object posiblesPosiciones { 

	const posicionesPosibles = [] 	
	var posiciones = [[13,14,15,16],[25,26,27,28],[0,1,2,3],[30,31,32,33,34,35],[19,20,21,22],[7,8,9,10]]

	method posicionXDisponible(){  		

		/*
			agrega la primera lista de la lista posiciones a posicionesPosibles
			elimina la primer lista de la lista posiciones
			devuelve una posicion de la ultima lista de posiciones de la lista posicionesPosibles
		*/

		self.reiniciarPosiciones()		
		posicionesPosibles.add(posiciones.first())
		posiciones.remove(posiciones.first())

		return posicionesPosibles.last().anyOne()
	}

	method reiniciarPosiciones(){
		/*
			cuando la lista posiciones queda vacia, la reinicia y vacia la lista posicionesPosibles
		*/

		if(posiciones.isEmpty()){
		  posiciones = [[13,14,15,16],[25,26,27,28],[0,1,2,3],[30,31,32,33,34,35],[19,20,21,22],[7,8,9,10]]
		  posicionesPosibles.clear()
		}
	}
  
}