import wollok.game.*
import tanque.*
import powerUps.*
import mapa.*
import menus.*

const jugadores = [jugador1_tanque, jugador2_tanque]
const niveles = [nivel1, nivel2, nivel3]
const jugabilidades = [modo_versus, como_se_juega]

object juegoBattleCity {

    method ancho() {
        return 11
    }
    method alto() {
        return 10
    }
    method dibujarTablero(){
        game.width(self.ancho())
        game.height(self.alto())
        game.cellSize(50)
    }

    method configurar() {
        
        jugador2_tanque.actividad()
        jugador1_tanque.actividad()

        game.showAttributes(jugador1_tanque)

        game.onTick(jugador1_tanque.velocidad_balas(), "DesplazarBalasTanque1", {
            jugador1_tanque.balas_que_disparo_el_tanque().forEach({n => n.moverBalas() })
            })
        
        game.onTick(jugador2_tanque.velocidad_balas(), "DesplazarBalasTanque2", {
            jugador2_tanque.balas_que_disparo_el_tanque().forEach({n => n.moverBalas() })
            })

        game.onTick(5000, "APARECE POWER UPS", {spawnearPowerUps.elegirUnPowerAlAzar()})


        keyboard.backspace().onPressDo({

            inicio_batalla.stop()

            game.removeTickEvent("APARECE POWER UPS")

            game.clear()

            jugadores.forEach({unTanque => unTanque.resetearRondasGanadas() unTanque.normalizar()})

            gestion_menues.cambiar_fondo_y_opciones("menu_inicial.png", niveles)
            game.addVisual(visualizacion_mapa)

            modo_versus.retrocederAEsteMenuDinamico("menu_inicial.png", jugabilidades)
            
            })
    }

    method jugar() {

        self.dibujarTablero()
        gestion_menues.cambiar_fondo_y_opciones("menu_inicial.png", jugabilidades)
        game.start()
    }
}

