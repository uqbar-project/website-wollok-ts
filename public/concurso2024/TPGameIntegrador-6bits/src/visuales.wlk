import menus.*
import config.*
import niveles.*
import corazones.*
import movimientos.*
import proyectiles.*
import wollok.game.*

class Visual {
    var property image
    var property position
    method tieneVidas() = false
}

class Personaje inherits Visual {
    var property vidas
    var property direccion
    method morir()
    method atacar()
    method resetearPosicion()
    method mostrarCorazones()
    method puedeMoverseA(pos) = 
        pos.x() > 3 &&
        pos.y() > 3 &&
        pos.x() < 15 &&
        pos.y() < 16 &&
        !juegoPorNiveles.nivelActual().enemigoVivoEn(self.position()) &&
        !self.columnaBloquea(pos)
    method perderVida() { vidas = (vidas - 1).max(0) }
    method mirarA(unaDireccion) { direccion = unaDireccion }
    method moverA(unaDireccion) {
        if(!menuPausa.abierto()) {
            self.mirarA(unaDireccion)
            if (self.puedeMoverseA(unaDireccion.siguiente(self.position()))) {
                self.position(unaDireccion.siguiente(self.position()))
                if (juegoPorNiveles.nivelActual().pincho().estaALaIzquierda(self.position())) 
                { self.perderVida() }
            else { direccion = unaDireccion }
            }
        }
    }
    method columnaBloquea(pos) = juegoPorNiveles.nivelActual().columnas().any({ c => c.bloqueaAlMago(pos) })
    method resetear() { 
        self.resetearPosicion() 
        direccion = izquierda
    }
    method resetearVidas() { vidas = 3 }
    method estaMuerto() = vidas == 0
    method mostrarDaño()
    override method tieneVidas() = vidas > 0
}


object mago inherits Personaje (direccion = abajo) {
    const property corazones = [corazonM1, corazonM2, corazonM3]
    const property corazonesVacios = [corazonVacioM1, corazonVacioM2, corazonVacioM3]
    var property enemigo = juegoPorNiveles.nivelActual().enemigo()
    method posicionDeAtaque() = direccion.siguiente(self.position())
    method configuracionTeclado() {
        if (!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            keyboard.w().onPressDo({self.moverA(arriba)})
            keyboard.s().onPressDo({self.moverA(abajo)})
            keyboard.d().onPressDo({self.moverA(derecha)})
            keyboard.a().onPressDo({self.moverA(izquierda)})
            keyboard.f().onPressDo({self.atacar()})
        }
    }
    override method mirarA(unaDireccion) {
        super(unaDireccion)
        image = direccion.imageMago()  
    }
    override method resetearPosicion() { position = game.at(4,14) }
    override method resetearVidas() { 
        super()
        self.mostrarCorazones()
    }
    override method atacar() {
        if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            const proyectil = new ProyectilMago(enemigo = self.enemigo())
            idMago.actualizarUltimoID()
            image = direccion.imageAtaque()
            proyectil.serLanzado()
        }
    }
    override method morir() { 
        self.resetearVidas()
        juegoPorNiveles.nivelActual().musica().stop()
        menuPerdedor.abrir()  
    }
    override method perderVida() {
        super()
        self.mostrarCorazones()
        self.mostrarDaño()
        if (self.estaMuerto()) { self.morir() }
        game.sound("heartDown.wav").play()
    }
    override method mostrarCorazones() {
        (corazones + corazonesVacios).forEach({c => game.removeVisual(c)})
        (0..2).forEach({i =>
        if (i < vidas) game.addVisual(corazones.get(i))
        else game.addVisual(corazonesVacios.get(i))})
    }
    override method mostrarDaño() {
        image = direccion.imageMagoDaño()
        game.schedule(300, { image = direccion.imageMago() })
    }
    override method resetear() {
        self.resetearPosicion() 
        direccion = abajo
        image = direccion.imageMago()
    }
    method initialize() {
        image = direccion.imageMago()
        position = game.at(4,14)
        vidas = 3
    }
}

class Enemigo inherits Personaje {
    method comboEnemigo()
    method moverseEnemigo()
    method invertirDireccion()
}

