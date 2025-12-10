import wollok.game.*
import administracion.*
import objetos.*
import gestorSonido.*
import entidadBasicas.*
import direcciones.*
import niveles.*
import menu.*





class Jugador inherits EntidadQuePuedeEmpujar {
    var property miraDerechaAhora = true
    
    method inicializar() {
		position = gestorNiveles.posicionDeJugador()

    }

    method mover(direccion) {
        if (self.esMovible(direccion)){
            position = direccion.siguiente(position)
            self.empujar(direccion)
        }
    }
    method girarDerechaSiNoEsta() {
        if (not (self.miraDerechaAhora())){
            self.image("dino_der.png")
            self.miraDerechaAhora(true)
        } 
    }
    method girarIzquierdaSiNoEsta() {
        if (self.miraDerechaAhora()){
            self.image("dino_izq.png")
            self.miraDerechaAhora(false)
        }
    }
    method recargar() {
      game.removeVisual(jugador)
      game.addVisual(jugador)
    }
}

object controles {
    method jugadorMovimiento() {
        keyboard.up().onPressDo({ jugador.mover(arriba) })
        keyboard.down().onPressDo({ jugador.mover(abajo) })
        keyboard.left().onPressDo({ jugador.mover(izquierda) 
                                    jugador.girarIzquierdaSiNoEsta()})
        keyboard.right().onPressDo({ jugador.mover(derecha) 
                                        jugador.girarDerechaSiNoEsta()})
        keyboard.r().onPressDo({gestorNiveles.reiniciar()})
        keyboard.m().onPressDo({game.clear() 
                                
                               gestorSonido.quitaMusicaSiJuegoAunNoTermino()
                               gestorNiveles.reiniciarIndice()
                                menu.iniciar()
                                
                                
                                

                                })
        //keyboard.n().onPressDo({gestorNiveles.subirDeNivel()}) 
        //SOLO DESCOMENTAR SI SOS ADMIN para psar de nivel con la n
    }
}