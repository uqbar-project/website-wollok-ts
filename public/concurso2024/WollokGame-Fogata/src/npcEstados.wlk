import protagonista.*
import enemigos.*
import npcMovimiento.*
import gestores.*
import npcAtaques.*

// ######################################################################################################################################################### \\

const pasivoGuardabosques = new EstadoPasivoGuardabosques(visual = guardabosques, imagen = "guardabosques-desarmado-")  // Representa al estado de combate pasivo del guardabosques.
const pasivoProtagonista  = new EstadoPasivoProtagonista(visual = protagonista, imagen = "prota-desarmado-")            // Representa al estado de combate pasivo del protagonista.

const agresivoGuardabosques  = new EstadoAgresivoGuardabosques(visual = guardabosques, imagen = "guardabosques-escopeta-", modoAtaque = ataqueEscopeta) // Representa al estado de combate agresivo del guardabosques.
const agresivoProtagonistaH  = new EstadoAgresivoProtagonista(visual = protagonista, imagen = "prota-hacha-",    modoAtaque = ataqueHacha)    // Representa al estado de combate agresivo del protagonista con hacha.
const agresivoProtagonistaT  = new EstadoAgresivoProtagonista(visual = protagonista, imagen = "prota-tridente-", modoAtaque = ataqueTridente) // Representa al estado de combate agresivo del protagonista con tridente.
const agresivoProtagonistaM  = new EstadoAgresivoProtagonista(visual = protagonista, imagen = "prota-manopla-",  modoAtaque = ataqueManopla)  // Representa al estado de combate agresivo del protagonista con manopla.

const ataqueHacha    = new AtaqueHacha(atacante    = protagonista) // Representa al modo de ataque para el hacha. 
const ataqueTridente = new AtaqueTridente(atacante = protagonista) // Representa al modo de ataque para el tridente. 
const ataqueManopla  = new AtaqueEnLugar(atacante  = protagonista) // Representa al modo de ataque para la manopla. 
const ataqueEscopeta = new Escopeta(tirador = guardabosques, balasDisponibles = cargadorGuardabosques) // Representa al modo de ataque de escopeta.

const cargadorGuardabosques = new Cargador(balas = [bala1, bala2, bala3, bala4, bala5, bala6]) // Representa un cartucho que contiene balas.
const bala1 = new Bala() // Representa una bala.
const bala2 = new Bala() // Representa una bala.
const bala3 = new Bala() // Representa una bala.
const bala4 = new Bala() // Representa una bala.
const bala5 = new Bala() // Representa una bala.
const bala6 = new Bala() // Representa una bala.

// ######################################################################################################################################################### \\

class EstadoVivo{
    const visual                                          // Describe el visual que se encuentra vivo.
    const vidaGestor    = gestorDeVida                    // Representa al gestor de vida.
    const movimientoNPC = new MovimientoNPC(npc = visual) // Representa al movimiento automatizado del visual.

    method perseguirEnemigo(){
        // El visual persigue a su enemigo hasta estar sobre él para poder atacarlo.
        movimientoNPC.perseguirEnemigo()
    }

    method atacarEnemigo(){
        // El visual ataca a su enemigo dependiendo del comportamiento asignado en su estado de combate. 
        visual.estadoCombate().atacarEnemigo()
    }

    method atacadoPor(enemigo){
        // Emite un mensaje cuando el visual es atacado por su enemigo, y se le actualiza la vida.
        vidaGestor.atacadoPor(visual, enemigo)
    }
}

// ######################################################################################################################################################### \\

class EstadoMuerto{
    method perseguirEnemigo(){}  // Al estar muerto, no tiene comportamiento asignado.

    method atacarEnemigo(){}     // Al estar muerto, no tiene comportamiento asignado.

    method atacadoPor(enemigo){} // Al estar muerto, no tiene comportamiento asignado.
}

// ######################################################################################################################################################### \\

