import niveles.*
import tecladoYMenu.*
import visualizadores.*

object juegoLevelDevil {
    var property nivelActual = nivel1

    const sonidoMenu = game.sound("Jugando.mp3")

    method iniciar() {
        game.title("Level Devil")
        game.height(12)
        game.width(24)
        game.boardGround("Fondo.png")

        sonidoMenu.shouldLoop(true)
        sonidoMenu.volume(0.1)
        sonidoMenu.play()

        configTeclado.iniciar()

        //Inicio el menu
        menu.iniciar()
    }
    
    const jugadoresActivosConColisiones = []

    method activarColisiones() {
        if(!jugadoresActivosConColisiones.contains(gestorDeJugadores.jugadorActual())) {
            jugadoresActivosConColisiones.add(gestorDeJugadores.jugadorActual())
            game.onCollideDo(gestorDeJugadores.jugadorActual(), { elemento => 
                elemento.interactuarConPersonaje(gestorDeJugadores.jugadorActual()) 
            })
        }
    }

    method limpiar() {
        gestorVisualizadores.limpiar()
        game.allVisuals().forEach({ visual => game.removeVisual(visual) })
    }
    
    method cantidadNivelesDesde(nivel) {
        if (nivel.siguienteNivel() == null) {
            return 0
        }
        return 1 + self.cantidadNivelesDesde(nivel.siguienteNivel())
    }
    
    method cantidadNiveles() = self.cantidadNivelesDesde(nivel1)

    method numeroDeNivel() = nivelActual.numeroDeNivel()
    
    method iniciarNivel() {
        nivelActual.iniciar()
    }

    method siguienteNivel() {
        // Primero, sumar el puntaje temporal al puntaje total antes de cambiar de nivel
        gestorDeJugadores.sumarPuntajeTemporalAlTotal()
        nivelActual = nivelActual.siguienteNivel()
        self.iniciarNivel()
    }
    
    method reiniciarNivel() {
        self.detenerMovimientos()
        self.limpiar()
        gestorDeJugadores.reiniciarVidas()
        self.iniciarNivel()
    }

    method detenerMovimientos() {
        configTeclado.juegoBloqueado()
        // Detener todos los PinchosMovil buscando sus tick events
        game.allVisuals()
            .filter({ visual => visual.toString().contains("PinchoMovil") })
            .forEach({ pinchoMovil => pinchoMovil.detenerMovimiento() })
    }

    method volverAIniciarDeCero(jugador) {
        gestorDeJugadores.resetearPuntaje()
        gestorDeJugadores.reiniciarVidas()
        gestorDeJugadores.seleccionarPersonaje(jugador)
        self.nivelActual(nivel1)
        self.iniciarNivel()
    }
}

object gestorDeJugadores {
    var jugadorActual = jugadorLevelDevil
    method jugadorActual() = jugadorActual

    method moverA(direccion) {
        self.jugadorActual().moverA(direccion)
    }

    method position() = self.jugadorActual().position()

    method vidasActuales() = self.jugadorActual().vidasActuales()

    method imagenesDeMeta() = self.jugadorActual().imagenesDeMeta()

    method position(pos) {
        jugadorActual.position(pos)
    }

    method puntaje() = jugadorActual.puntaje()

    method resetearPuntajeTemporal() {
        jugadorActual.resetearPuntajeTemporal()
    }

    method resetearPuntaje() {
        jugadorActual.resetearPuntaje()
    }

    method reiniciarVidas() {
        jugadorActual.reiniciarVidas()
    }
    
    method vidasActuales(cantidad) {
        jugadorActual.vidasActuales(cantidad)
    }

    method sumarPuntajeTemporalAlTotal() {
        jugadorActual.sumaDePuntaje(jugadorActual.puntajeTemporalPerdido() + jugadorActual.puntajeTemporalGanado())
    }

    method seleccionarPersonaje(jugador) {
        jugadorActual = jugador // Por ahora solo hay un personaje
    }
}

class Personaje {
    var property position

    var property vidasActuales
    const vidasPorDefecto

    var property puntaje = 0
    var puntajeTemporalGanado = 0
    var puntajeTemporalPerdido = 0

    const potencialDefensivoExtra

    method potencialDefensivo() = 10 * vidasActuales + potencialDefensivoExtra

    method reiniciarVidas() {
        vidasActuales = vidasPorDefecto
    }
    
    const imagenMuerto = "ExplosionAlMorir.gif"
    const imagenVivo
    var imagen = imagenVivo
    method image() = imagen

    const imagenesDeMeta
    method imagenesDeMeta() = imagenesDeMeta

    method esPisable() = true

    method esMeta() = false

    method mover(direccion) {
        const nuevaPosition = direccion.calcularNuevaPosition(self.position())
        self.position(nuevaPosition)
    }

