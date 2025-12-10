import gestores.*
import protagonista.*

// ################################################################################################################# \\

class MovimientoNPC {
    const direccionesGestor = gestorDeDirecciones   // Representa el gestor de direcciones que utiliza el movimiento.
    const posicionesGestor  = gestorDeCeldasTablero // Representa el gestor de posiciones que utiliza el movimiento.
    const npc                                       // Representa al NPC que realiza el movimiento.
    const enemigo = protagonista                    // Representa al enemigo que tiene el NPC.

    // ============================================================================================================= \\

    method perseguirEnemigo(){
        // Si el NPC no está sobre el enemigo, lo persigue para poder atacarlo.
        if (not npc.estaSobreEnemigo()){ 
            self.avanzarHaciaEnemigo() 
        }
    }

    method avanzarHaciaEnemigo(){
        // Mueve al NPC hacia la siguiente posición y modifica su imagen en base a la dirección a la que se movió (en caso que asi sea).
        const positionAntiguo = npc.position()
        const positionNuevo   = self.siguientePosicion(positionAntiguo)
        
        if(self.sonDistintasPosiciones(positionNuevo, positionAntiguo)){ 
           self.irACeldaCercanaAEnemigo(positionNuevo, positionAntiguo)
        }
    }

    method siguientePosicion(position){
        // Describe la siguiente posición conveniente para el NPC en base de donde esté parado.
        return posicionesGestor.lindanteConvenienteHacia(position, enemigo)
    }

    method sonDistintasPosiciones(primeraPosition, segundaPosition){
        // Indica si primeraPosition es diferente de segundaPosition.
        return primeraPosition != segundaPosition
    }

    method irACeldaCercanaAEnemigo(positionNuevo, positionAntiguo){
        // Mueve al NPC a la posición nueva, cambiando además, la imagen suya dependiendo a donde se movió.
        npc.position(positionNuevo) 
        npc.cambiarImagen(direccionesGestor.direccionALaQueSeMovio(positionAntiguo, positionNuevo))
    }
}

// ################################################################################################################# \\