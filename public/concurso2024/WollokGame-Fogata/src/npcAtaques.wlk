import enemigos.*
import gestores.*
import npcEstados.*
import visualesExtra.*

// ########################################################################################################################## \\

class Ataque {
    const atacante // Representa al atacante que realiza el ataque.

    method ataqueArma(){
        // En todas la posiciones a atacar, se realiza el ataque con su respectivo daño hacia todos los visual que alcance.
        self.posicionesAAtacar().forEach({posicion => self.atacarEnPosicion(posicion)})
    }
  
    method atacarEnPosicion(posicion){
        // El atacante cargado realiza el ataque en la posición dada.
        self.objetosEnPosicion(posicion).forEach({objeto => objeto.atacadoPor(atacante)})
    }
 
    method objetosEnPosicion(posicion){
        // Describe todos los objetos que hay en la posición dada.
        return game.getObjectsIn(posicion)
    } 
    
    method posicionesAAtacar() // Describe todas las posiciones a atacar.

    method daño() // Describe el daño que realiza el ataque.
}

// ########################################################################################################################## \\

class AtaqueTridente inherits Ataque(){
    
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position().left(1),
                atacante.position().left(2),
                atacante.position().right(1),
                atacante.position().right(2)]
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 3
    }
}

// ########################################################################################################################## \\

class AtaqueHacha inherits Ataque(){
        
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position().down(1),
                atacante.position().up(1),
                atacante.position().left(1),
                atacante.position().right(1)]
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 5
    }
}

// ########################################################################################################################## \\

class AtaqueEnLugar inherits Ataque(){
    
    override method posicionesAAtacar(){
        // Describe todas las posiciones a atacar.
        return [atacante.position()]
    }

    override method objetosEnPosicion(posicion){
        // Describe todos los objetos que hay en la posición dada sin incluir al visual dado.
        return game.getObjectsIn(posicion).copyWithout(atacante)
    }

    override method daño(){
        // Describe el daño que realiza el ataque.
        return 7
    }
}

// ########################################################################################################################## \\

class AnimacionAtaque{
    const npc  = null // Representa el NPC que realiza el ataque.

    method animarAtaque(){
        // Realiza una secuencia de instrucciones que consisten en remover/agregar la imagen de un visual para dar sensación de animación.
        const imagenActual = npc.image()
        game.removeVisual(npc) 
        npc.image(npc.imagenTemporal())
        game.addVisual(npc)
        game.schedule(200, {game.removeVisual(npc); 
                            npc.image(imagenActual); 
                            game.addVisual(npc)})
    }

    method atacadoPor(visual){} // Método conservado únicamente por polimorfismo.
 
    method esAtravesable(){
        // Describe que la animación es atravesable, aunque en realidad es conservado únicamente por polimorfismo.
        return true
    }
}

// ################################################ ATAQUES CON ARMA DE FUEGO ############################################### \\

class Escopeta{
    const direccionesGestor = gestorDeDirecciones // Representa el gestor de direcciones que utiliza la escopeta.
    const balasDisponibles                        // Representa las balas disponibles que puede utilizar la escopeta.
    const tirador                                 // Representa el tirador que tiene la escopeta.

    // ====================================================================================================================== \\

    method ataqueArma(){
        // Realiza el ataque de la escopeta desde la posición actual del tirador hacia la dirección hacia donde mire el mismo.
        self.dispararAEnemigo()
        self.recargarEscopeta()
    }

    method dispararAEnemigo(){
        // Dispara la escopeta hacia la posición del enemigo del tirador de la misma.
        const posicionTirador  = tirador.position()
        const direccionDestino = direccionesGestor.direccionDeBalaDesde(tirador)
        const balaActual       = balasDisponibles.proximaADisparar()
        balaActual.dispararDesdeHacia(posicionTirador, direccionDestino)
    }

    method recargarEscopeta(){
        // Recarga las balas disponibles de la escopeta. Su funcionamiento es como una Queue.
        const balaEnRecamara = balasDisponibles.proximaADisparar()
        balasDisponibles.quitarBala()
        balasDisponibles.agregarBala(balaEnRecamara)
    }
}

// ########################################################################################################################## \\

class Cargador{
    const property balas = [] // Describe las balas que estan en el cargador.

    method proximaADisparar(){
        // Describe la próxima bala a disparar.
        return balas.first()
    }

    method quitarBala(){
        // Quita la primera bala del cargador
        return balas.remove(balas.first())
    }

    method agregarBala(bala){
        // Agrega la bala dada al final del cargador.
        balas.add(bala)
    }
}

// ########################################################################################################################## \\

class Bala inherits VisualAtravesable{
    const colisionesGestor = gestorDeCeldasTablero // Representa el gestor de colisiones que utiliza la bala.
    const movimientoGestor = gestorDeMovimiento    // Representa el gestor de movimiento que utiliza la bala.

    // ====================================================================================================================== \\

    method dispararDesdeHacia(posicion, direccion){
        // Se dispara la bala desde la posición dada hacia la dirección dada. 
        self.prepararBala(posicion, direccion)
        self.dispararse(direccion)
    }

    method prepararBala(posicion, direccion){
        // Prepara el disparo de la bala, modificando su dirección, su posición por la dadas por parámetro y se la agrega al juego.
        self.position(posicion)
        self.image("bala-"+direccion.toString()+".png")
        game.addVisual(self)
    }

    method dispararse(direccion){
        // La bala se dispara y continúa una trayectoria hacia la dirección dada.
        self.gestionarTrayectoria(direccion)
    }

    method moverHacia(direccion){
        // La bala se mueve hacia la dirección dada.
        movimientoGestor.moverHaciaSinCambiarImagen(direccion, self)
    }

    method gestionarTrayectoria(direccion){
        // Gestiona la trayectoria de la bala, la cual se mueve recursivamente hasta que se den las condiciones para terminar.
        if(self.puedeSeguirTrayectoria()) { self.continuarTrayectoriaBala(direccion) } else 
                                          { self.cicloTerminado() }
    }

    method puedeSeguirTrayectoria(){
        // Indica si la bala puede seguir su trayectoria. 
        return colisionesGestor.estaDentroDelTablero(self.position())
    }
   
    method continuarTrayectoriaBala(direccion){
        // Continúa la trayectoria de la bala, la cual se mueve recursivamente hacia la dirección dada dependiendo de la velocidad de la misma.
        self.moverHacia(direccion) 
        game.schedule(self.velocidad(), {self.gestionarTrayectoria(direccion)})
    }

    method cicloTerminado(){
        // Al haber terminado el ciclo, se remueve la bala del juego.
        game.removeVisual(self)
    }

    override method interaccion(){
        // Representa la interacción de la bala al chocar con un visual.
        self.hacerDaño()
        self.cicloTerminado()
    }

    method hacerDaño(){
        // La bala realiza daño a cada visual que haya alcanzado.
        colisionesGestor.objetosEnPosicion(position, guardabosques).forEach({visual => visual.atacadoPor(self)})
    } 

    // ====================================================================================================================== \\

    method daño(){
        // Describe el daño de la bala.
        return 7
    } 

    method velocidad(){
        // Describe la velocidad de la bala.
        return 200
    }

    override method atacadoPor(visual){} // Conservado únicamente por polimorfismo.
}