import wollok.game.*
import administracion.*
import menu.*
import gestorSonido.*
import objetos.*
import jugador.*



class Nivel {
    var property mapa
    const property posicionPersonaje
    const property frasesValidas
    const property tiempoDeNivel

    


	method inicializar() {
		
        game.clear()
		layers.inicializarCapas(3) // se podria poner como estado, para que tenga diferentes capas
		registroDeObjetos.limpiar()

        gestorSonido.musicaNivelUno()

        tiempo.reiniciar()
        tiempo.reloj(tiempoDeNivel) 
        tiempo.contadorReloj()
        game.addVisual(tiempo)


        game.addVisual(visorDePlabras)
        motorDeFrases.limpiarFraseHastaAHora()
        
        self.iniciarMapa()

		jugador.inicializar()
        game.addVisual(jugador)
		controles.jugadorMovimiento()

        game.onCollideDo(jugador, { algo => algo.reaccionar()})
    }

    method iniciarMapa() {
        var numeroLinea = 0

        mapa.forEach(
            { linea =>
                self.inicializarLinea(linea, numeroLinea)
                numeroLinea += 1
            }
        )

        layers.capas().forEach { capa => 
            capa.forEach { elemento => game.addVisual(elemento) } 
        }
    }
    
    method inicializarLinea(lineaActual, numeroLinea) {
        var numeroFila = 0
        
        lineaActual.forEach(
            { elemento =>
                elemento.nuevoEn_y_(numeroFila, numeroLinea)
                numeroFila += 1
            }
        )
    }
}


object layers {
	var property capas = null

	method inicializarCapas(cantCapas) {
		capas = (1..cantCapas).map { _ => []}
	}

	method add(nroCapa, elemento) {
		capas.get(nroCapa).add(elemento)
	}
}
object gestorNiveles {
    var indice = 0
    var property nivelActual = niveles.get(indice)
    const niveles = [nivel1, nivel2, nivel3,nivel4,nivel5,nivel6]
    var property seTermino = false

    method frasesDelNivelActual(){
        return self.nivelActual().frasesValidas()
    }
    method reiniciarIndice(){
        indice = 0
        seTermino = false
    }
    method inicializar() {
        niveles.get(indice).inicializar()
        nivelActual = niveles.get(indice)
        self.reiniciar()
        
    }
    

    method subirDeNivel() {
        indice += 1
        if (indice >= niveles.size()) {
            self.ganar()

        }
        else{
        game.say(jugador, "BIEN, GANASTE UN CABERNET!")
        nivelActual = niveles.get(indice)
                
        self.inicializar()
        }
    }

	method reiniciar(){
		nivelActual.inicializar()
	}

	method ganar(){
        gestorSonido.musicaDelJuegoDetener()
		game.addVisual(mensajeVictoria)
        gestorSonido.sonidoVictoria()

        seTermino = true
        

	}

    method perder() {
        gestorSonido.musicaDelJuegoDetener()
		game.addVisual(mensajeDerrota)
        gestorSonido.sonidoDerrota()
    }
    method posicionDeJugador(){
        return(self.nivelActual().posicionPersonaje())
    }
    
}

const tunel = [
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, m, m, m, v, v, v, v, v, v, v, v],
  [m, m, m, m, m, m, m, i, m, m, m, m, m, m, m, m, m],
  [m, v, v, v, v, v, v, v, v, v, v, v, v, v, v, p, m],
  [m, m, m, d, m, m, m, m, m, m, m, o, m, m, m, m, m],
  [v, v, m, m, m, v, v, v, v, v, m, m, m, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]


const elefante = [
  [v, v, v, v, v, v, v, m, v, m, v, v, v, v, i, v, v],
  [v, m, m, v, v, v, v, m, v, v, v, v, v, v, m, m, m],
  [v, v, v, m, v, v, v, m, m, v, m, v, v, v, v, v, v],
  [v, v, v, m, m, v, v, m, m, v, m, m, m, v, v, v, v],
  [v, v, v, v, v, m, m, l, m, v, v, v, m, d, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, m, v, m, m, m, m, m],
  [v, m, v, v, v, v, v, v, v, v, m, v, m, v, p, o, m],
  [v, m, m, v, v, v, v, v, v, m, m, v, v, m, v, v, m],
  [m, v, v, m, m, m, v, v, m, v, m, v, w, m, v, v, v],
  [v, v, v, v, v, v, m, m, v, v, m, m, m, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]

const treshabitaciones = [
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, m, m, m, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, m, o, m, v, v, v],
  [m, m, m, m, m, m, m, m, m, m, v, m, m, m, v, v, v],
  [m, v, v, d, i, w, v, v, p, m, v, v, v, v, v, v, v],
  [m, m, m, m, l, m, m, m, m, m, v, v, v, v, v, v, v],
  [v, v, v, m, m, m, v, v, v, v, v, v, m, m, m, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, m, v, m, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, m, m, m, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]

const lacuevaYLaRoca = [
  [h, v, v, v, v, v, v, m, v, v, v, v, v, v, v, v, v],
  [m, m, m, v, v, v, m, i, m, v, v, v, m, m, m, k, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, m, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, m, m, m, v, v, v, a, a, a, a, a, v],
  [v, v, r, v, v, v, v, v, v, v, v, a, v, v, v, a, v],
  [m, m, r, m, m, m, v, v, v, v, v, a, v, p, v, a, v],
  [m, v, v, v, e, m, v, v, v, v, v, a, v, v, o, a, v],
  [m, v, v, m, m, m, d, v, v, v, v, a, a, a, a, a, v],
  [m, v, v, v, y, m, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]

const elrio = [
  [v, v, v, v, v, v, v, a, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, a, m, v, v, v, m, m, m, v, v],
  [v, v, v, v, v, v, v, a, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, a, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, a, v, d, v, a, a, a, a, a, v],
  [v, v, v, v, v, v, v, a, v, v, v, a, v, v, v, a, v],
  [v, e, l, i, v, v, v, a, v, v, v, a, v, p, v, a, v],
  [v, v, v, v, v, v, v, a, v, v, v, a, v, v, o, a, v],
  [v, v, v, v, v, v, v, a, v, v, v, a, a, a, a, a, v],
  [v, v, v, v, v, v, v, a, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]

const labrerintoparedesapuertas = [
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, m, m, v, v, v, v, m, v, v, v, v, v, v, m, m, w],
  [v, v, v, m, v, v, v, m, m, v, m, v, v, v, v, v, v],
  [v, v, v, m, m, v, v, m, m, v, m, m, m, v, v, v, v],
  [v, v, v, v, v, m, m, v, m, v, v, v, m, v, v, v, v],
  [v, v, v, v, v, v, i, v, v, v, m, v, m, m, m, m, m],
  [v, m, v, v, v, v, v, v, v, v, m, v, m, v, v, v, m],
  [v, m, v, v, v, v, v, v, v, m, m, v, v, v, v, v, m],
  [m, v, v, m, m, m, v, v, m, v, m, v, v, m, v, d, v],
  [o, v, v, v, v, v, m, m, v, v, m, m, m, v, v, v, m],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, m, m]
].reverse()

const test5 = [
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v],
  [v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v]
]