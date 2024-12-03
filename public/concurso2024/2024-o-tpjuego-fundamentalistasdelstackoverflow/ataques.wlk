import proyectiles.*
import general.*

const proyectilR1 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 2), id = "R1", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilR2 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 7), id = "R2", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilL1 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 2), id = "L1", velocidad = 100, delay = 1000, sentido = dirIzquierda)
const proyectilL2 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 7), id = "L2", velocidad = 100, delay = 1000, sentido = dirIzquierda)

const proyectilR3 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 2), id = "R3", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilR4 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 3), id = "R4", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilR8 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 4), id = "R8", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilR9 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 5), id = "R9", velocidad = 100, delay = 300, sentido = dirDerecha)

const proyectilR6 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 2), id = "R6", velocidad = 100, delay = 300, sentido = dirDerecha)
const proyectilL4 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 7), id = "L4", velocidad = 150, delay = 300, sentido = dirIzquierda)
const proyectilL5 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 3), id = "L5", velocidad = 25, delay = 1000, sentido = dirIzquierda)

const proyectilR7 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 3), id = "R7", velocidad = 150, delay = 150, sentido = dirDerecha)
const proyectilR5 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 5), id = "R5", velocidad = 150, delay = 300, sentido = dirDerecha)
const proyectilL3 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 4), id = "L3", velocidad = 50, delay = 150, sentido = dirIzquierda)

const proyectilDR1 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 17), id = "DR1", velocidad = 100, delay = 600, sentido = dirDiagonalDerecha)
const proyectilDR2 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 25), id = "DR2", velocidad = 100, delay = 300, sentido = dirDiagonalDerecha)
const proyectilDL1 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 17), id = "DL1", velocidad = 100, delay = 600, sentido = dirDiagonalIzquierda)
const proyectilDL2 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 25), id = "DL2", velocidad = 100, delay = 300, sentido = dirDiagonalIzquierda)

const proyectilDR3 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 30), id = "DR3", velocidad = 150, delay = 300, sentido = dirDiagonalDerecha)
const proyectilDR4 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 25), id = "DR4", velocidad = 150, delay = 500, sentido = dirDiagonalDerecha)
const proyectilDR5 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 20), id = "DR5", velocidad = 150, delay = 700, sentido = dirDiagonalDerecha)
const proyectilDR6 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 15), id = "DR6", velocidad = 150, delay = 900, sentido = dirDiagonalDerecha)
const proyectilDR7 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 10), id = "DR7", velocidad = 150, delay = 1100, sentido = dirDiagonalDerecha)

const proyectilDL3 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 30), id = "DL3", velocidad = 150, delay = 300, sentido = dirDiagonalIzquierda)
const proyectilDL4 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 25), id = "DL4", velocidad = 150, delay = 500, sentido = dirDiagonalIzquierda)
const proyectilDL5 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 20), id = "DL5", velocidad = 150, delay = 700, sentido = dirDiagonalIzquierda)
const proyectilDL6 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 15), id = "DL6", velocidad = 150, delay = 900, sentido = dirDiagonalIzquierda)
const proyectilDL7 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 10), id = "DL7", velocidad = 150, delay = 1100, sentido = dirDiagonalIzquierda)

const proyectilL6 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 2), id = "L6", velocidad = 100, delay = 300, sentido = dirIzquierda)
const proyectilL7 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 3), id = "L7", velocidad = 100, delay = 300, sentido = dirIzquierda)
const proyectilL8 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 4), id = "L8", velocidad = 100, delay = 300, sentido = dirIzquierda)
const proyectilL9 = new Proyectil(posicionInicial = new PositionMejorada(x = 32, y = 5), id = "L9", velocidad = 100, delay = 300, sentido = dirIzquierda)

const proyectilR10 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 2), id = "R10", velocidad = 150, delay = 1200, sentido = dirDerecha)
const proyectilR11 = new Proyectil(posicionInicial = new PositionMejorada(x = 0, y = 7), id = "R11", velocidad = 150, delay = 1200, sentido = dirDerecha)

class Ataque {
    const proyectiles
    
    method atacar() {
        proyectiles.forEach({proyectil => game.schedule(proyectil.delay(), {proyectil.direccion()})})

        return proyectiles.map({proyectil => proyectil.duracion()}).max()
    }
}

const ataquePerro1 = new Ataque(proyectiles = [proyectilR1, proyectilR2, proyectilL1, proyectilL2])
const ataquePerro2 = new Ataque(proyectiles = [proyectilR3, proyectilR4, proyectilR8, proyectilR9])
const ataquePerro3 = new Ataque(proyectiles = [proyectilR6, proyectilL4, proyectilL5])
const ataquePerro4 = new Ataque(proyectiles = [proyectilR7, proyectilR5, proyectilL3])

const ataqueGato1 = new Ataque(proyectiles = [proyectilDR1, proyectilDR2, proyectilDL1, proyectilDL2])
const ataqueGato2 = new Ataque(proyectiles = [proyectilDR3, proyectilDR4, proyectilDR5, proyectilDR6, proyectilDR7])
const ataqueGato3 = new Ataque(proyectiles = [proyectilDL3, proyectilDL4, proyectilDL5, proyectilDL6, proyectilDL7])

const ataqueFinal1 = new Ataque(proyectiles = [proyectilR1, proyectilL1, proyectilDR1, proyectilDR2, proyectilDL1, proyectilDL2])
const ataqueFinal2 = new Ataque(proyectiles = [proyectilDR3, proyectilDR4, proyectilDR5, proyectilDR6, proyectilDR7, proyectilL1, proyectilR1])
const ataqueFinal3 = new Ataque(proyectiles = [proyectilDL3, proyectilDL4, proyectilDL5, proyectilDL6, proyectilDL7, proyectilR3, proyectilR4, proyectilR8, proyectilR9])
const ataqueFinal4 = new Ataque(proyectiles = [proyectilL6, proyectilL7, proyectilL8, proyectilL9, proyectilR10, proyectilR11])