    method morir() {
        vidasActuales -= 1
        gestorVisualizadores.actualizarVidas(vidasActuales)
        if (vidasActuales <= 0) {
            juegoLevelDevil.detenerMovimientos()
            imagen = imagenMuerto
            game.schedule(2000, {
                self.sumaDePuntaje(self.puntajeTemporalPerdido())
                self.reiniciarVidas()
                juegoLevelDevil.reiniciarNivel() // delegás en el gestor lo que pasa al morir
                imagen = imagenVivo
            })
        }
    }

    method puntaje() = puntaje

    method sumaDePuntaje(puntos) {
        puntaje += puntos
    }

    method puntajeTemporalGanado() = puntajeTemporalGanado

    method sumaDePuntajeTemporalGanado(puntos) {
        puntajeTemporalGanado += puntos
    }

    method puntajeTemporalPerdido() = puntajeTemporalPerdido

    method restaDePuntajeTemporalPerdido(puntos) {
        puntajeTemporalPerdido -= puntos
    }

    method resetearPuntajeTemporal() {
        puntajeTemporalGanado = 0
        puntajeTemporalPerdido = 0
    }

    method resetearPuntaje() {
        puntaje = 0
        self.resetearPuntajeTemporal()
    }

    method puntajeCompleto() = self.puntaje() + self.puntajeTemporalGanado() + self.puntajeTemporalPerdido()

    method sumarPuntajeTemporalAlTotal() {
        self.sumaDePuntaje(self.puntajeTemporalPerdido() + self.puntajeTemporalGanado())
    }
}

class JugadorCansado inherits Personaje() {
    var cantidadDeMovimientos = 0

    const cansancio

    method cantidadDeCansancio() = ((cantidadDeMovimientos * cansancio) / 10).truncate(0)

    method moverA(direccion) {
        cantidadDeMovimientos += 1
        game.schedule(self.cantidadDeCansancio(), { 
            self.mover(direccion)
        })
    }
}

class JugadorNoCansado inherits Personaje() {
    method moverA(direccion) {
        self.mover(direccion)
    }
}

object jugadorLevelDevil inherits JugadorNoCansado(
    position = game.at(0, 0), potencialDefensivoExtra = 10, imagenVivo = "JugadorLevelDevil_V1.png", vidasActuales = 1, vidasPorDefecto = 1, 
    imagenesDeMeta = ["MetaConJugadorLevelDevilParte1.png", "MetaConJugadorLevelDevilParte2.png", "MetaConJugadorLevelDevilParte3.png"]) {}

object zombie inherits JugadorCansado(
    position = game.at(0, 0), potencialDefensivoExtra = 250, imagenVivo = "Zombie.png", vidasActuales = 5, vidasPorDefecto = 5, 
    imagenesDeMeta = ["MetaConZombieParte1.png", "MetaConZombieParte2.png", "MetaConZombieParte3.png"], cansancio = 1) {}

object miniMessi inherits JugadorNoCansado(
    position = game.at(0, 0), potencialDefensivoExtra = 200, imagenVivo = "MiniMessi.png", vidasActuales = 4, vidasPorDefecto = 4, 
    imagenesDeMeta = ["MetaConMiniMessiParte1.png", "MetaConMiniMessiParte2.png", "MetaConMiniMessiParte3.png"]) {}

object satoruGojo inherits JugadorNoCansado(
    position = game.at(0, 0), potencialDefensivoExtra = 150, imagenVivo = "SatoruGojo_V2.png", imagenMuerto = "SatoruGojoMuerto_V2.png", vidasActuales = 3,
    vidasPorDefecto = 3, imagenesDeMeta = ["MetaConSatoruGojoParte1_V2.png", "MetaConSatoruGojoParte2_V2.png", "MetaConSatoruGojoParte3_V2.png"]) {}

class Piso {
    var property position

    const imagenes = ["Piso1.png", "Piso2.png", "Piso3.png"]
    var imagen = ""
    method image() = imagen

    method imagenAleatoria(){
        imagen = imagenes.anyOne()
    }

    method ponerImagen(){
        self.imagenAleatoria()
        game.addVisual(self)
    }

    method esPisable() = true

    method esMeta() = false

    method interactuarConPersonaje(pj){}
}

class Pared {
    const property position
    
    const imagenes = ["Muro1.png", "Muro2.png", "Muro3.png", "Muro4.png"]
    var imagen = ""
    method image() = imagen

    method imagenAleatoria(){
        imagen = imagenes.anyOne()
    }

    method ponerImagen(){
        self.imagenAleatoria()
        game.addVisual(self)
    }

    method esPisable() = false

    method esMeta() = false

    method interactuarConPersonaje(pj){
        throw new Exception(message = "El personaje no puede pasar a través de paredes.")
    }
}

class Meta {
    var property position

