import levelDevil.*
import niveles.*
import visualizadores.*

object menu {
    method iniciar(){
        juegoLevelDevil.detenerMovimientos()
        juegoLevelDevil.limpiar()

        self.dibujarMenu()

        configTeclado.menuAbierto()
    }
    
    method dibujarMenu(){
        new VisualSoloLectura(image = "Logo_V1.png", position = game.at(8, 7)).ponerImagen()
        menuDePersonaje.iniciar()
    }
}

object menuDePersonaje {
    var property position = game.at(7, 4)
    var menuElegirPersonajesEstaAbierto = false
    const imagenMenuGeneral = "MenuGeneral.png"
    const imagenMenuPersonajes = "MenuDePersonajes_V2.png"
    var imagen = imagenMenuGeneral
    
    method image() = imagen
    
    method iniciar(){
        juegoLevelDevil.detenerMovimientos()
        position = game.at(7, 4)
        game.addVisual(self)
        configTeclado.menuAbierto()
        menuElegirPersonajesEstaAbierto = false
        imagen = imagenMenuGeneral
    }

    method desplegar() = if(menuElegirPersonajesEstaAbierto) self.cerrar() else self.abrir()

    method cerrar(){
        juegoLevelDevil.detenerMovimientos()
        position = game.at(7, 4)
        imagen = imagenMenuGeneral
        configTeclado.menuAbierto()
        menuElegirPersonajesEstaAbierto = false
    }

    method abrir(){
        juegoLevelDevil.detenerMovimientos()
        juegoLevelDevil.limpiar()
        position = game.at(0,0)
        imagen = imagenMenuPersonajes
        game.addVisual(self)
        configTeclado.menuAbiertoElegirPersonajes()
        menuElegirPersonajesEstaAbierto = true
    }
}

// Configuraciones de Teclado
object configTeclado {
    var teclado = tecladoNormal

    method cambiarTecladoA(nuevoTeclado) { 
        teclado = nuevoTeclado
    }

    method iniciar() {
        keyboard.up().onPressDo({ teclado.up() })
        keyboard.down().onPressDo({ teclado.down() })
        keyboard.left().onPressDo({ teclado.left() })
        keyboard.right().onPressDo({ teclado.right() })

        keyboard.r().onPressDo({ teclado.r() })
        keyboard.m().onPressDo({ teclado.m() })

        keyboard.j().onPressDo({ teclado.j() })
        keyboard.p().onPressDo({ teclado.p() })

        keyboard.num1().onPressDo({ teclado.num1() })
        keyboard.num2().onPressDo({ teclado.num2() })
        keyboard.num3().onPressDo({ teclado.num3() })
        keyboard.num4().onPressDo({ teclado.num4() })
    }

    method juegoEnMarcha() {
        teclado = tecladoNormal
    }

    method menuAbierto() {
        teclado = tecladoMenu
    }

    method menuAbiertoElegirPersonajes() {
        teclado = tecladoMenuElegirPersonajes
    }

    method juegoBloqueado() {
        teclado = tecladoBase
    }
}

class TecladoBase {
    method up() {}
    method down() {}
    method left() {}
    method right() {}

    method r() {}
    method m() {}

    method j() {}
    method p() {}

    method num1() {}
    method num2() {}
    method num3() {}
    method num4() {}
}

object tecladoBase inherits TecladoBase {}

class TecladoMenu inherits TecladoBase {
    override method j() { juegoLevelDevil.iniciarNivel() }
    override method p() { menuDePersonaje.desplegar() }
}

object tecladoMenu inherits TecladoMenu {}

object tecladoMenuElegirPersonajes inherits TecladoBase {
    override method num1() { juegoLevelDevil.volverAIniciarDeCero(jugadorLevelDevil) }
    override method num2() { juegoLevelDevil.volverAIniciarDeCero(zombie) }
    override method num3() { juegoLevelDevil.volverAIniciarDeCero(miniMessi) }
    override method num4() { juegoLevelDevil.volverAIniciarDeCero(satoruGojo) }
}

class TecladoGeneral inherits TecladoBase {
    override method r() { juegoLevelDevil.reiniciarNivel() }
    override method m() { menu.iniciar() }
}

object tecladoNormal inherits TecladoGeneral {
    override method up() { gestorDeJugadores.moverA(arriba) }
    override method down() { gestorDeJugadores.moverA(abajo) }
    override method left() { gestorDeJugadores.moverA(izquierda) }
    override method right() { gestorDeJugadores.moverA(derecha) }
}

object tecladoInvertido inherits TecladoGeneral {
    override method up() { gestorDeJugadores.moverA(abajo) }
    override method down() { gestorDeJugadores.moverA(arriba) }
    override method left() { gestorDeJugadores.moverA(derecha) }
    override method right() { gestorDeJugadores.moverA(izquierda) }
}

object tecladoEnManesillasDeReloj inherits TecladoGeneral {
    override method up() { gestorDeJugadores.moverA(izquierda) }
    override method right() { gestorDeJugadores.moverA(arriba) }
    override method down() { gestorDeJugadores.moverA(derecha) }
    override method left() { gestorDeJugadores.moverA(abajo) }
}

// Direcciones
class Movimiento {
    method puedeMoverse(position) {
        // Verificar que esté dentro de los límites del juego
        const noSalirDelMapa = !position.x().between(0, game.width() - 1) or !position.y().between(0, game.height() - 1)
        if (noSalirDelMapa) {
            return false
        }
        return game.getObjectsIn(position).size() > 0
    }

    method validarPosition(position) = self.puedeMoverse(position) and game.getObjectsIn(position).all({elem => elem.esPisable()}) 
    
    method calcularNuevaPosition(positionActual) {
        const nuevaPosition = self.moverEnDireccion(positionActual)
        const validarPosition = self.validarPosition(nuevaPosition)
        if(validarPosition){
            return nuevaPosition
        } else {
            return positionActual
        }
    }
    
    method moverEnDireccion(position)
}

object arriba inherits Movimiento {
    override method moverEnDireccion(position) = position.up(1)
}

object abajo inherits Movimiento {
    override method moverEnDireccion(position) = position.down(1)
}

object izquierda inherits Movimiento {
    override method moverEnDireccion(position) = position.left(1)
}

object derecha inherits Movimiento {
    override method moverEnDireccion(position) = position.right(1)
}
