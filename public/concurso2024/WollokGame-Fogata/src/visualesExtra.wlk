import protagonista.*
import escenariosManager.*
import npcEstados.*
import enemigos.*
import puertas.*
import videojuego.*

// ################################################################################################################################ \\

class Visual{
    var property position = game.at(0,0) // Representa la poisición del visual.
    var property image    = "vacio.png"  // Representa la imagen del visual.
    var esAtravesable     = false        // Representa la colisión del visual con otros visual del juego.
    
    // ============================================================================================================================ \\

    method interaccion(){} // Representa la interacción del visual con cualquier otro visual.

    method atacadoPor(visual){} // Representa el comportamiento del visual al ser atacado por otro visual.

    method cambiarAAtravesable(){
        // Cambia el valor del atributo que representa la colisión del visual, en este caso hace que tenga colisión.
        esAtravesable = true
    }

    // ============================================================================================================================ \\

    method esAtravesable(){
        // Describe si el visual es atravesable o no por otros visual. 
        return esAtravesable
    }
}

// ################################################################################################################################ \\

class VisualConMovimiento inherits Visual{
    var property vida       // Representa la vida del visual.
    const property daño = 1 // Representa el daño del visual.

    method cambiarImagen(direccion){
        // Cambia la imagen del visual con movimiento dependiendo de la dirección dada. 
        self.image(self.imagenNueva(direccion))
    }

    method cambiarImagenAMuerto(){
        // Actualiza la imagen del visual con movimiento a su imagen muerto.
        self.image(self.imagenMuerto())
    }

    method estaVivo(){
        // Indica si el visual con movimiento se encuentra vivo o no.
        return self.vida() > 0
    }

    method actualizarAMuerto(){
        // Actualiza la vida del visual con movimiento a cero, cambia su imagen y su colisión.
        vida = 0
        self.cambiarImagenAMuerto()
        self.cambiarAAtravesable()
    }

    method imagenMuerto(){
        // Describe la imagen del visual con movimiento muerto.
        return "muerto-"+self.image()
    }

    method imagenTemporal(){
        // Describe la imagen temporal del visual con movimiento.
        return "atacando-"+self.image()
    }

    method imagenNueva(direccion) // Describe la imagen nueva del visual con movimiento en base a la dirección dada.
}

// ################################################################################################################################ \\

class VisualAtravesable inherits Visual(esAtravesable = true){} // Representa un visual atravesable, es decir, que no tiene colisión.

// ################################################################################################################################ \\

class VisualInteractuable inherits VisualAtravesable{
    const bloqueInteraccion // Representa el bloque que contiene la interacción completa del visual.

    override method interaccion(){
        // Aplica el bloque de interacción cargado actualmente en el visual.
        bloqueInteraccion.apply(self)
    }
}

// ################################################################################################################################ \\

class Obstaculo inherits Visual(image = "obstaculo.png"){} // Representa a un obstaculo.

// ################################################################################################################################ \\

class ParedInvisible inherits Visual(image = "vacio.png"){} // Representa a una pared invisible.

// ################################################################################################################################ \\

const leña        = new VisualInteractuable(image = "leña.png", position = game.at(5,5), bloqueInteraccion = interaccionLeña)
const nota        = new VisualInteractuable(image = "nota.png", position = game.at(5,5), bloqueInteraccion = interaccionNota)
const auto        = new VisualInteractuable(image = "vacio.png", position = game.at(5,5), bloqueInteraccion = interaccionAuto)
const cabañaOBJ   = new VisualAtravesable(image = "cabaña_entrada.png", position = game.at(5,6))
const graneroOBJ  = new VisualAtravesable(image = "granero.png",        position = game.at(6,6))
const fogataOBJ   = new Visual(image = "fogata.png", position = game.at(3,4))
const amiga       = new Visual(image = "amiga.png",  position = game.at(2,4))
const carpa       = new Visual(image = "carpa.png",  position = game.at(6,4))
const gameover    = new Visual(image = "game-over.png")
const juegoGanado = new Visual(image = "game-win.png")
const hacha       = new Arma(image = "hacha.png",    position = game.at(5,5), nuevoEstado = agresivoProtagonistaH)
const tridente    = new Arma(image = "tridente.png", position = game.at(6,6), nuevoEstado = agresivoProtagonistaT)
const manopla     = new Arma(image = "manopla.png",  position = game.at(7,7), nuevoEstado = agresivoProtagonistaM)

// ################################################################################################################################ \\

const interaccionLeña = {visual => game.removeVisual(visual);
                                   game.addVisual(puertaEntradaCabaña);
                                   puertaEntradaCabaña.irHacia(entradaCabaña);
                                   game.say(protagonista, "Gracias por la leña.");
                                   game.say(guardabosques, "No hay de que, tenga cuidado que hay lobos por la zona.");
                                   entradaCabaña.configuradorTotal(entradaCabañaConfgV2, entradaCabañaCESv2)}

const interaccionNota = {visual => game.removeVisual(visual);
                                   game.say(protagonista, "SI SOBREVIVISTE TE ESPERO EN LA CUEVA...");
                                   game.addVisual(puertaEntradaCabaña)}

const interaccionAuto = {visual => game.removeVisual(visual); 
                                   videojuego.juegoGanado()}

// ################################################################################################################################ \\

class Arma inherits VisualAtravesable{
    const usuario = protagonista // Representa el usuario que utiliza el arma.
    const property nuevoEstado   // Representa el nuevo estado del usuario que utiliza el arma.

    override method interaccion(){
        // Aplica el bloque de acciones del arma cargado actualmente.
        game.say(protagonista, "Pulsa K para atacar")
        videojuego.removerVisualesArmas()
        usuario.agarrarArma(self)
    }
}

// ################################################################################################################################ \\