    const sonidoGanador = game.sound("Victoria.mp3")
    const imagenDeMeta = "Meta_V2.png"
    const imagenesDeMetaConJugador = gestorDeJugadores.imagenesDeMeta()

    var imagen = imagenDeMeta

    method image() = imagen

    method ponerImagen(){
        game.addVisual(self)
    }

    method esPisable() = true

    method esMeta() = true

    method interactuarConPersonaje(pj) {
        juegoLevelDevil.detenerMovimientos()
        game.removeVisual(gestorDeJugadores.jugadorActual())
        sonidoGanador.volume(1)
        sonidoGanador.play()
        imagen = imagenesDeMetaConJugador.get(0)
        game.schedule(650, {
            imagen = imagenesDeMetaConJugador.get(1)
            game.schedule(650, {
                imagen = imagenesDeMetaConJugador.get(2)
                game.schedule(500, {
                    juegoLevelDevil.siguienteNivel()
                    game.schedule(200, {})
                })
            })
        })
    }
}

class Moneda {
    var property position

    const sonidoMoneda = game.sound("Moneda.mp3")
    method image() = "Moneda_V2.png"

    method ponerImagen(){
        game.addVisual(self)
    }

    method esPisable() = true

    method esMeta() = false

    method interactuarConPersonaje(pj) {
        sonidoMoneda.volume(1)
        sonidoMoneda.play()
        pj.sumaDePuntajeTemporalGanado(100)
        game.removeVisual(self)
    }
}

class ObjetoMortal {
    var property position

    method restaDePuntajeAlMorir() = 50
    
    method image()

    method ponerImagen(){
        game.addVisual(self)
    }

    method ataque()

    method esPisable() = true

    method esMeta() = false

    method interactuarConPersonaje(pj) {
        if(pj.potencialDefensivo() < self.ataque()) {
            const sonidoMuerte = game.sound("Muerte.mp3")
            sonidoMuerte.volume(1)
            sonidoMuerte.play()
            pj.restaDePuntajeTemporalPerdido(self.restaDePuntajeAlMorir())
            pj.morir()
        }
    }
}

class MonedaFalsa inherits ObjetoMortal {
    override method restaDePuntajeAlMorir() = 100

    override method ataque() = 500

    override method image() = "Moneda_V2.png"

    override method interactuarConPersonaje(pj) {
        game.removeVisual(self)
        super(pj)
    }
}

class Pincho inherits ObjetoMortal {
    override method ataque() = 180
    
    override method image() = "PinchoSimple_V1.png"
}

class PinchoInvisibleInstantaneo inherits ObjetoMortal {
    override method ataque() = 400

    var visible = false // comienza invisible

    // La imagen depende de la propiedad 'visible'
    override method image() {
        if (visible) {
            return "PinchoSimple_V1.png"
        } else {
            return null
        }
    }

    override method interactuarConPersonaje(pj) {
        visible = true
        super(pj)
    }
}

class PinchoInvisible inherits ObjetoMortal {
    override method ataque() = 150

    // Genero un id por instancia para no pisar otros onTick
    const tickId = "mostrarPincho_" + self.identity()

    var visible = false // comienza invisible

    // La imagen depende de la propiedad 'visible'
    override method image() {
        if (visible) {
            return "PinchoSimple_V1.png"
        } else {
            return null
        }
    }

    method hacerVisible() {
        game.onTick(100, tickId, {
            const positionX = (gestorDeJugadores.position().x() - self.position().x()).abs()
            const positionY = (gestorDeJugadores.position().y() - self.position().y()).abs()

            // Si el jugador está cerca, marcamos visible el pincho
            if (positionX <= 1 and positionY <= 1) {
                visible = true
            }
        })
    }
}

class PinchoMovil inherits ObjetoMortal {
    override method ataque() = 250

    const tickId = "moverPinchoMovil_" + self.identity()

    override method image() = "PinchoTriple_V1.png"

    method moverseAleatoriamente() {
        const direcciones = [arriba, abajo, izquierda, derecha]
        const direccionAleatoria = direcciones.anyOne()
        const destino = direccionAleatoria.moverEnDireccion(position)
        const objetosEnDestino = game.getObjectsIn(destino)

        const esMetaEnDestino = objetosEnDestino.any({obj => obj.esMeta()})
        const validarPosition = direccionAleatoria.validarPosition(destino)

        // Mover sólo si está dentro de límites, hay objetos, todos son pisables y NO hay una Meta
        if (!esMetaEnDestino and validarPosition) {
            position = destino
        }
    }

    method moverPinchoMovil() {
        // el pincho cada se mueve cada 0,3 seg
        game.onTick(300, tickId, {
            self.moverseAleatoriamente()
        })
    }
    
    method detenerMovimiento() {
        game.removeTickEvent(tickId)
    }
}