object gusano inherits Enemigo (direccion = izquierda) {
    const property corazones = [corazonG1, corazonG2, corazonG3]
    const property corazonesVacios = [corazonVacioG1, corazonVacioG2, corazonVacioG3]
    override method comboEnemigo() { 
        game.onTick(750, "movimientoGusano", { self.moverseEnemigo() }) 
        game.onTick(1500, "ataqueGusano", { self.atacar() })
    }
    override method moverseEnemigo() {
        const siguiente = direccion.siguiente(position)
        self.mirarA(direccion)
        if (!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            if (self.puedeMoverseA(siguiente)) { self.position(siguiente) }
            else {
                self.invertirDireccion()
                self.position(direccion.siguiente(position))
            }
        }
    }
    override method invertirDireccion() { direccion = direccion.contrario() }
    override method puedeMoverseA(pos) =
        pos.x() >= 4 &&
        pos.y() == 2 &&
        pos.x() <= 15 
    override method mirarA(unaDireccion) {
        super(unaDireccion)
        image = unaDireccion.imageGusano()
    }
    override method atacar() {
        if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            const proyectil = new ProyectilGusano()
            idGusano.actualizarUltimoID()
            proyectil.serLanzado()
        }
    }
    override method resetearPosicion() { position = game.at(8, 2) }
    override method resetearVidas() { 
        super()
        self.mostrarCorazones()
    }
    override method perderVida() {
        super()
        self.mostrarCorazones()
        self.mostrarDaño()
        if (self.estaMuerto()) { self.morir() }
        game.sound("enemieHurt.wav").play()
    }
    override method mostrarCorazones() {
        (corazones + corazonesVacios).forEach({c => game.removeVisual(c)})
        (0..2).forEach({i =>
        if (i < vidas) game.addVisual(corazones.get(i))
        else game.addVisual(corazonesVacios.get(i))})
    }
    override method morir() { 
        game.sound("enemieDie.wav").play()
        juegoPorNiveles.pasarASiguienteNivel() 
    }
    override method mostrarDaño() {
        image = direccion.imageGusanoDaño()
        game.schedule(300, { image = direccion.imageGusano() })
    }
    override method resetear() {
        super()
        image = direccion.imageGusano()
    }
    method initialize() {
        image = direccion.imageGusano()
        position = game.at(8, 2)
        vidas = 3
    }
}

object caracol inherits Enemigo (direccion = izquierda) {
    const property corazones = [corazonC1, corazonC2, corazonC3, corazonC4]
    const property corazonesVacios = [corazonVacioC1, corazonVacioC2, corazonVacioC3, corazonVacioC4]
    override method comboEnemigo() { 
        game.onTick(650, "movimientoCaracol", { self.moverseEnemigo() }) 
        game.onTick(1250, "ataqueCaracol", { self.atacar() })
    }
    override method moverseEnemigo() {
        if (!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            if (self.puedeMoverseA(direccion.siguiente(position))) { 
                self.mirarA(direccion)
                self.position(direccion.siguiente(position)) 
            } 
            else { 
                self.invertirDireccion()
                if (self.puedeMoverseA(direccion.siguiente(position))) {
                    self.position(direccion.siguiente(position))
                }
            }
        }
    }
    override method invertirDireccion() { direccion = direccion.siguienteCiclo() }
    override method puedeMoverseA(pos) =
        pos.x() >= 1 &&
        pos.y() >= 2 &&
        pos.x() <= 17 &&
        pos.y() <= 17
    override method mirarA(unaDireccion) {
        super(unaDireccion)
        image = unaDireccion.imageCaracol()
    }
    override method atacar() {
        if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            if (!self.estaEnEsquina()) { 
                const proyectil = new ProyectilCaracol()
                idCaracol.actualizarUltimoID()
                proyectil.serLanzado()
            } else { self.invertirDireccion() }
        }
    }
    method estaEnEsquina() =
        (position.x() == 1  && position.y() == 2)  ||
        (position.x() == 17 && position.y() == 2)  ||
        (position.x() == 17 && position.y() == 17) ||
        (position.x() == 1  && position.y() == 17)
    override method resetearPosicion() { position = game.at(8, 2) }
    override method resetearVidas() { 
        vidas = 4
        self.mostrarCorazones()
    }
    override method perderVida() {
        super()
        self.mostrarCorazones()
        self.mostrarDaño()
        if (self.estaMuerto()) { self.morir() }
        game.sound("enemieHurt.wav").play()
    }
    override method mostrarCorazones() {
        (corazones + corazonesVacios).forEach({c => game.removeVisual(c)})
        (0..3).forEach({i =>
        if (i < vidas) game.addVisual(corazones.get(i))
        else game.addVisual(corazonesVacios.get(i))})
    }
    override method morir() { 
        game.sound("enemieDie.wav").play()
        juegoPorNiveles.pasarASiguienteNivel() 
    }
    override method mostrarDaño() {
        image = direccion.imageCaracolDaño()
        game.schedule(300, { image = direccion.imageCaracol() })
    }
    override method resetear() {
        super()
        image = direccion.imageCaracol()
    }
    method initialize() {
        image = direccion.imageCaracol()
        position = game.at(8, 2)
        vidas = 4
    }
}