class EstadoCombate{
    const visual // Describe el visual que tiene el estado de combate.
    const imagen // Describe la nueva imagen apartir del estado de combate que va a tener el visual.

    method actual(){
        // Describe la imagen que se encuentra en dicho atributo.
        return imagen
    }

    method visual(){
        // Describe el visual que se encuentra en dicho atributo.
        return visual
    }

    method daño() // Describe el daño que realiza el estado de combate.
}

// ######################################################################################################################################################### \\

class EstadoPasivo inherits EstadoCombate{
    
    method atacarEnemigo(){} // En el estado de combate pasivo, no hay un comportamiento definido para atacar a un enemigo.

    override method daño(){
        // Describe el daño que realiza el estado de combate pasivo, en este caso, es 0.
        return 0
    }
} 

// ######################################################################################################################################################### \\

class EstadoPasivoLobo inherits EstadoPasivo{} // Representa al estado de combate pasivo del lobo.

// ######################################################################################################################################################### \\

class EstadoPasivoGuardabosques inherits EstadoPasivo{} // Representa al estado de combate pasivo del guardabosques.

// ######################################################################################################################################################### \\

class EstadoPasivoProtagonista inherits EstadoPasivo{} // Representa al estado de combate pasivo del protagonista.

// ######################################################################################################################################################### \\

class EstadoAgresivo inherits EstadoCombate{
    const animacion = new AnimacionAtaque(npc = visual) // Representa la animación que realiza el visual a la hora de atacar.
    const modoAtaque // Representa en la forma que puede atacar el visual: en el lugar, en una celda lindante, en dos celdas lindantes, etc.

    method atacarEnemigo(){
        // El visual en su estado de combate enemigo ataca al enemigo.
        if (self.puedeAtacarAlEnemigo()){ 
            self.atacarAEnemigo()
        }
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el visual en su estado de combate agresivo puede atacar a su enemigo. 
        return true
    }

    method atacarAEnemigo(){
        // Representa el comportamiento del visual en su estado de combate agresivo.
        modoAtaque.ataqueArma()
        animacion.animarAtaque()
    }

    override method daño(){
        // Describe el daño que realiza el estado de combate agresivo, lo cual depende del daño del modo de ataque.
        return modoAtaque.daño()
    }
}

// ######################################################################################################################################################### \\

class EstadoAgresivoLobo inherits EstadoAgresivo{ // Representa al estado de combate agresivo del lobo.

    override method puedeAtacarAlEnemigo(){
        // Indica si el lobo en su estado de combate agresivo puede atacar a su enemigo. 
        return visual.estaSobreEnemigo()
    }

    override method atacarAEnemigo(){
        // Representa el comportamiento del lobo en su estado de combate agresivo.
        super()
        visual.emitirSonidoEnojado()
    }
}

// ######################################################################################################################################################### \\

class EstadoAgresivoGuardabosques inherits EstadoAgresivo{ // Representa al estado de combate agresivo del guardabosques.

    override method atacarEnemigo(){
        // El guardabosques en su estado de combate enemigo siempre ataca a su enemigo.
        self.atacarAEnemigo()
    }
} 

// ######################################################################################################################################################### \\

class EstadoAgresivoProtagonista inherits EstadoAgresivo{ // Representa al estado de combate agresivo del protagonista.
    var property estaAtacando = false // Representa el estado de ataque, si está atacando no va poder atacar, en caso contrario si.

    override method atacarAEnemigo(){
        // Representa el comportamiento del protagonista en su estado de combate agresivo.
        super()
        self.actualizarEstadoAtacando()
    }

    override method puedeAtacarAlEnemigo(){
        // Indica si el protagonista en su estado de combate agresivo puede atacar a su enemigo. 
        return not self.estaAtacando()
    }

    method actualizarEstadoAtacando(){
        // Actualiza el estado de ataque al protagonista, logrando un efecto de cooldown a la hora de atacar.
        self.estaAtacando(true)
        game.schedule(200, {self.estaAtacando(false)})
    }
} 

// ######################################################################################################################################################### \\