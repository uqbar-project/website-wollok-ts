import _07harry.*
import _08dementores.*
import _05fondos.*
import _04visuales.*
import _11hechizo.*



object movimientos {
    const enemigos = visuales.enemigos()

    // los controles para mover a harry
    method configurarControles(jugador) {
        keyboard.w().onPressDo({jugador.moverseHaciaArriba()})
        keyboard.d().onPressDo({jugador.moverseHaciaDerecha()})
        keyboard.s().onPressDo({jugador.moverseHaciaAbajo()})
        keyboard.a().onPressDo({jugador.moverseHaciaIzquierda()})
        keyboard.b().onPressDo({ hechizo.dispararDesde(harry) })
        
    }
/*
    method desconfigurarControles() {
    // Desvincula las acciones de todas las teclas de control
    keyboard.w().onPressDo({})
    keyboard.d().onPressDo({})
    keyboard.s().onPressDo({})
    keyboard.a().onPressDo({})
    keyboard.b().onPressDo({}) 
}
*/


    // los enemigos se mueven aleatoriamente cada 2segundos
     method moverseDementores(){
        game.onTick(600, "moveDementor", { enemigos.forEach({d => d.buscarA(harry)}) })
        //game.onTick(600, {enemigosFijos.forEach(e => e.mover())})
        /*
        visuales.enemigos().forEach({rival => game.whenCollideDo(rival, {harry =>
		harry.perderVida()
			})
		})
*/
    }
    
}
