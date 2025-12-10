import wollok.game.*
import niveles.*
import levelDevil.*

// Clase base para visualizadores
class VisualSoloLectura {
    const property position

    var property image

    method ponerImagen(){
        game.addVisual(self)
    }
}

class VisualizadorTexto {
    const property position
    var property text = ""
    
    method textColor() = "FFFFFF"
    
    method ponerTexto() {
        game.addVisual(self)
    }
}

// Lo cree asi porque de la manera que lo hacia sin herencia no funcionaba
class VisualizadorPuntaje inherits VisualizadorTexto {
    override method text() = "                   PUNTOS = " + gestorDeJugadores.jugadorActual().puntajeCompleto().toString()

    override method ponerTexto() {
        const estaElTexto = game.hasVisual(self)
        if (estaElTexto) {
            game.removeVisual(self)
        }
        super()
    }
}

// Visualizador de vidas
class VisualizadorVida inherits VisualSoloLectura(image="Vida_V2.png") {}

// Visualizador de niveles
class VisualizadorNivel inherits VisualSoloLectura(image="NivelActual.png") {}

// Gestor central de visualizadores
object gestorVisualizadores {
    const visualizadorPuntaje = new VisualizadorPuntaje(position = game.at(0, 11))
    var visualizadorPuntajeActivo = false
    
    method iniciar() {
        self.limpiar()
        visualizadorPuntaje.ponerTexto()
        game.onTick(100, "actualizarPuntaje", { visualizadorPuntaje.ponerTexto() })
        visualizadorPuntajeActivo = true
        
        self.actualizarVidas(gestorDeJugadores.vidasActuales())
        self.actualizarNiveles()
    }
    
    method actualizarVidas(cantidadVidas) {
        gestorVisualizadorVidas.actualizarVidas(cantidadVidas)
    }
    
    method actualizarNiveles() {
        const numeroNivelActual = juegoLevelDevil.numeroDeNivel()
        gestorVisualizadorNiveles.actualizarNiveles(numeroNivelActual)
    }

    method limpiar() {
        game.removeTickEvent("actualizarPuntaje")

        const estaElTexto = game.hasVisual(visualizadorPuntaje)

        if (estaElTexto) {
            game.removeVisual(visualizadorPuntaje)
        }
        gestorVisualizadorVidas.limpiar()
        gestorVisualizadorNiveles.limpiar()
        
        visualizadorPuntajeActivo = false
    }
}

object gestorVisualizadorVidas {
    const visualizadores = []

    method limpiar() {
        visualizadores.forEach({ visual => game.removeVisual(visual) })
        visualizadores.clear()
    }
    
    method actualizarVidas(cantidadVidas) {
        self.limpiar()
        
        // Crear nuevos visualizadores según la cantidad de vidas
        cantidadVidas.times({ i => 
            const visualizador = new VisualizadorVida(position = game.at(0, 10 - (i - 1)))
            visualizador.ponerImagen()
            visualizadores.add(visualizador)
        })
    }
}

object gestorVisualizadorNiveles {
    const visualizadores = []
    
    method cantidadNiveles() {
        return juegoLevelDevil.cantidadNiveles()
    }
    
    method limpiar() {
        visualizadores.forEach({ visual => game.removeVisual(visual) })
        visualizadores.clear()
    }
    
    method actualizarNiveles(numeroNivel) {
        self.limpiar()
        
        // Calculamos la posición inicial para centrar los niveles
        const cantTotal = self.cantidadNiveles()
        const posXInicial = 11 - (cantTotal / 2).truncate(0)
        
        cantTotal.times({ i =>
            const nivelActual = i // Nivel comienza en 1
            const visualizador = new VisualizadorNivel(
                position = game.at(posXInicial + i, 11),
                // Si el nivel actual es menor o igual al número de nivel en curso, ya está completado
                image = if (nivelActual <= numeroNivel) "NivelActual.png" else "NivelFaltante.png"
            )
            visualizador.ponerImagen()
            visualizadores.add(visualizador)
        })
    }
}