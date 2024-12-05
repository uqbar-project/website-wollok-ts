import nivelManager.*
import wollok.game.*
import posiciones.*
import stats.*
import managers.*


class Personaje { 
    //Imagen y posicion
    const property armas
    var property image = self.imagenInicial()
    var property position = game.at(5,5)
    //Propiedades   
    var property arma 
    
    method visualAmmo()
    method imagenInicial()
    method imagenNormal(dir)
    method imagenAtaque(dir)
    method sonidoAtaque()
    method cura(num)
    method sinMunicion()
    method lanzarEspecial() 
    method sonidoHerida()
    method sonidoEspecial()

    method visualHealth(numero) {
        return self.cura(numero)
    }
    
    // -------------movimiento-------------------------------
    
    method mover(direccion) {
        self.validarMover(direccion)
        barraDeEnergia.validarEnergia()
	    position = direccion.siguientePosicion(position)
        self.image(self.imagenNormal(direccion))
        managerItems.revisarPorItems(position)
	}

    method validarMover(direccion) {
		const siguiente = direccion.siguientePosicion(position)
		tablero.validarDentro(siguiente)
        self.validarNoHayEnemigos(siguiente)
        self.validarNoHayCaja(siguiente)
	}

    method validarNoHayEnemigos(posicion) {
        if(managerZombie.posTieneZombie(posicion)) {
            self.error("")
        }
    }

    method validarNoHayCaja(pos) {
        if (nivelManager.hayCajaEn(pos)) {
            self.error("")
        }
    }

    // -------------ataque-------------------------------
    
    method ataque(direccion) { 
        self.image(self.imagenNormal(direccion))
        arma.validarAtaque()
        arma.gatillar(direccion,position)                                             
    }
    
    method animacionAtaque(direccion) {                                                       
        self.image(self.imagenAtaque(direccion))
        game.schedule(300,{self.image(self.imagenNormal(direccion))})
        self.sonidoAtaque()
    }

    // -------------items-------------------------------

    method herir(cantidad) {
        puntosDeVida.herir(cantidad)
        self.sonidoHerida()
    }

    // -------------armas-------------------------------

    method sigArma() {
        return if(self.quedanArmasPorMejorar()) {
           armas.first()
        }
    }

    method quedanArmasPorMejorar(){
        return !armas.isEmpty()
    }
    method mejorarArma(){
        arma = self.sigArma()
        armas.remove(arma)
    }

}