object demonio inherits Enemigo (direccion = izquierda) {
    const property corazones = [corazonD1, corazonD2, corazonD3, corazonD4, corazonD5]
    const property corazonesVacios = [corazonVacioD1, corazonVacioD2, corazonVacioD3, corazonVacioD4, corazonVacioD5]
    override method comboEnemigo() { 
        game.onTick(500, "movimientoDemonio", { self.moverseEnemigo() }) 
        game.onTick(1100, "ataqueDemonio", { self.atacar() })
    }
    override method moverseEnemigo() {
        if (!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            if (self.puedeMoverseA(direccion.siguiente(position))) { 
                self.mirarA(direccion)
                self.position(direccion.siguiente(position)) 
            } 
            else { 
                self.invertirDireccion()
                if (self.puedeMoverseA(direccion.siguiente(position))) {
                    self.position(direccion.siguiente(position))
                }
            }
        }
    }
    override method invertirDireccion() { direccion = direccion.siguienteCiclo() }
    override method puedeMoverseA(pos) =
        pos.x() >= 1 &&
        pos.y() >= 2 &&
        pos.x() <= 17 &&
        pos.y() <= 17
    override method mirarA(unaDireccion) {
        super(unaDireccion)
        image = unaDireccion.imageDemonio()
    }
    override method atacar() {
        if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
            if (!self.estaEnEsquina()) { 
                const proyectil = new ProyectilDemonio()
                idDemonio.actualizarUltimoID()
                proyectil.serLanzado()
            } else { self.invertirDireccion() }
        }
    }
    method estaEnEsquina() =
        (position.x() == 1  && position.y() == 2)  ||
        (position.x() == 17 && position.y() == 2)  ||
        (position.x() == 17 && position.y() == 17) ||
        (position.x() == 1  && position.y() == 17)
    override method resetearPosicion() { position = game.at(8, 2) }
    override method resetearVidas() { 
        vidas = 5
        self.mostrarCorazones()
    }
    override method morir() { 
        game.sound("enemieDie.wav").play()
        juegoPorNiveles.pasarASiguienteNivel() 
    }
    override method perderVida() {
        super()
        self.mostrarCorazones()
        self.mostrarDaño()
        if (self.estaMuerto()) { self.morir() }
        game.sound("enemieHurt.wav").play()
    }
    override method mostrarCorazones() {
        (corazones + corazonesVacios).forEach({c => game.removeVisual(c)})
        (0..4).forEach({i =>
        if (i < vidas) game.addVisual(corazones.get(i))
        else game.addVisual(corazonesVacios.get(i))})
    }
    override method mostrarDaño() {
        image = direccion.imageDemonioDaño()
        game.schedule(300, { image = direccion.imageDemonio() })
    }
    override method resetear() {
        super()
        image = direccion.imageDemonio()
    }
    method initialize() {
        image = direccion.imageDemonio()
        position = game.at(8, 2)
        vidas = 5
    }
}

class Pincho inherits Visual (position = game.center()) {
  var property segundos 
  var property tickId
  method movete() {
    if(!menuPausa.abierto() and !juegoPorNiveles.nivelActual().pantalla().abierto()) {
        game.removeVisual(self)
        const x = 5.randomUpTo(15).truncate(0)
        const y = 5.randomUpTo(15).truncate(0)
        position = game.at(x,y)
        if (!self.posicionBloqueada(position)) { 
            game.addVisual(self)
            if (self.estaALaIzquierda(mago.position())) { mago.perderVida() }
        }
    } 
  }
  method ponerse() {
    game.onCollideDo(self, { mago => if (mago.tieneVidas()) { mago.perderVida() }})
    game.onTick(5000, tickId, { self.movete() })
  }
  method aparece() {
    game.addVisual(self)
    self.ponerse()
    if (self.estaALaIzquierda(mago.position())) { mago.perderVida() }
  }
  method posicionBloqueada(pos) =  juegoPorNiveles.nivelActual().columnas().any{ c => c.bloqueaPincho(pos, c.position(), 3) }
  method estaALaIzquierda(posMago) =
    posMago.x() == position.x() - 1 &&
    posMago.y() == position.y()
  method initialize() {
    tickId = idPincho.nuevoId("movPincho")
    image = "spikes.gif"
  }
}

const idPincho = new ID()