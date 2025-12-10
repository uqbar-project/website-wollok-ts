import protagonista.*
import enemigos.*
import escenariosManager.*

// ############################################################################################################################ \\

class EventoLoopIndividual{
    const nombreEvento = self.toString() // Representa nombre del evento.
    const tiempo       = 800             // Representa el tiempo cada cuanto se va a ejecutar el evento.
    const sujetoUnico                    // Representa el sujeto único que realiza el evento.
    const comportamiento                 // Representa el comportamiento que contiene el evento.

    // ======================================================================================================================= \\

    method iniciarEvento(){
        // Inicia el evento en el juego a partir de los valores cargados actualmente en los atributos del mismo.
        game.onTick(tiempo, nombreEvento, {self.aplicarEventoEn(sujetoUnico)})
    }

    method finalizarEvento(){
        // Finaliza el evento en el juego mediante el nombre del mismo.
        game.removeTickEvent(nombreEvento)
    }
    
    method aplicarEventoEn(visual){
        // Aplica el comportamiento del evento en el visual dado.
        comportamiento.apply(visual)
    }

    // ======================================================================================================================= \\

    method nombreEvento(){
        // Describe el nombre del evento.
        return nombreEvento
    }
}

// ########################################################################################################################### \\

class EventoEnemigoPersecucion inherits EventoLoopIndividual(tiempo = 1000.randomUpTo(1500), comportamiento = bloquePersecucion){}

class EventoEnemigoAtaque inherits EventoLoopIndividual(tiempo = 1200, comportamiento = bloqueAtaque){}
    
const ataqueGuardabosques         = new EventoEnemigoPersecucion(sujetoUnico = guardabosques)
const ataqueEscopetaGuardabosques = new EventoEnemigoAtaque(sujetoUnico = guardabosques)

const bloquePersecucion = {npc => npc.perseguirEnemigo()}  
const bloqueAtaque      = {npc => npc.atacarEnemigo()}

// ########################################################################################################################### \\

class EventoHablar{
    const sujetoUnico = protagonista // Representa el sujeto único que realiza el evento.
    const mensaje                    // Representa el mensaje del evento.
    
    // ====================================================================================================================== \\

    method iniciarEvento(){
        // Inicia el evento en el juego a partir de los valores cargados actualmente en los atributos del mismo.
        game.say(sujetoUnico, mensaje)
    }

    method finalizarEvento(){} // Método conservado únicamente por polimorfismo.
}

// ########################################################################################################################## \\

class EventoHablarConSonido inherits EventoHablar{
    const ost // Representa el sonido que tiene el evento.

    // ====================================================================================================================== \\

    override method iniciarEvento(){
        // Inicia el evento en el juego a partir de los valores cargados actualmente en los atributos del mismo.
        super()   
        game.sound(ost).play()
    }
}

// ################################################## EVENTOS DE DIALOGOS ################################################### \\

const escucharLobos = new EventoHablarConSonido(mensaje = "¿¿Qué fue eso??", ost = trackManada)

const hablarProta   = new EventoHablar(mensaje = "Laura está muerta...")

const hablarProta2  = new EventoHablarConSonido(mensaje = "Dios mío... ¡¡¡LAURAAA!!!", ost = trackProtaPreocupado)   

const hablarProta3  = new EventoHablar(mensaje = "Ya mismo lo mato a ese #&%&#$%&")  

const hablarProta4  = new EventoHablar(mensaje = "¿¿De donde...?? Oh no, me van a comer.")

const hablarProta5  = new EventoHablar(mensaje = "Aca igual, los perderé en esa cueva.")

const hablarProta6  = new EventoHablar(mensaje = "¡¡AHHHHH!!")

const hablarProta7  = new EventoHablar(mensaje = "¡¡Lo voy a matar!!")

const hablarProta8  = new EventoHablar(mensaje = "Mi auto azul...debo salir de aqui. Laura...")

const hablarProta9  = new EventoHablar(mensaje = "¡¡¡AHHHHHHHH!!!")

const guardabosquesHabla  = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca al norte está el granero.")

const guardabosquesHabla2 = new EventoHablar(sujetoUnico = guardabosques, mensaje = "Aca adentro, apurate.")

// ########################################################################################################################## \\