import menus.*
import config.*
import visuales.*
import movimientos.*
import wollok.game.*
import niveles.*

class Proyectil inherits Visual (position = direccionDisparo.siguiente(personaje.position())) {
    var property personaje
    var property direccionDisparo
    method serLanzado() { game.addVisual(self) }
    method moverseRecto() {
        if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) { self.position(direccionDisparo.siguiente(self.position())) }
    }
    method estaFuera() = 
        position.x() > game.width() or
        position.x() < 0 or
        position.y() > game.height() or
        position.y() < 0
    method hayColumna(pos) = juegoPorNiveles.nivelActual().columnas().any({c => c.position() == pos})
}

class ID { // es uno por enemigo para evitar lag
    var ultimoId = 0
    method nuevoId(unID) = unID + ultimoId.toString()
    method actualizarUltimoID() { ultimoId = ultimoId + 1 }
}

const idMago = new ID()

class ProyectilMago inherits Proyectil (personaje = mago) {
    var property tickId
    const property enemigo
    override method serLanzado() {
        super()
        game.onCollideDo(self, { enemigo =>
            if (enemigo.tieneVidas()) {enemigo.perderVida() }
            game.removeVisual(self)
        })
        game.onTick(250, tickId, {self.moverseRecto()})
    }
    override method moverseRecto() {
        super()
        if ( self.estaFuera()) { 
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        }
    }
    method initialize() {
        tickId = idMago.nuevoId("proyectilMago")
        direccionDisparo = personaje.direccion()
        image = "proyectilMago.gif"
    }
}

const idGusano = new ID()

class ProyectilGusano inherits Proyectil (personaje = gusano) {
    var property tickId
    override method serLanzado() {
        super()
        game.onCollideDo(self, { mago =>
            if (mago.tieneVidas()) { mago.perderVida() }
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        })
        game.onTick(250, tickId, {self.moverseRecto()})
    }
    override method moverseRecto() {
        super()
        if (self.estaFuera()) { 
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        }
    }
    method initialize() {
        tickId = idGusano.nuevoId("proyectilGusano")
        image = "proyectilGusano.gif"
        direccionDisparo = arriba
    }
}

const idCaracol = new ID()

class ProyectilCaracol inherits Proyectil (personaje = caracol) {
    var property tickId
    override method serLanzado() {
        super()
        game.onCollideDo(self, { mago =>
            if (mago.tieneVidas()) {mago.perderVida()}
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        })
        game.onTick(200, tickId, {self.moverseRecto()})
    }
    override method moverseRecto() {
        super()
        if (self.estaFuera()) { 
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        }
    }
    method initialize() {
        tickId = idCaracol.nuevoId("proyectilCaracol")
        image = "proyectilCaracol.gif"
        direccionDisparo = caracol.direccion().siguienteCiclo()
    }
}

const idDemonio = new ID()

class ProyectilDemonio inherits Proyectil (personaje = demonio) {
    var property tickId
    override method serLanzado() {
        super()
        game.onCollideDo(self, { mago =>
            if (mago.tieneVidas()) {mago.perderVida() }
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        })
        game.onTick(150, tickId, {self.moverseRecto()})
    }
    override method moverseRecto() {
        super()
        if (self.estaFuera()) { 
            game.removeVisual(self)
            game.removeTickEvent(tickId)
        }
    }
    method initialize() {
        tickId = idDemonio.nuevoId("proyectilDemonio")
        image = "proyectilDemonio.gif"
        direccionDisparo = demonio.direccion().siguienteCiclo()
    }
}