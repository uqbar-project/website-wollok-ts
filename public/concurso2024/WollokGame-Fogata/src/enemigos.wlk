import protagonista.*
import visualesExtra.*
import npcEstados.*
import npcAtaques.*
import eventos.*
import videojuego.*
import escenariosManager.*
import puertas.*

// ####################################################################################################################################################### \\

class Enemigo inherits VisualConMovimiento(position = game.at(5,5)){
    var property estadoCombate                    // Representa el estado de combate del enemigo. No tiene valor asignado por defecto.
    var estado    = new EstadoVivo(visual = self) // Representa el estado del enemigo. Por defecto, está vivo.
    const enemigo = protagonista                  // Representa el enemigo que tiene el enemigo (en este caso, el protagonista).

    // ==================================================================================================================================================== \\

    method perseguirEnemigo(){
        // El enemigo persigue a su enemigo hasta estar sobre él para poder atacarlo dependiendo de su estado.
        estado.perseguirEnemigo()
    }

    override method atacadoPor(visual){
        // Representa el comportamiento del enemigo cuando un enemigo suyo lo ataca.
        estado.atacadoPor(visual)
    }

    override method actualizarAMuerto(){
        // Actualiza el estado del enemigo a muerto, cambiando su imagen y su estado de colisión (sumado a unas cuantas cosas más).
        super()
        estado = new EstadoMuerto()
        self.emitirSonidoMuerte()
        self.accionesAdicionalesAlMorir()
    }

    method estaSobreEnemigo(){
        // Indica si el enemigo se encuentra sobre su enemigo o no.
        return self.position() == enemigo.position()
    }

    method atacarEnemigo(){
        // Representa el comportamiento del ataque del enemigo hacia su enemigo.
        estado.atacarEnemigo()
    }

    method puedeAtacarAlEnemigo(){
        // Indica si el enemigo puede atacar a su enemigo. 
        return estado.puedeAtacarAlEnemigo()
    }

    method escenarioActual(){
        // Describe el escenario donde actualmente se encuentra el enemigo.
        return videojuego.escenario()
    }

    method emitirSonidoMuerte(){
        // Ejecuta el sonido de muerte del enemigo.
        game.sound(self.sonidoMuerte()).play()
    }

    method accionesAdicionalesAlMorir(){} // Representa las acciones adicionales que se podrían realizar después de que el enemigo muera.

    method sonidoMuerte() // Describe el sonido de muerte del enemigo.

    // ==================================================================================================================================================== \\

    method estado(){
        // Describe al estado de vida del enemigo (puede que esté vivo o muerto).
        return estado
    }

    method enemigo(){
        // Describe al enemigo del enemigo (en este caso, al protagonista).
        return enemigo
    }
}

// ####################################################################################################################################################### \\

class Lobo inherits Enemigo(image = "lobo-derecha.png", estadoCombate = new EstadoAgresivoLobo(imagen = image, visual = self, modoAtaque = new AtaqueEnLugar(atacante = self)), vida = 20, daño = 4){
    const eventoPersecucion = new EventoEnemigoPersecucion(sujetoUnico = self) // Es el evento que representa la persecución del lobo a su enemigo.
    const eventoAtaque      = new EventoEnemigoAtaque(sujetoUnico = self)      // Es el evento que representa el ataque del enemigo a su enemigo.

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-"+direccion.toString()+".png"
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo.
        return sonidosMuerteLobo.anyOne()
    }

    method emitirSonidoEnojado(){
        // Emite un sonido de enojo del lobo.
        game.sound("lobo-enojado.mp3").play()
    }

    // ==================================================================================================================================================== \\

    method eventoPersecucion(){
        // Describe el evento de persecución que utiliza el lobo.
        return eventoPersecucion
    }

    method eventoAtaque(){
        // Describe el evento de ataque que utiliza el lobo.
        return eventoAtaque
    }
}

// ####################################################################################################################################################### \\

class LoboEspecial inherits Lobo(image = "lobo-jefe-derecha.png", vida = 40, daño = 8){
    const bloquePostMuerte = bloqueAccionesMuerte // Representa el bloque que contiene las acciones que debe realizar el lobo especial post muerte.
    
    // ==================================================================================================================================================== \\

    override method imagenNueva(direccion){
        // Describe la imagen nueva del lobo en base a la dirección dada.
        return "lobo-jefe-"+direccion.toString()+".png"
    }

    override method sonidoMuerte(){
        // Describe el sonido de muerte del lobo especial.
        return trackLoboJefeDerrotado
    }
   
    override method accionesAdicionalesAlMorir(){
        // El lobo especial realiza sus propias acciones adicionales al morir.
        bloquePostMuerte.apply(self, puertaGranero, self.sonidoMuerte())
    }
}

// ####################################################################################################################################################### \\

object guardabosques inherits Enemigo(image = "guardabosques-cabaña.png", estadoCombate = agresivoGuardabosques, vida = 40, daño = 2){
    const bloquePostMuerte = bloqueAccionesMuerte // Representa el bloque que contiene las acciones que debe realizar el guardabosques post muerte.

    // ==================================================================================================================================================== \\

    override method imagenNueva(direccion){ 
        // Describe la imagen nueva del guardabosques en base a la dirección dada.
        return estadoCombate.actual()+direccion.toString()+".png"
    }

    override method accionesAdicionalesAlMorir(){
        // El guardabosques realiza sus propias acciones adicionales al morir.
        self.estadoCombate(pasivoGuardabosques)       
        game.sound(trackGuardabosquesDerrotado).play()
        bloquePostMuerte.apply(self, puertaEntradaCueva, self.sonidoMuerte())
    }
  
    override method sonidoMuerte(){
        // Describe el sonido de muerte del guardabosques.
        return trackGuardabosquesMuerte
    }

    override method esAtravesable(){
        // Describe si es atravesable o no, en este caso no.
        return false
    }
}    

// ####################################################################################################################################################### \\
// ES EL BLOQUE QUE CONTIENE TODAS LAS ACCIONES QUE DEBEN REALIZAR LOS JEFES CUANDO MUEREN:

const bloqueAccionesMuerte = {enemigo, salida, ost => enemigo.escenarioActual().bajarVolumen();
                                                      game.sound(ost).play();
                                                      game.addVisual(salida)}

// ####################################################################################################################################################### \\