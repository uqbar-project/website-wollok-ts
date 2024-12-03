import wollok.game.*
import juego.*
import posiciones.*
import managers.*

class Proyectil {

    var property danio
    var property image
    var property position
    const velocidadViaje

    method mover(direccion) {
	    position = direccion.siguientePosicion(position)
	}

    method nombreEvento() {
        return "evento" + self.identity()
    }

    method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.mover(direccion)
    }

    method sigueOHayZombie(direccion) {
        const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)}) // reotcasr
        return (not(zombiesHacia.isEmpty()))
    }

    method sigueOEsta(direccion, zombie) {
        return zombie.position() == direccion.siguientePosicion(position) or zombie.position() == position
    }

    method impacto(dir) {
        game.removeTickEvent(self.nombreEvento())
        game.schedule(100,{game.removeVisual(self)})
    }

    method validarViajeProyectil(direccion) {
        if (self.sigueOHayZombie(direccion)) {
            const zombiesHacia = managerZombie.zombies().filter({zombie => self.sigueOEsta(direccion, zombie)})
            zombiesHacia.forEach({zombie => zombie.herir(danio)})
            self.impacto(direccion)
        }
        else if (not(tablero.estaDentro(direccion.siguientePosicion(position)))) {
            self.impacto(direccion)
        }
    }

    method nuevoViaje(dir) { 
        game.onTick(velocidadViaje, self.nombreEvento() , {self.disparoHacia(dir)})
    }

}


class Bala inherits Proyectil(danio=25, velocidadViaje=120) {

    override method impacto(dir) {
        self.image("balaP-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}


class BalaEscopeta inherits Proyectil(danio= 75,velocidadViaje=180) {

    override method impacto(dir) {
        self.image("balaEscopetaPrueba-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}

class BalaEscopetaMejorada inherits BalaEscopeta(danio=100) {
    
}

class BolaDeFuego inherits Proyectil(danio=40, velocidadViaje=220) {

    override method impacto(dir) {
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}

class BolaPlasma inherits Proyectil(danio = 80, velocidadViaje=260) {
    
    override method impacto(dir) {
        self.image("plasma-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}

class Calavera inherits Proyectil(danio = 100, velocidadViaje=180) {

    override method impacto(dir) {
        self.image("calavera-impacto-" + dir.toString() + ".png")
        super(dir)
    }
}


class Crater {
    var property image = "tanqueimpacto.png"
    const property position

    method daniar(dmg) {
        const colisiones = managerZombie.zombies().filter({z => z.position() == position})
        if (juego.jugador().position() == position) {
            colisiones.add(juego.jugador())
        }
        colisiones.forEach({c => c.herir(dmg)})
        game.schedule(2000,{game.removeVisual(self)})
    }

}

class BolaEnergia inherits Proyectil(danio = 100, image="rayoGrande.png",velocidadViaje=150) {

    override method disparoHacia(direccion) {
        self.validarViajeProyectil(direccion)
        self.avanzarEspecial(direccion)
    }

    method avanzarEspecial(direccion) {
        game.schedule(80,{self.mover(direccion)})
    }

    override method impacto(dir) {
        // cambiar por un impacto de rayo
        self.image("bola-impacto-" + dir.toString() + ".png")
        super(dir)
    } 
}


class Baston inherits Proyectil(danio = 160, velocidadViaje=170) {
}


