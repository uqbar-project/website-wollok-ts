import levelDevil.*
import tecladoYMenu.*
import visualizadores.*

// Nivel Base
class NivelBase {
    method mapaDeCuadricula() = [] /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
    
    var property siguienteNivel = null
    
    method numeroDeNivel() // Cada nivel debe implementar este método

    method iniciar() {
        gestorDeJugadores.resetearPuntajeTemporal()
        juegoLevelDevil.limpiar()

        new VisualSoloLectura(image="BotonMenu.png",position = game.at(22,11)).ponerImagen()
        new VisualSoloLectura(image="BotonReiniciar.png",position = game.at(0,0)).ponerImagen()

        // Dibujar el nivel usando el mapaDeCuadricula
        self.dibujarNivel()

        // Activar Colisiones
        juegoLevelDevil.activarColisiones()

        // Habilitar controles
        configTeclado.juegoEnMarcha()
        
        // Actualizar visualizador de niveles y vidas
        gestorVisualizadores.iniciar()
    }

    // Método para dibujar el nivel basado en el mapaDeCuadricula
    method dibujarNivel() {
        self.ponerEnElMapa({ celda, x, y => 
            if(celda.agregarPiso()) {
                _.agregarAlNivel(x, y)
            }
        })
        self.ponerEnElMapa({ celda, x, y => 
            if(celda.esJugador()) {
                celda.agregarAlNivel(x, y)
                self.dibujarJugador()
            }
        })
        self.ponerEnElMapa({ celda, x, y => 
            if(!celda.esPiso() and !celda.esJugador()) {
                celda.agregarAlNivel(x, y)
            }
        })
    }

    method ponerEnElMapa(accion) {
        var y = game.height() - 1
        self.mapaDeCuadricula().forEach({ fila =>
            var x = 0
            fila.forEach({ celda =>
                accion.apply(celda, x, y)
                x += 1
            })
            y -= 1
        })
    }

    method dibujarJugador() {
        game.addVisual(gestorDeJugadores.jugadorActual())
    }
}

class AgregadoDeClasesObjetos {
    method agregarPiso() = true

    method esPiso() = false

    method esJugador() = false
}

// Vacio
object v inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(_x, _y) {}

    override method agregarPiso() = false
}

// Piso
object _ inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const piso = new Piso(position = game.at(x, y))
        piso.ponerImagen()
    }

    override method esPiso() = true
}

// Pared
object p inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const pared = new Pared(position = game.at(x, y))
        pared.ponerImagen()
    }
}

// Meta
object m inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const meta = new Meta(position = game.at(x, y))
        meta.ponerImagen()
    }
}

// Moneda
object d inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const moneda = new Moneda(position = game.at(x, y))
        moneda.ponerImagen()
    }
}

// Moneda Falsa
object f inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const monedaFalsa = new MonedaFalsa(position = game.at(x, y))
        monedaFalsa.ponerImagen()
    }
}

// Pincho
object s inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const pincho = new Pincho(position = game.at(x, y))
        pincho.ponerImagen()
    }
}

// Pincho Invisible
object i inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const pinchoInv = new PinchoInvisible(position = game.at(x, y))
        pinchoInv.ponerImagen()
        pinchoInv.hacerVisible()
    }
}

// Pincho Invisible Instantaneo
object n inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const pinchoInvInst = new PinchoInvisibleInstantaneo(position = game.at(x, y))
        pinchoInvInst.ponerImagen()
    }
}

// Pincho Movil
object h inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const pinchoMov = new PinchoMovil(position = game.at(x, y))
        pinchoMov.ponerImagen()
        pinchoMov.moverPinchoMovil()
    }
}

// Jugador
object j inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const jugador = gestorDeJugadores.jugadorActual()
        jugador.position(game.at(x, y))
    }

    override method esJugador() = true
}

