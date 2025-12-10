import direccion.*

// ############################################################################################################################################# \\

object gestorDeDirecciones{
    const ejePrimero = ejeX // Representa el primer eje del tablero, en este caso es el eje X.
    const ejeSegundo = ejeY // Representa el segundo eje del tablero, en este caso es el eje Y.

    method direccionALaQueSeMovio(posicionAntigua, posicionNueva){
        // Describe la dirección a la que se movió en base a dos posiciones dadas: una antigua y otra nueva.
        return if (ejePrimero.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejePrimero.primeraDir() } else
               if (ejePrimero.seRestoEnEje(posicionAntigua, posicionNueva)) { ejePrimero.segundaDir() } else
               if (ejeSegundo.seSumoEnEje(posicionAntigua,  posicionNueva)) { ejeSegundo.primeraDir() } else
                                                                            { ejeSegundo.segundaDir() }
    }

    method direccionDeBalaDesde(tirador){
        // Describe la dirección a la cual debería ir la bala en base a un tirador.
        return self.direccionDeBala(tirador.enemigo().position(), tirador.position())
    }
  
    method direccionDeBala(positionEnemigo, positionTirador){
        // Describe la dirección a la cual debería ir la bala en base a la posición del enemigo y el tirador.
        const positionXEnemigo = self.xPos(positionEnemigo)
        const positionYEnemigo = self.yPos(positionEnemigo)
        const positionXTirador = self.xPos(positionTirador)
        const positionYTirador = self.yPos(positionTirador)

        return self.direccionDeDisparoEvaluada(positionXEnemigo, positionYEnemigo, positionXTirador, positionYTirador)
    }

    method direccionDeDisparoEvaluada(positionXEnemigo, positionYEnemigo, positionXTirador, positionYTirador){
        // Dados unos pares de posiciones "x", "y", evalúa hacia donde disparar.
        return if (self.estaAMiIzquierda(positionXEnemigo, positionXTirador)) { izquierda } else 
               if (self.estaAMiDerecha(positionXEnemigo,   positionXTirador)) {  derecha  } else 
               if (self.estaArriba(positionYEnemigo,       positionYTirador)) {   arriba  } else 
                                                                              {   abajo   }
    }

    method estaAMiIzquierda(positionXEnemigo, positionXPropio){
        // Indica si a partir de dos posiciones, un objeto se encuentra a mi izquierda.
        return positionXEnemigo < positionXPropio
    }

    method estaAMiDerecha(positionXEnemigo, positionXPropio){
        // Indica si a partir de dos posiciones, un objeto se encuentra a mi derecha.
        return positionXEnemigo > positionXPropio
    }

    method estaArriba(positionYEnemigo, positionYPropio){
        // Indica si a partir de dos posiciones, un objeto se encuentra arriba de donde estoy.
        return positionYEnemigo > positionYPropio
    }

    method xPos(posicion){
        // Devuelve la coordenada "x" de la posicion dada.
        return posicion.x()
    }

    method yPos(posicion){
        // Devuelve la coordenada "y" de la posicion dada.
        return posicion.y()
    }
}

// ############################################################################################################################################# \\

object gestorDeCeldasTablero{

    method puedeMoverA(direccion, visual){
        // Indica si el visual dado puede moverse hacia la dirección dada.
        const posicionAMover = direccion.siguientePosicion(visual.position())
        return self.estaDentroDelTablero(posicionAMover) and not self.hayObstaculoEn(posicionAMover, visual)
    }

    // ========================================================================================================================================= \\

    method hayObstaculoEn(posicion, visual){
        // Indica si algún obstáculo en la posicion dada sin incluir al visual dado.
        return not self.objetosEnPosicion(posicion, visual).all({visualARevisar => visualARevisar.esAtravesable()})
    }

    method objetosEnPosicion(posicion, visual){
        // Describe todos los objetos en la posición dada sin el visual dado.
        return game.getObjectsIn(posicion).copyWithout(visual)
    }

