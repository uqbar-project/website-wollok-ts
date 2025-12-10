import src.juego.*
import src.hud.*
import src.elementos.*
import wollok.game.*
import Personajes.posiciones.*
import colisiones.*
import armas.*



object personaje{

    //var property position = game.origin() //recomendado para que funcion el perseguir() del enemigo
    //var property position = game.center()
    var property vidas = 3
    var property position=game.at(5,2) 
    const property velocidad = 1
    var property orientacion = 2        // 1: Arriba, 2: Abajo, 3: Izq, 4:Der
    var property esObstaculo=false           
    
    
    var property imagen = "astronauta_derecha_pistola.png"
    method image() = imagen

    // Estado del arma actual
    var property armaActual = new Pistola()
    var property puedeDisparar = true

    // ----------------- MOVIMIENTO -----------------
    method moverArriba(){
        var nueva = position.up(velocidad)

        if(not colisiones.hayObstaculoEn(nueva.x(), nueva.y())){
            position = posiciones.limitarDentroDe(nueva)
        }

        orientacion = 1
        self.actualizarSprite()
    }
    method moverAbajo(){
        var nueva = position.down(velocidad)

        if(not colisiones.hayObstaculoEn(nueva.x(), nueva.y())){
            position = posiciones.limitarDentroDe(nueva)
        }

        orientacion = 2
        self.actualizarSprite()
    }

    method moverIzquierda(){
        var nueva = position.left(velocidad)

        if(not colisiones.hayObstaculoEn(nueva.x(), nueva.y())){
            position = posiciones.limitarDentroDe(nueva)
        }

        orientacion = 3
        self.actualizarSprite()
    }
    method moverDerecha(){
        var nueva = position.right(velocidad)

        if(not colisiones.hayObstaculoEn(nueva.x(), nueva.y())){
            position = posiciones.limitarDentroDe(nueva)
        }

        orientacion = 4
        self.actualizarSprite()
    }


    // ----------------- DISPARO -----------------

    method intentarDisparar(direccion){
        if(not puedeDisparar) return null
        if(not armaActual.puedeDisparar()) return null
        
        armaActual.dispararDesde(position, direccion)

        hudMunicion.actualizar(armaActual)
        hudMejora.actualizar(armaActual)

        // Cooldown del arma
        puedeDisparar = false
        game.schedule(armaActual.cadencia(),{ => self.habilitarDisparo()})

        return true
    }

    method habilitarDisparo(){
        puedeDisparar = true
    }

    method dispararArriba(){
        orientacion = 1
        self.intentarDisparar(direccionArriba)
        self.actualizarSprite()
    }
    
    method dispararAbajo(){
        orientacion = 2
        self.intentarDisparar(direccionAbajo)
        self.actualizarSprite()
    }

    method dispararIzquierda(){
        orientacion = 3
        self.intentarDisparar(direccionIzquierda)
        self.actualizarSprite()
    }

    method dispararDerecha(){
        orientacion = 4
        self.intentarDisparar(direccionDerecha)
        self.actualizarSprite()
    }

    // ----------------- ARMAS -----------------
    method aplicarMejoraDeArma(){
        armaActual.mejorar()
    }
    // Q -> Suelta el arma en el suelo, vuelve a la pistola
    method dejarArma(){
        if(armaActual.esPistola()){
            // No se puede tirar la pistola
            return false   
        }
        armasMundo.dejarArma(position, armaActual)
        armaActual = new Pistola()
        hudMunicion.actualizar(armaActual)
        hudMejora.actualizar(armaActual)
        self.actualizarSprite()
        return true
    }

    // E -> Recoje/Intercambia arma con la del piso
    method intentarTomarArma(armaSuelo){
        var armaAgarrada = armaSuelo.arma()

        // Si el arma que tengo no es la pistola, la dejo en el piso
        if(not armaActual.esPistola()){
            armasMundo.dejarArma(position, armaActual)
        }

        self.armaActual(armaAgarrada)
        armasMundo.eliminar(armaSuelo)
        hudMunicion.actualizar(armaActual)
        hudMejora.actualizar(armaActual)
        self.actualizarSprite()
        return true
    }

    // ----------------- DAÑO -----------------

    method recibirDanio(danio){
        vidas = vidas - danio
        hudVidas.actualizar(vidas)
        if(vidas <= 0){
            game.removeVisual(self)
            juego.gameOver()
        }
    }

    // ----------------- SUPERVIVIENTES -----------------

    var property supervivientesRescatados = 0

    method rescatar() {
        supervivientesRescatados += 1
        if (supervivientesRescatados == 4) {
            juego.gameOverBueno()
        }
    }

    method configTeclas(){

        //------- MOVIMIENTO CON WASD -------
        keyboard.w().onPressDo({ self.moverArriba()})
        keyboard.s().onPressDo({ self.moverAbajo()})
        keyboard.a().onPressDo({ self.moverIzquierda()})
        keyboard.d().onPressDo({ self.moverDerecha()})

        //------- DISPARO CON FLECHAS -------
        keyboard.up().onPressDo({ self.dispararArriba()})
        keyboard.down().onPressDo({ self.dispararAbajo()})
        keyboard.left().onPressDo({ self.dispararIzquierda()})
        keyboard.right().onPressDo({ self.dispararDerecha()})

        //------- MANEJO DE ARMAS Q/E -------
        keyboard.q().onPressDo({ self.dejarArma()})
        keyboard.e().onPressDo({
            var armaSuelo = armasMundo.armaEn(position)

            if(armaSuelo != null){
                self.intentarTomarArma(armaSuelo)
            }
        })
    }
 
    method spriteOrientacion(){
        if(orientacion == 1) return "arriba"
                else if(orientacion == 2) return "abajo"
                else if(orientacion == 3) return "izquierda"
                else return "derecha"
    }

    method actualizarSprite(){
        const orient = self.spriteOrientacion()
        const nombreArma = armaActual.nombre()

        imagen = "astronauta_" + orient + "_" + nombreArma + ".png"
    }
    /*
    method animacion() {
	  	game.onTick(400, "animacion", { => 
            self.estados()
        })
	}

	method estados() {//cambiar todos los atributos modificados a self.atributo() para evitar errores en ejeucución
		if (self.orientacion() == 1) 		// arriba
			self.cambioDeSprite("astronauta_detras.png", "astronauta_detras.png")
		else if (self.orientacion() == 2) 	// abajo
			self.cambioDeSprite("astronauta_frente.png", "astronauta_frente.png")
		else if (self.orientacion() == 3) 	// izquierda
			self.cambioDeSprite("astronauta_izquierda.png", "astronauta_izquierda.png")
		else if (self.orientacion() == 4) 	// derecha
			self.cambioDeSprite("astronauta_derecha.png", "astronauta_derecha.png")
	}

	method cambioDeSprite(imagen1, imagen2) {
	  	if (self.estado()) {
			self.imagen(imagen1) 
			self.estado(!self.estado()) 
		} else {
			self.imagen(imagen2) 
			self.estado(!self.estado())
		}
	}*/
}