object a inherits AgregadoDeClasesObjetos {
    method agregarAlNivel(x, y) {
        const flechas = new VisualSoloLectura(image="Flechas.png", position = game.at(x, y))
        flechas.ponerImagen()
    }

    override method agregarPiso() = false
}

// Niveles específicos
object nivel1 inherits NivelBase(siguienteNivel = nivel2) {
    override method numeroDeNivel() = 1

    override method mapaDeCuadricula() = [
        /* Nivel 1 - El engaño (fácil en apariencia) */
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                    // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,s,p,p,p,p,p,p,p,p,p,_,_,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,_,_,_,_,p,d,d,d,d,p,_,_,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,j,p,_,_,_,_,p,p,d,p,s,_,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,_,p,p,_,p,_,_,p,_,i,m,_,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,_,_,_,_,p,p,p,p,p,_,i,_,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,_,p,p,_,p,_,_,_,_,_,_,_,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,s,p,_,_,_,_,p,s,p,p,_,_,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,_,p,p,p,s,p,p,p,p,_,_,_,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,a,v,v,v,v]
    ]
}

object nivel2 inherits NivelBase(siguienteNivel = nivel3) {
    override method numeroDeNivel() = 2
    
    override method mapaDeCuadricula() = [
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                    // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,p,n,p,_,_,m,n,_,p,p,f,_,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,f,d,_,_,p,p,p,d,d,_,h,_,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,p,d,d,p,d,_,h,p,d,_,_,_,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,d,p,_,_,p,_,_,p,i,_,_,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,_,_,p,_,_,_,_,_,p,_,f,_,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,_,p,_,_,p,p,p,_,_,_,d,_,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,_,_,_,_,p,_,_,_,p,p,_,_,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,_,_,_,s,j,_,_,_,_,_,d,f,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]

    override method iniciar() {
        super()
        configTeclado.cambiarTecladoA(tecladoInvertido)
    }
}

object nivel3 inherits NivelBase(siguienteNivel = nivel4) {
    override method numeroDeNivel() = 3
    
    override method mapaDeCuadricula() = [
        // "El Corredor de las Decisiones Tontas"
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,p,s,_,_,p,p,p,p,p,p,m,p,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,p,_,p,_,d,_,_,d,_,_,_,p,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,p,_,_,_,p,_,_,p,p,p,_,p,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,_,p,_,d,_,d,_,f,p,_,p,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,p,_,p,p,n,p,i,p,i,p,_,d,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,_,_,_,_,_,_,_,_,_,p,f,p,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,_,p,p,p,p,d,p,p,p,p,i,p,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,_,_,j,s,_,_,_,_,_,_,_,n,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]
}

object nivel4 inherits NivelBase(siguienteNivel = nivel5) {
    override method numeroDeNivel() = 4
    
    override method mapaDeCuadricula() = [
        // "El Laberinto de la Codicia"
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,p,p,p,p,p,p,p,p,p,m,n,p,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,p,_,_,_,_,_,p,d,n,_,_,p,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,p,_,p,p,p,_,p,_,p,_,n,p,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,_,_,d,f,_,_,_,_,_,f,p,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,p,i,_,_,p,p,p,p,p,p,h,p,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,p,p,_,_,_,d,n,f,_,_,_,p,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,s,p,f,_,p,p,p,_,_,p,p,p,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,j,_,_,_,_,_,_,_,_,_,_,p,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]

    override method iniciar() {
        super()
        configTeclado.cambiarTecladoA(tecladoEnManesillasDeReloj)
    }
}

object nivel5 inherits NivelBase(siguienteNivel = nivel6) {
    override method numeroDeNivel() = 5
    
    override method mapaDeCuadricula() = [
        // "El Cubo de las Malas Decisiones"
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,d,f,p,p,p,_,p,p,p,m,_,_,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,_,p,_,_,d,p,s,_,_,p,_,_,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,_,_,_,p,_,_,_,p,_,_,_,_,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,_,_,i,_,j,_,d,_,_,_,p,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,p,_,p,p,_,_,_,p,p,_,_,p,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,_,_,_,_,f,p,_,_,_,_,_,_,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,_,p,_,_,_,_,_,_,_,_,p,_,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,_,d,p,p,p,p,p,p,p,p,h,_,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]