    // ========================================================================================================================================= \\

    method estaDentroDelTablero(posicion){
        // Indica si la posición dada se encuentra dentro del tablero del juego.
        return self.estaXDentroDelTablero(posicion.x()) and self.estaYDentroDelTablero(posicion.y())
    }

    method estaXDentroDelTablero(positionX){
        // Indica si la posición x se encuentra dentro del eje X.
		return self.estaDentroDelLimite(positionX, game.width())
	} 

	method estaYDentroDelTablero(positionY){
        // Indica si la posición y se encuentra dentro del eje Y.
		return self.estaDentroDelLimite(positionY, game.height())
	}                                                                                              
    
    method estaDentroDelLimite(coordenada, limite){
        // Indica si la coordenada dada se encuentra entre el máximo dado.
		return coordenada.between(0, limite - 1) 
	}

    // ========================================================================================================================================= \\

    method lindantesSinObstaculos(posicion, visual){
        // Describe todas las posiciones lindantes (ortogonales y diagonales) que no tienen obstaculos sin incluir al visual dado en las mismas.
        return self.lindantesDe(posicion).filter({posicionARevisar => not self.hayObstaculoEn(posicionARevisar, visual)})
    }

    // ========================================================================================================================================= \\

    method hayLindanteSinObstaculo(posicion, visual){
        // Indica si hay lindantes sin obstaculo en la posición dada sin tener en cuenta al visual dado.
        return not self.lindantesSinObstaculos(posicion, visual).isEmpty()
    }

    method lindanteConvenienteHacia(posicion, visual){
        // Describe la celda lindante que más cerca está del visual dado.
        const lindantesSinObstaculo = self.lindantesSinObstaculos(posicion, visual)
        return self.lindanteConvenienteSiHay(lindantesSinObstaculo, posicion, visual)
    }
    
    method lindanteConvenienteSiHay(lindantes, posicion, visual){
        // Describe la posición lindante conveniente si hay en la posición dada y sin incluir al visual dado. Sino, devuelve la misma posición. 
        return lindantes.minIfEmpty({posicionARevisar => posicionARevisar.distance(visual.position())}, {posicion})
    }

    // ========================================================================================================================================= \\

    method lindantesDe(posicion){
        // Describe todas las celdas lindantes ortogonales y diagonales de la posición dada.
        return #{posicion.up(1),   posicion.up(1).right(1),  posicion.right(1), posicion.right(1).down(1), 
                 posicion.down(1), posicion.down(1).left(1), posicion.left(1),  posicion.left(1).up(1)}
    }
}

// ############################################################################################################################################# \\

object gestorDeObstaculos{
    const obstaculos = [] // Describe una colección con los obstaculos que existen en el escenario actual.

    method agregar(elemento){
        // Agrega un elemento a la lista de obstaculos.
        obstaculos.add(elemento)
    }
    
    method limpiarObstaculos(){
        // Limpia todos los obstaculos que se encuentren en la lista de obstaculos.
        obstaculos.forEach({elemento => game.removeVisual(elemento)})
        obstaculos.clear() 
    }
}

// ############################################################################################################################################# \\

object gestorDeVida{

    method atacadoPor(visual, enemigo){
        // Actualiza la vida del visual dado con el daño del enemigo dado, y además el visual emite un mensaje describiendo su vida actual.
        self.recibirDaño(visual, enemigo.daño())
        game.say(visual, "Vida: "+visual.vida()+"")
    }

    method recibirDaño(visual, dañoRecibido){
        // Actualiza la vida y el estado del visual dado con el daño del enemigo dado.
        const vidaActualizada = visual.vida() - dañoRecibido
        self.actualizarVidaYEstado(visual, vidaActualizada)
    }

    method actualizarVidaYEstado(visual, vidaActualizada){
        // Actualiza la vida y el estado del visual dado. Si la vida actualizada es menor o igual a cero, el visual muere.
        if(vidaActualizada <= 0){ visual.actualizarAMuerto()   } else 
                                { visual.vida(vidaActualizada) }
    }
}

