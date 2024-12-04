import wollok.game.*
import personajes.personaje.*
import personajes.noel.*
import personajes.dangalf.*
import enemigos.*
import extras.*
import posiciones.*
import sonidos.*
import stats.*
import managers.*
import tienda.*
import estadosJuego.*
import pantallas.*


object juego {

    var property estado = estadoMenu 
    var property jugador = noel
    var property musicaActual = musicaMenu

    method elegirNoel() {
        jugador = noel
    }

    method elegirDangalf() {
        jugador = dangalf
    }

    method inicio() {
        self.iniciarSonidoMenu()
        estado = estadoMenu
        game.addVisual(pantalla)
    }

    method iniciarSonidoMenu() {
        musicaActual.play()
    }

    method frenarSonidoMenu() {
        musicaActual.stop()
    }

    method teclas() {
        //ataque
        keyboard.left().onPressDo({estado.ataque(izquierda)})
        keyboard.right().onPressDo({estado.ataque(derecha)})
        keyboard.up().onPressDo({estado.ataque(arriba)})
        keyboard.down().onPressDo({estado.ataque(abajo)})
        keyboard.q().onPressDo({estado.especial()})
        //movimiento
        keyboard.w().onPressDo({estado.mover(arriba)})
	    keyboard.a().onPressDo({estado.mover(izquierda)})
	    keyboard.s().onPressDo({estado.mover(abajo)})
	    keyboard.d().onPressDo({estado.mover(derecha)})
        //Tienda
        keyboard.j().onPressDo({estado.mejorarVida()})
        keyboard.k().onPressDo({estado.mejorarArma()})
        keyboard.l().onPressDo({estado.mejorarEnergia()})
        //menu
        keyboard.enter().onPressDo({estado.continuar()})
        keyboard.o().onPressDo({estado.elegirNoel()})
        keyboard.p().onPressDo({estado.elegirDangalf()})
    }

    method tablero() {
        game.title("desvariados") 
        game.width(20)
        game.height(15)
        game.cellSize(45)
    }

}