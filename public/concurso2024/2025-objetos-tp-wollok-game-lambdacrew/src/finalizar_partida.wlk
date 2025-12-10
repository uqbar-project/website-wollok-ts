import battlecity.*
import tanque.*
import mapa.*
import menus.*

const musica_victoria = game.sound("finalizacion_partida.mp3")

class Mensajes {

    const mensajeADar
    const position

    method position() {
        return position
    }

    method text() {
        return mensajeADar
    }

    method textColor() = "FF8E00"

}
object gameOver {

    const imagenPantalla = "victoria.png"
    const posicion = new Position()
    

    const positionGanador = new Position( x = 5 ,y = 4)

    method image() {
        return imagenPantalla
    }

    method position() {
        return posicion
    }

    method darle_su_nueva_posicion_tanques (tanqueGanador) {

        tanqueGanador.position(positionGanador)

        game.addVisual(tanqueGanador)
    }

    method mostrar_mensaje(unTexto) {

        const mensajeFinalizarPartida = new Mensajes (position = new Position (x = 5, y = 5), mensajeADar = unTexto)

        game.addVisual(mensajeFinalizarPartida)
    }

    method volverAlMenu() {

        keyboard.backspace().onPressDo({

            musica_victoria.stop()

            game.clear()

            jugadores.forEach ({unTanque => unTanque.normalizar() unTanque.resetearRondasGanadas()})

            gestion_menues.cambiar_fondo_y_opciones("menu_inicial.png", niveles)

            game.addVisual(visualizacion_mapa)

            modo_versus.retrocederAEsteMenuDinamico("menu_inicial.png", jugabilidades)

        })
    }
}

object  resetear {
    
    method ronda() {

        game.schedule(5000, {gestion_niveles.nueva_ronda()})

    } 

}

object verificar_finalizacion_partida{

    method mensaje_victoria() {
        if (jugador1_tanque.rondas_ganadas() > 2) {
            game.say(jugador1_tanque, "GANEEEEE")
        }
        if (jugador2_tanque.rondas_ganadas() > 2) {
            game.say(jugador2_tanque, "YO GANEEEE")
        }
    }

    method gano_alguien() = jugador1_tanque.rondas_ganadas() > 2 || jugador2_tanque.rondas_ganadas() > 2
}