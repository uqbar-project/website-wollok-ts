class Direccion{
    const dx = 0 // Representa el valor a aumentar o disminuir en la dirección "x".
    const dy = 0 // Representa el valor a aumentar o disminuir en la dirección "y".

    method siguientePosicion(posicion){
        // Devuelve la siguiente posición de la posición dada, según lo almacenado en las constantes "dx" y "dy".
        return game.at(posicion.x() + dx, posicion.y() + dy)
    }
}

object arriba    inherits Direccion(dy =  1){} // Representa la dirección Arriba en el tablero.
object abajo     inherits Direccion(dy = -1){} // Representa la dirección Abajo en el tablero.
object izquierda inherits Direccion(dx = -1){} // Representa la dirección Izquierda en el tablero.
object derecha   inherits Direccion(dx =  1){} // Representa la dirección Derecha en el tablero.

// ###################################################################################################################### \\

class UbicacionPuerta{
    const x // Representa el valor de la coordenada "x".
    const y // Representa el valor de la coordenada "y".

    method ubicacion(){
        // Devuelve la posición resultante de la combinación de los valores almacenados en las constantes "x" e "y".
        return game.at(x, y)
    }
}

const norte = new UbicacionPuerta(x = 6,  y = 8) // Representa la ubicación de la puerta al Norte en el tablero.
const sur   = new UbicacionPuerta(x = 6,  y = 0) // Representa la ubicación de la puerta al Sur en el tablero. 
const este  = new UbicacionPuerta(x = 12, y = 4) // Representa la ubicación de la puerta al Este en el tablero.  
const oeste = new UbicacionPuerta(x = 0,  y = 4) // Representa la ubicación de la puerta al Oeste en el tablero.  

// ###################################################################################################################### \\

class Eje{
    const primeraDir // Representa la primera dirección en el eje.
    const segundaDir // Representa la segunda dirección en el eje.

    method movimiento(posicionAntigua, posicionNueva){
        // Describe el número resultante de restar la posición nueva con la antigua.
        return self.positionEnEje(posicionNueva) - self.positionEnEje(posicionAntigua)
    }

    method seSumoEnEje(posicionAntigua, posicionNueva){
        // Indica si se sumó en el eje dado una posición antigua, y una posición nueva.
        return self.movimiento(posicionAntigua, posicionNueva) == 1
    }

    method seRestoEnEje(posicionAntigua, posicionNueva){
        // Indica si se restó en el eje dado una posición antigua, y una posicion nueva.
        return self.movimiento(posicionAntigua, posicionNueva) == -1
    }
    
    method estaEnMismoEje(visualPrimero, visualSegundo){
        // Indica si el visualPrimero se encuentra en el mismo eje que el visualSegundo.
        const posicionPrimero = visualPrimero.position()
        const posicionSegundo = visualSegundo.position()

        return self.positionEnEje(posicionPrimero) == self.positionEnEje(posicionSegundo) 
    }

    method estaAlLado(visualPrimero, visualSegundo){
        // Indica si el visualPrimero se encuentra al lado (a una celda de diferencia) del visualSegundo.
        const posicionPrimero = visualPrimero.position()
        const posicionSegundo = visualSegundo.position()

        return (self.positionEnEje(posicionPrimero) - self.positionEnEje(posicionSegundo)).abs() == 1 
    }

    method positionEnEje(posicion) // Describe la posición en el eje.

    method primeraDir(){
        // Describe la primera dirección del eje.
        return primeraDir
    }

    method segundaDir(){
        // Describe la segunda dirección del eje.
        return segundaDir
    }
}

// ###################################################################################################################### \\

object ejeX inherits Eje(primeraDir = derecha, segundaDir = izquierda){

    override method positionEnEje(posicion){
        // Describe la posición en el eje.
        return posicion.x()
    }
}

// ###################################################################################################################### \\

object ejeY inherits Eje(primeraDir = arriba, segundaDir = abajo){
    
    override method positionEnEje(posicion){
        // Describe la posición en el eje.
        return posicion.y()
    }
}

// ###################################################################################################################### \\