    override method iniciar() {
        super()
        configTeclado.cambiarTecladoA(tecladoEnManesillasDeReloj)
    }
}

object nivel6 inherits NivelBase(siguienteNivel = nivel7) {
    override method numeroDeNivel() = 6
    
    override method mapaDeCuadricula() = [
        // "El Falso Atajo"
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,i,p,p,p,p,p,p,p,p,p,p,p,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,_,f,d,_,_,_,_,_,d,d,f,p,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,j,_,_,_,n,_,_,p,p,p,p,p,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,p,p,p,p,p,_,_,_,_,_,_,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,_,_,_,_,_,_,_,p,i,f,s,d,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,s,_,s,_,n,p,_,p,p,p,p,p,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,f,d,d,d,h,p,_,_,_,_,_,m,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,p,p,p,p,p,p,p,p,p,p,p,p,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]
}

object nivel7 inherits NivelBase(siguienteNivel = creditosFinales) {
    override method numeroDeNivel() = 7
    
    override method mapaDeCuadricula() = [
        /* Recomendable no usar la fila y = 0 o 1 o 10 o 11 ni la x = 0 o 1 o 22 o 23 */
        // 24 columnas x 12 filas
                // x = 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
        /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 9*/  [v,v,v,v,v,v,f,p,p,h,_,p,p,d,f,p,p,d,v,v,v,v,v,v],
        /* y = 8*/  [v,v,v,v,v,v,d,_,_,p,_,_,_,_,p,_,_,_,v,v,v,v,v,v],
        /* y = 7*/  [v,v,v,v,v,v,d,p,_,_,_,_,_,_,_,_,p,m,v,v,v,v,v,v],
        /* y = 6*/  [v,v,v,v,v,v,p,_,_,_,_,p,p,_,_,_,_,p,v,v,v,v,v,v],
        /* y = 5*/  [v,v,v,v,v,v,f,p,_,_,f,p,p,d,_,_,p,i,v,v,v,v,v,v],
        /* y = 4*/  [v,v,v,v,v,v,_,d,p,_,p,d,d,p,_,p,d,_,v,v,v,v,v,v],
        /* y = 3*/  [v,v,v,v,v,v,_,p,_,_,_,_,_,_,_,_,p,d,v,v,v,v,v,v],
        /* y = 2*/  [v,v,v,v,v,v,j,_,_,_,p,p,p,p,n,_,_,_,v,v,v,v,v,v],
        /* y = 1*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
        /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v]
    ]

    override method iniciar() {
        super()
        configTeclado.cambiarTecladoA(tecladoInvertido)
    }
}

object creditosFinales {
    method siguienteNivel() = null

    // Hay 4500 puntos posibles en el juego
    const puntajeMinimoParaGanar = 3500

    method esMayorElPuntajePersonajeActualQueElMinimoParaGanar() {
        return gestorDeJugadores.puntaje() > puntajeMinimoParaGanar
    }

    method iniciar() {
        // Limpiar todo, incluyendo visualizadores
        juegoLevelDevil.limpiar()
        juegoLevelDevil.detenerMovimientos()
        if(self.esMayorElPuntajePersonajeActualQueElMinimoParaGanar()) {
            new VisualSoloLectura(image="JuegoTerminadoGano.png", position = game.at(0, 0)).ponerImagen()
        } else {
            new VisualSoloLectura(image="JuegoTerminadoPerdio.png", position = game.at(0, 0)).ponerImagen()
        }
        game.schedule(10000, {
            juegoLevelDevil.limpiar()
            new VisualSoloLectura(image="CreditosFinales.png", position = game.at(0, 0)).ponerImagen()
            game.stop()
        })
    }
}