import videojuego.*
import protagonista.*
import visualesExtra.*
import direccion.*
import escenariosManager.*

// ############################################################################################################################################# \\

class Puerta inherits VisualInteractuable(image = "puerta.png", bloqueInteraccion = puertaBloque, position = game.origin()){
    var property irHacia = fogata // Representa el escenario al cual ir. Por defecto es "fogata".
}

// ############################################################################################################################################# \\

const puertaNorte = new Puerta(position = norte.ubicacion()) // Representa una puerta ubicada al Norte.    
const puertaOeste = new Puerta(position = oeste.ubicacion()) // Representa una puerta ubicada al Oeste.
const puertaEste  = new Puerta(position = este.ubicacion())  // Representa una puerta ubicada al Este.
const puertaSur   = new Puerta(position = sur.ubicacion())   // Representa una puerta ubicada al Sur.

const puertaEntradaCabaña = new Puerta(image = "puerta-cabaña.png",  irHacia = cabaña)  // Representa la puerta que se usa en la cabaña.
const puertaEntradaCueva  = new Puerta(image = "puerta-cueva.png",   irHacia = cueva)   // Representa la puerta que se usa en la cueva.
const puertaGranero       = new Puerta(image = "puerta-granero.png", irHacia = granero) // Representa la puerta que se usa en el granero.

// ############################################################################################################################################# \\

const puertaBloque = {puerta => videojuego.cambiarEscenario(puerta.irHacia())} // Es el bloque que representa de la interacción con la puerta.

// ############################################################################################################################################# \\