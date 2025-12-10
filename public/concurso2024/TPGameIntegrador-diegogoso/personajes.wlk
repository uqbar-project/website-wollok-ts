import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*

const guerrero = new Guerrero(
    nombre = "guerrero",
    image = "guerreroeste.png"
)

const arquero = new Arquero(
    nombre = "arquero",
    image = "arqueroeste.png"
)

const barbaro = new Barbaro(
    nombre = "barbaro",
    image = "barbaroeste.png"
)

const mago = new Mago(
    nombre = "mago",
    image = "magoeste.png"
)

const jefe = new Jefe(
    vida = 6,
    vidaInicial = 6,
    image = "jefe.png",
    poder = "bolaDeFuegoVerde.png"
)