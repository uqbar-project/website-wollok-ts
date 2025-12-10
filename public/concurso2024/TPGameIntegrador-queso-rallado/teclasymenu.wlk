import wollok.game.*
import unahBlocks.*
import niveles.*
import sonidosEfecto.*



object imagenDeMenu {
    method position() = game.origin() 
    method image() = "imagenDeMenu.png"
}

object menu {
    var musicaActivada = false

    method reiniciarMusicaActivada() {musicaActivada = false}
    method mostrar() {
        
        game.addVisual(imagenDeMenu) //inicializa imagen menu

        keyboard.num1().onPressDo({ //al tocar 1 se elimina el visual de menu, arranca el nivel 1 y jugamos con dino
            game.removeVisual(imagenDeMenu)
            if (not musicaActivada) {
                musicaFondo.iniciar()
                musicaActivada = true}
            nivel1.cargar(dino)
            movimientoTeclado.configurar(dino, nivel1) 
        })

        keyboard.r().onPressDo({ //reiniciar nivel
            game.clear()    
            self.mostrar()
         })
    }
}

object movimientoTeclado { 
    method configurar(personaje, nivel)  { //configuramos tambien que nivel
        keyboard.up().onPressDo({personaje.moverArriba()}) //nivel.verificarVictoria(personaje)}) //cambio cada que toca una flechita verifica si todas las cajas estan ubicadas en el destino
        keyboard.down().onPressDo({personaje.moverAbajo()})
        keyboard.left().onPressDo({personaje.moverIzquierda()})
        keyboard.right().onPressDo({personaje.moverDerecha()}) 
        keyboard.r().onPressDo({
            game.clear()
            game.sound("reset.mp3").play()     
            nivel.cargar(dino)
            self.configurar(dino, nivel)
        })
        keyboard.t().onPressDo({ //volver al menu
            game.clear()    
            menu.mostrar()

        })

        game.whenCollideDo(dino, { elemento => dino.empuja(elemento) nivel.verificarVictoria(personaje) })
       
    }
}