// ############################################################################################################################################# \\

object gestorDeMovimiento{
    const colisionesGestor = gestorDeCeldasTablero // Representa al gestor de colisiones que se va a tomar de referencia.

    method mover(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        self.validarSiPuedeMover(direccion, visual)
        self.moverHacia(direccion, visual)
    }

    method moverHacia(direccion, visual){
        // Mueve al protagonista una celda hacia la dirección dada.
        visual.position(direccion.siguientePosicion(visual.position()))
        visual.cambiarImagen(direccion)
    }

    method validarSiPuedeMover(direccion, visual){
        // Valida si el visual dado se puede mover hacia la dirección dada.
        if(not colisionesGestor.puedeMoverA(direccion, visual)){
            self.error("No me puedo mover en esa dirección")
        }
    }

    method moverHaciaSinCambiarImagen(direccion, visual){
        // Mueve al visual sin modificar su imagen.
        visual.position(direccion.siguientePosicion(visual.position()))
    }
}

// ############################################################################################################################################# \\

object gestorFondoEscenario{
    var property image = "vacio.png"  // Representa la imagen del fondo del gestor. La imagen tiene que ser de tamaño 1300px(ancho) x 900px(alto).
    const position     = game.at(0,0) // Representa la posición del gestor, aunque se conserva únicamente por polimorfismo.
    
    method visualizarFondo(nuevoFondo){
        // Se muestra el fondo dado en el juego.
        self.image(nuevoFondo)
        game.addVisual(self)    
    }

    method borrarFondo(){
        // Borra el fondo del juego. 
        game.removeVisual(self)
    }

    method esAtravesable(){
        // Describe si es atravesable o no, en este caso el gestor es atravesable. Es conservado únicamente por polimorfismo.
        return true
    }

    method interaccion(){} // Método conservado únicamente por polimorfismo.

    method atacadoPor(visual){} // Método conservado únicamente por polimorfismo.

    // ========================================================================================================================================= \\

    method position(){
        // Describe la posición actual del gestor, aunque en realidad se conserva por polimorfismo.
        return position
    }
}   

// ############################################################################################################################################# \\

object gestorDeLobos{
    const property lobosEscenario = [] // Representa los lobos que administra el gestor.
    const property eventosLobos   = [] // Representa los eventos de lobos que administra el gestor.
    
    method agregar(lobo){
        // Agrega el lobo dado a los lobos que estan administrados por el gestor e inicia sus eventos.
        self.agregarLoboGestionable(lobo)
        self.iniciarCicloAtaque(lobo)
    }

    method agregarLoboGestionable(lobo){
        // Agrega el lobo dado por parámetro, agregándolo a la lista de lobos y sus eventos a la lista de eventos del gestor.
        lobosEscenario.add(lobo)
        eventosLobos.add(lobo.eventoPersecucion())
        eventosLobos.add(lobo.eventoAtaque())
    }

    method iniciarCicloAtaque(lobo){
        // Inicia el ciclo de ataque del lobo dado, iniciando sus eventos respectivos.
        lobo.eventoPersecucion().iniciarEvento()
        lobo.eventoAtaque().iniciarEvento()
    }
    
    method limpiarLobos(){
        // Limpia todos los lobos y todos los eventos de los mismos del gestor.
        lobosEscenario.forEach({lobo => self.resetearLobo(lobo)})
        eventosLobos.forEach({evento => self.resetearEventoLobo(evento)})
    }

    method resetearLobo(lobo){
        // Resetea el lobo dado, borrandolo del juego y de la lista de lobos del gestor.
        game.removeVisual(lobo)
        lobosEscenario.remove(lobo)
    }

    method resetearEventoLobo(evento){
        // Resetea el evento dado, borrandolo del juego y de la lista de eventos del gestor.
        game.removeTickEvent(evento.nombreEvento())
        eventosLobos.remove(evento)
    }
}

// ############################################################################################################################################# \\