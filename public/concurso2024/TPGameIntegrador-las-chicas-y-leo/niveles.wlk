import wollok.game.*
import mozo.*
import elementos.*
import clientes.*
import configuracion.*
import temporizador.*
import textoystatsvisuales.*
import sonido.*

// este script contiene los NIVELES y distintas escenas que contendrá nuestro videojuego.

// NIVEL 1
object nivel1 {
    // INICIALIZAR NIVEL 1
    method iniciar() {
        config.configurarTeclas() // Ejecuta la configuración de las TECLAS del niveL

        game.addVisual(mozo)
        // Añadimos al mozo a la escena, optamos por quitarle el "character" ya que
        // Precisamos controlar las acciones del teclado para las colisiones y otras necesidades
        
        elementoSolido.todosLosElementosSolidos().forEach({elemento => game.addVisual(elemento)}) // Se añaden TODOS los elementos sólidos a la escena

        config.iniciarFantasmas(config.tiempoAlAzar()) // Inicializamos tres fantasmas en un tiempo al azar

        visuales.todosLosStats().forEach({elemento => game.addVisual(elemento)})  // Se añaden TODOS los stats visuales a la escena

        game.addVisual(cartelReloj)
        game.addVisual(temporizador) // Se añade el temporizador visual a la escena

        game.addVisual(visuales.textoNivel1())

        cliente.todosLosFantasmas().forEach({f => f.actualizarRelojFantasma(30)})

        mozo.actualizarCondicionPerdida(3)

        temporizador.correrTiempo() // Se inicializa el temporizador de la partida
    }
}

// NIVEL 2
object nivel2 {
    // INICIALIZAR NIVEL 2
    method iniciar() {
        config.configurarTeclas() // Ejecuta la configuración de las TECLAS del niveL

        game.addVisual(mozo)
        // Añadimos al mozo a la escena, optamos por quitarle el "character" ya que
        // Precisamos controlar las acciones del teclado para las colisiones y otras necesidades
        
        elementoSolido.todosLosElementosSolidos().forEach({elemento => game.addVisual(elemento)}) // Se añaden TODOS los elementos sólidos a la escena

        config.iniciarFantasmas(config.tiempoAlAzar()) // Inicializamos tres fantasmas en un tiempo al azar

        visuales.todosLosStats().forEach({elemento => game.addVisual(elemento)})  // Se añaden TODOS los stats visuales a la escena

        game.addVisual(cartelReloj)
        game.addVisual(temporizador) // Se añade el temporizador visual a la escena

        game.addVisual(visuales.textoNivel2())

        temporizador.configurarTemporizador(120)

        cliente.todosLosFantasmas().forEach({f => f.actualizarRelojFantasma(25)})

        mozo.actualizarCondicionPerdida(1)

        temporizador.correrTiempo() // Se inicializa el temporizador de la partida
    }
}

// MENÚ PRINCIPAL
object menu {
    // INICIALIZAR MENÚ PRINCIPAL
    method iniciar() {

        if (!game.hasVisual(pantallaMenu)) game.addVisual(pantallaMenu) // Se asegura de mostrar el menú, si no, lo añade
        
        // TECLA INICIAR NIVEL 1
        keyboard.num1().onPressDo({ 
            if (game.hasVisual(pantallaMenu)){ // Se asegura que estemos en el menú
                self.ocultarMenu()
                nivel1.iniciar()
            }
        })

        // TECLA INICIAR NIVEL 2
        keyboard.num2().onPressDo({ 
            if (game.hasVisual(pantallaMenu)){ // Se asegura que estemos en el menú
                self.ocultarMenu()
                nivel2.iniciar()
            }
        })

        // TECLA INICIAR MENÚ CONTROLES
        keyboard.c().onPressDo({ 
            if (game.hasVisual(pantallaMenu)){ // Se asegura que estemos en el menú
                self.ocultarMenu()
                controles.iniciar()
            }
        })

        // TECLA SALIR DEL JUEGO
        keyboard.shift().onPressDo({
            if (game.hasVisual(pantallaMenu)){ // Se asegura que estemos en el menú
                game.stop()
            }
        })
    }

    // MÉTODO PARA OCULTAR EL MENÚ
    method ocultarMenu() {
        if (game.hasVisual(pantallaMenu)) // Se asegura que estemos en el menú
            game.removeVisual(pantallaMenu)
 	} 
}

// VISUAL DEL MENÚ PRINCIPAL
object pantallaMenu {
    const property image = "menuAnimadoGC.gif"
    const property position = game.at(0, 0) 
}

// MENÚ CONTROLES
object controles {
    // INICIALIZAR MENÚ CONTROLES
    method iniciar() {

        game.addVisual(pantallaControles)

        // TECLA VOLVER AL MENÚ PRINCIPAL
        keyboard.c().onPressDo({ 
            if (game.hasVisual(pantallaControles)){
                game.removeVisual(pantallaControles)
                menu.iniciar()
            }
        })
    }
}

// VISUAL DE CONTROLES
object pantallaControles {
    const property image = "menuControles.png"
    const property position = game.at(0, 0) 
}

object volverAlMenu {
    method volverAlMenuDesdePantallaFinal(visual) {
        keyboard.m().onPressDo({
            if (game.hasVisual(visual)){
                game.removeVisual(visual)
                menu.iniciar()
            }
        })
    }
}

// PANTALLA VICTORIA
object victoria {
    method iniciar() {

        if (!game.hasVisual(pantallaVictoria)) {game.addVisual(pantallaVictoria)}

        volverAlMenu.volverAlMenuDesdePantallaFinal(pantallaVictoria)
    }
}

// VISUAL DE VICTORIA
object pantallaVictoria {
    // volver al menu, salir del juego
    method image() = "ganaste.png"
    method position() = game.at(0, 0)
}

// PANTALLA DERROTA
object derrota {
    method iniciar() {
        if (!game.hasVisual(pantallaDerrota)) {game.addVisual(pantallaDerrota)}

        volverAlMenu.volverAlMenuDesdePantallaFinal(pantallaDerrota)
    }
}

// VISUAL DE DERROTA
object pantallaDerrota {
    // reiniciar, volver al menu, salir del juego
    method image() = "perdiste.png"
    method position() = game.at(0, 0)
}