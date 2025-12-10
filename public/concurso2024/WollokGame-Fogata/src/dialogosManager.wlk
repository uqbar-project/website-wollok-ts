import enemigos.*
import protagonista.*
import puertas.*
import visualesExtra.*

// ################################################################################################################################### \\

object gestorDeDialogo{
    var property esMomentoDeDialogar = false        // Representa si es momento de dialogar o no.
    var property dialogo = dialogoEscenarioInicial  // Representa el diálogo que administra el gestor.
  
    // =============================================================================================================================== \\

    method interactuarConNPC(){
        // Interactúa con el NPC, conversando con él si es que puede hacerlo.
        if (self.sePuedeConversar()){ self.conversar() }
    }     

    method sePuedeConversar(){
        // Indica si se puede conversar, esto si es momento de conversar y además que el conversador esté en posición.
        return esMomentoDeDialogar and dialogo.conversadorEnPosicion()
    }

    method conversar(){
        // Se realiza la conversación en caso que sea posible, sino se termina el diálogo.
        if(not dialogo.esUltimoDialogo()){
            dialogo.decirDialogoActual()
        } else {
           self.terminarDialogo()
        }
    }

    method terminarDialogo(){
        // Termina el diálogo y actualiza el momento de dialogar.
        self.esMomentoDeDialogar(false)       
        dialogo.finalizarDialogo()
    }
}

// ################################################################################################################################### \\

class Dialogo{
    var property conversadorActual  = protagonista // Representa el conversador actual del diálogo.
    const bloque           = {}              // Representa el bloque que contiene el último diálogo del NPC y varias acciones más.
    const dialogoEscenario = []              // Representa el guion del dialogo completo. 
    const dialogoGestor    = gestorDeDialogo // Representa el gestor de diálogo que utiliza el diálogo.
    const iniciadorDialogo = protagonista    // Representa el que inicia el diálogo, en este caso es el protagonista.
    const npcDialogo                         // Representa el NPC con el cual se va a dialogar.

    // =============================================================================================================================== \\

    method decirDialogoActual(){
        self.validarGuionDialogo()
        // Hace que el conversador actual diga el diálogo actual.
        game.say(conversadorActual, self.dialogoActual())
        self.actualizarADialogoSiguiente()
    }

    method validarGuionDialogo(){
        if(not self.existeDialogo()){
            self.error("No hay guion para dialogo")
        }
    }

    method existeDialogo(){
        return not dialogoEscenario.isEmpty()
    }

    method dialogoActual(){
        // Describe el dialogo actual del escenario cargado.
        return dialogoEscenario.first()
    }

    method actualizarADialogoSiguiente(){
        // Actualiza el diálogo al siguiente en la lista de dialogos y actualiza el conversador.
        dialogoEscenario.remove(self.dialogoActual())
        self.actualizarConversador()
    }

    method actualizarConversador(){
        // Actualiza el conversador del díalogo.
        if (self.esElTurnoDelIniciadorDialogo()){ 
            self.conversadorActual(iniciadorDialogo) 
        } else { 
            self.conversadorActual(npcDialogo)       
        }
    }

    method esElTurnoDelIniciadorDialogo(){
        // Indica si es turno del iniciador del dialogo para dialogar.
        return dialogoEscenario.size().even()
    }

    method esUltimoDialogo(){
        // Indica si es el último diálogo del escenario.
        return dialogoEscenario.isEmpty()
    }

    method finalizarDialogo(){
        // Finaliza el diálogo, aplicando el bloque que contiene el dialogo final dicho por el NPC y varias acciones más.
        bloque.apply(npcDialogo, dialogoGestor)
    }
    
    method conversadorEnPosicion(){
        // Indica si el visual que inicia la conversación está al lado del NPC cargado en el diálogo.
        return iniciadorDialogo.estaAlLadoDelNPC(npcDialogo)
    }

    // =============================================================================================================================== \\

    method npcDialogo(){
        // Describe el NPC con el que dialogar actual.
        return npcDialogo
    }

    method dialogoEscenario(){
        // Describe el diálogo actual del escenario.
        return dialogoEscenario
    }
}

// ############################################################ DIALOGOS ############################################################# \\

const dialogoEnCabaña  = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña, bloque = accionCabaña1)

const dialogoEnCabaña2 = new Dialogo(npcDialogo = guardabosques, dialogoEscenario = dialogoCabaña2, bloque = accionCabaña2)

const dialogoEscenarioInicial = new Dialogo(npcDialogo = amiga, dialogoEscenario = dialogoAmiga, bloque = accionAmiga)

// ######################################################## GUION DE DIALOGOS ######################################################## \\

const dialogoCabaña  = ["Hola, ¿cómo va?", " Juan... emm... ¿todo en orden?", "Excelente, me preguntaba si tendría algo de leña.", "Claro."]

const dialogoCabaña2 = ["¡¡¡AUXILIOO!!!", "¿Qué pasó Juan?", "Esta lleno de lobos, mataron a mi amiga.", "Carajo. No pensé que se acercarían.", 
                        "¿Qué hago ahora? Laura...", "Tranquilo, vamos al granero.", "¿Por qué? ¿qué hay ahí?", "Tengo... armas."]

const dialogoAmiga   = ["¿Dónde quedaba la cabaña?", "Hacia el Norte y al Este.", "Dale, ahí vengo.", "Dale, te espero."]

// ###################################################### BLOQUES FINAL DIALOGO ###################################################### \\

const accionAmiga   = {a, g => game.say(a, "Andá con cuidado."); g.dialogo(dialogoEnCabaña); game.addVisual(puertaNorte);}

const accionCabaña1 = {gu, g => game.addVisual(leña); game.say(gu, "Agarrá un poco de la chimenea."); g.dialogo(dialogoEnCabaña2)}

const accionCabaña2 = {gu, g => game.addVisual(puertaEntradaCabaña); game.say(gu, "Vamos ya mismo hacia allá.")}

// ################################################################################################################################### \\