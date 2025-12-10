import direccion.*
import visualesExtra.*
import npcEstados.*
import videojuego.*
import gestores.*

// ################################################################################################################################## \\

object protagonista inherits VisualConMovimiento(position = game.at(0,0), image = "prota-desarmado-abajo.png", vida = 100){
    var property estadoCombate        = pasivoProtagonista  // Representa el estado de combate actual del protagonista.
    var property estadoCombateElegido = null                // Representa el estado de combate elegido, se utiliza por una situación particular.
    const property vidaGestor         = gestorDeVida        // Representa el gestor de vida que utiliza el protagonista.
    const property movimientoGestor   = gestorDeMovimiento  // Representa el gestor de movimiento que utiliza el protagonista.
   
    // ============================================================================================================================== \\

    method mover(direccion){
        // Mueve al protagonista una celda hacia la dirección dada si puede mover hacia dicha dirección.
        movimientoGestor.mover(direccion, self)
    }

    method atacar(){
        // Representa el comportamiento del ataque del protagonista hacia su enemigo.   
        estadoCombate.atacarEnemigo()   
    }

    override method daño(){
        // Describe el daño que causa cada ataque del enemigo dependiendo de su estado de combate.
        return estadoCombate.daño()
    }

    override method atacadoPor(visual){
        // Representa el comportamiento del protagonista cuando un enemigo suyo lo ataca.
        vidaGestor.atacadoPor(self, visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del protagonista a muerto, lo cual implica terminar el juego.
        super()
        videojuego.juegoPerdido()
    }
    
    override method imagenNueva(direccion){
        // Describe la imagen nueva del protagonista en base al estado de combate y a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    method estaAlLadoDelNPC(npc){
        // Indica si el protagonista se encuentra al lado del NPC dado.
        return ejeY.estaEnMismoEje(self, npc) and ejeX.estaAlLado(self, npc)
    }

    method mover(direccion, cantidad){
        // Hace que el personaje se mueva la cantidad de veces dada en la direccion dada. Solo se utiliza para testear. 
        (1 .. cantidad).forEach({n => self.mover(direccion)}) 
    }

    method agarrarArma(arma){
        // El protagonista agara el arma dada y cambia su estado de combate en base a la misma.
        self.estadoCombate(arma.nuevoEstado())
        self.estadoCombateElegido(arma.nuevoEstado()) 
    }
}

// ################################################################################################################################## \\