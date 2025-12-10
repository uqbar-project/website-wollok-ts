import protagonista.*
import direccion.*
import escenariosManager.*
import visualesExtra.*
import diapositivasManager.*
import dialogosManager.*

// ################################################################################################################## \\

object videojuego{  
    var property escenario = inicio                     // Representa el escenario actual del juego.
    const armasDisponibles = [tridente, manopla, hacha] // Representa todas las armas disponibles en el juego.
    
    // ============================================================================================================== \\

    method iniciar(){ 
        // Inicia el juego con el escenario cargado actualmente en el juego.
        escenario.puestaEnEscena()
    }

    method cambiarEscenario(escenarioNuevo){ 
        // Cambia el escenario actual del juego por el dado.
        escenario.limpiar()
        self.escenario(escenarioNuevo)
        escenario.puestaEnEscena()
    }

    method juegoPerdido(){    
        // Finaliza el juego ya que el jugador perdió.
        self.finalizarYMostrar(gameover, trackGameOver)
    }

    method juegoGanado(){     
        // Finaliza el juego ya que el jugador ganó.
        self.finalizarYMostrar(juegoGanado, trackWin)
    }
    
    method finalizarYMostrar(visual, sonido){
        // Finaliza el escenario actual y muestra el visual y el sonido dado.
        escenario.limpiar()
        game.clear()
        game.addVisual(visual) 
        game.sound(sonido).play()
        game.onTick(5000, "fin", {game.stop()})
    }
    
    method removerVisualesArmas(){
        // Remueve todos los visuales de las armas del juego.
        armasDisponibles.forEach({visual =>game.removeVisual(visual)})
    }

    // ============================================================================================================== \\
    
    method tablero(){
        // Define las carecterísticas fundamentales del tablero.
        game.width(13)
        game.height(9)
        game.cellSize(100)
        game.onCollideDo(protagonista, {objeto => objeto.interaccion()})
    }

    // ============================================================================================================== \\
    
    method controles(){
        // Define todos los controles posibles para el juego.
        keyboard.w().onPressDo({protagonista.mover(arriba)})
        keyboard.a().onPressDo({protagonista.mover(izquierda)})
        keyboard.s().onPressDo({protagonista.mover(abajo)})
        keyboard.d().onPressDo({protagonista.mover(derecha)})
        keyboard.e().onPressDo({gestorDeDialogo.interactuarConNPC()})
        keyboard.f().onPressDo({gestorDeDiapositivas.interactuarDiapositivas()})
        keyboard.k().onPressDo({protagonista.atacar()})
    }
}

// ################################################################################################################## \\