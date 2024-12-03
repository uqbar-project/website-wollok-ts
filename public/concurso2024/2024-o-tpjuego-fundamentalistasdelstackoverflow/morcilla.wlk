import wollok.game.*
import general.*
import entorno.*
import jefe.*
import interfaz.*

object morcilla inherits Personaje{
    var property position = self.posicionInicial()
    const vidaInicial = 5

    // ================================== MOVIMIENTO ================================== 
    var saltando = false
    var suspendido = false
    var caerActivo = false
    var movimientoActivo = true
    
    const framesSalto = ["morcilla1.png", "morcilla2.png", "morcilla3.png", "morcilla4.png", "morcilla5.png", "morcilla6.png"]
    var frameSaltoActual = 0

    method posicionInicial() = new PositionMejorada(x=15, y=2)

    method saltando() = saltando
    method suspendido() = suspendido

    method image() {
        
        var imagen = ""
        if(inmunidadActiva)
            imagen = "INV"

        if(derrotado)
            return "261.jpg"
        else if(suspendido)
                return imagen+framesSalto.get(frameSaltoActual)
        else
        {
            if(position.x()%2 == 0)
                return imagen+"morcilla0.png"
            else
                return imagen+"morcilla1.png"
        }
    }

    method caminar(pasos) {
        if(movimientoActivo)
            position.horizontalMejorado(pasos, 1, 29)

        sonidoVacio.play()

        self.caer()
    }

    method saltar(duracion) {
        if (!suspendido && movimientoActivo) {
        saltando = true
        suspendido = true
        const tiempo = duracion / 5

        game.schedule(tiempo * 0, { position.goUp(1) })
        game.schedule(tiempo * 1, { position.goUp(1) })
        game.schedule(tiempo * 2, { position.goUp(1) })
        game.schedule(tiempo * 3, { position.goUp(1) })
        game.schedule(tiempo * 4, { position.goUp(1) })

        game.schedule(tiempo * 1.5, { frameSaltoActual = 1 })
        game.schedule(tiempo * 3, { frameSaltoActual = 2 })
        game.schedule(tiempo * 4.5, { frameSaltoActual = 3 })
        game.schedule(tiempo * 6, { frameSaltoActual = 4 })
        game.schedule(tiempo * 7.5, { frameSaltoActual = 5 })

        game.schedule(tiempo * 5, { saltando = false })
        game.schedule(tiempo * 5, { self.caer() })
        }
    }
    
    method gravedad() {
        if (position.y() > 2 && !saltando) { 
        // Está cayendo o saltando
        position.goDown(1)
        suspendido = true
        }
        else if (!saltando) { 
        // Ya cayó
        game.removeTickEvent("gravedad")
        suspendido = false
        caerActivo = false
        frameSaltoActual = 0
        }
    }

    method caer() {
        if(!caerActivo && suspendido){
        game.onTick(100, "gravedad", {self.gravedad()})
        caerActivo = true
        }
    }

    // ================================== BATALLA ================================== 

    var property vidas = vidaInicial
    var inmunidadActiva = false
    var property puedeAtacar = false
    var derrotado = false
    var enBatalla = false

    method vidaInicial() = vidaInicial

    method enBatalla(estado){
        enBatalla = estado
    }

    const hitbox = [hitboxMorcilla0, hitboxMorcilla1, hitboxMorcilla2, hitboxMorcilla3]
    
    method crearHitbox() {
        hitbox.forEach({hitbox => hitbox.inicializar()})
    }

    method tocaMorcilla() {}

    method iniciarPeleaMorcilla(jefe, espera){
        if(!enBatalla) {
            self.desactivarMovimiento()
            
            game.schedule(espera, jefe.nuevaPelea())
        }
    }

    method perderVida() {
        if (!inmunidadActiva){
            vidas = (vidas-1).max(0)

            ladridosGolpe.play()

            administradorVidas.actualizarVida(vidas)

            self.obtenerInmunidad(1000)

            if(vidas < 1)
                self.derrota()
        }
    }

    method obtenerInmunidad(duracion) {
        inmunidadActiva = true
        game.schedule(duracion, {inmunidadActiva = false})
    }

    method derrota() {
        derrotado = true
        self.desactivarMovimiento()

        cinematicaDerrota.empezar()

        game.schedule(cinematicaDerrota.duracion()+200, {entorno.reiniciarJuego()})
    }

    method derrotado() = derrotado

    method atacar() {
        cinematicaAtaque.empezar()
        ladridos.play()
        position = self.posicionInicial()
    }

    method posicionDeAtaque() {
        self.desactivarMovimiento()
        //position = new PositionMejorada (x=15, y=2)
    }

    method desactivarMovimiento() {
        movimientoActivo = false
    }

    method activarMovimiento() {
        movimientoActivo = true
    }

    method estadoInicial() {
        position = self.posicionInicial()
        
        saltando = false
        suspendido = false
        caerActivo = false
        movimientoActivo = true
        
        vidas = vidaInicial
        inmunidadActiva = false
        puedeAtacar = false
        derrotado = false
        enBatalla = false

        administradorVidas.actualizarVida(vidas)
    }

    method ladrar() {
        ladridos.play()
    }

    override method mostrar() {
        if(!game.hasVisual(self)){
            game.addVisual(self)
            hitbox.forEach({box => game.addVisual(box)})
        }
    }
}

class VidaMorcilla {
    var property image = "vidaDoradaLlena.png" 
    var property position
    const id

    method id() = id

    method perderVida() {
        image = "vidaDoradaVacia.png"
    }

    method tenerVida() {
        image = "vidaDoradaLlena.png"
    }
}

object administradorVidas {
    const vidaMaximaMorcilla = morcilla.vidas()

    const vida1 = new VidaMorcilla(position = new PositionMejorada(x = 2, y = 28), id = 1)
    const vida2 = new VidaMorcilla(position = new PositionMejorada(x = 5, y = 28), id = 2)
    const vida3 = new VidaMorcilla(position = new PositionMejorada(x = 8, y = 28), id = 3)
    const vida4 = new VidaMorcilla(position = new PositionMejorada(x = 11, y = 28), id = 4)
    const vida5 = new VidaMorcilla(position = new PositionMejorada(x = 14, y = 28), id = 5)

    const vidas = [vida1, vida2, vida3, vida4, vida5]

    method mostrarVidas() {
        vidas.forEach({sprite => if(sprite.id() <= vidaMaximaMorcilla){game.addVisual(sprite)}})
    }

    method actualizarVida(vidaActual) {
        vidas.forEach({sprite => if(sprite.id() > vidaActual){sprite.perderVida()}else{sprite.tenerVida()}})
    }
}

class Hitbox {
    const desvioY
    const desvioX
    
    method image() = "vacio.png"

    method position() = new PositionMejorada(x = morcilla.position().x() + desvioX, y = morcilla.position().y() + desvioY)

    method inicializar() {
        game.whenCollideDo(self, {elemento => elemento.tocaMorcilla()})
    }
}

const hitboxMorcilla0 = new Hitbox(desvioX = 0, desvioY = 0) 
const hitboxMorcilla1 = new Hitbox(desvioX = 0, desvioY = 1) 
const hitboxMorcilla2 = new Hitbox(desvioX = 1, desvioY = 0) 
const hitboxMorcilla3 = new Hitbox(desvioX = 1, desvioY = 1)
