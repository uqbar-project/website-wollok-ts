import wollok.game.*
import juego.*
import posiciones.*
import sonidos.*
import nivelManager.*
import managers.*


class Zombie {
    var property image
    var property position
    var property vida
    const property dmg
    var contadorMovimiento = 1
    const velocidad

    method sonidoHerida()
    method sonidoMuerte()
    method imagenMovimiento()

    method agro() {
        return juego.jugador()
    }

    method herir(danio) {
        vida = 0.max(vida - danio)
        self.fijarseMuerte()
    }
    
    method fijarseMuerte() {
        if (vida == 0) {
           self.morir() 
        }
        else {
            self.sonidoHerida()
        }
    }

    method atacarAgro() {
        self.imagenHacia(self.dirAgroPegado())
        self.agro().herir(dmg)
    }

    // Persecucion -------------------------------------

    method perseguirAJugador() {
        if (self.agroEstaPegado()) {
            self.atacarAgro()
        }
        else if (contadorMovimiento == velocidad) {
            self.imagenHacia(self.dirDeTransicionA(self.sigPosFavorable()))
            position = self.sigPosFavorable()
            contadorMovimiento = 1
        }
        else {contadorMovimiento += 1}
    }

    method agroEstaPegado() {
        return self.position().distance(self.agro().position()) == 1
    }

    method dirDeTransicionA(pos) {
        if (pos.x() > position.x()) {
            return derecha
        }
        else if (pos.x() < position.x()) {
            return izquierda
        }
        else if (pos.y() > position.y()) {
            return arriba
        }
        else {
            return abajo
        }
    }

    method sigPosFavorable() {
        const disponibles = tablero.verticalesDe(position).filter({pos => not(managerZombie.posTieneZombie(pos))})
        const dispYSinCajas = disponibles.filter({pos => not(nivelManager.hayCajaEn(pos))})
        if (!dispYSinCajas.isEmpty()) {
            return dispYSinCajas.min({pos => pos.distance(self.agro().position())})
        }
        else {
            self.error("")
        }
    }

    method dirAgroPegado() {
        if (self.distanciaY() == 0 and self.distanciaX() < 0) {
            return izquierda
        }
        else if (self.distanciaY() == 0 and self.distanciaX() > 0) {
            return derecha
        }
        else if (self.distanciaX() == 0 and self.distanciaY() < 0) {
            return abajo
        }
        else {
            return arriba
        }
    }

    method distanciaX() {
        return (self.agro().position().x() - position.x())
    }

    method distanciaY() {
        return (self.agro().position().y() - position.y())
    }

    // Movimiento -------------------------------------

    method imagenHacia(dir) {
        image = self.imagenMovimiento() + dir.toString() + ".png"
    }

    method morir() {
        self.sonidoMuerte()
        game.removeVisual(self)
        managerZombie.quitarZ(self)
        managerItems.generarDrop(position)
    }
}

class ZombieComun inherits Zombie(vida = 100, dmg = 10, image = "zombieComun-abajo.png", velocidad=2){ 

    override method sonidoHerida(){
        game.sound("zombie-herido.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("zombie-muerto.mp3").play()
    }

    override method imagenMovimiento() {
        return "zombieComun-"
    }
}

class ZombiePerro inherits Zombie(vida = 75, dmg = 20, image = "perronio-abajo.png",velocidad=1){

    override method sonidoHerida(){
        game.sound("perro-heridoNuevo.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("perro-muerto.mp3").play()
    }

    override method imagenMovimiento() {
        return "perronio-"
    }
}

class ZombieTanque inherits Zombie(vida = 150, dmg = 80, image = "tanque-1-abajo.png", velocidad=3) {
    
    var estado = 1
    var ultimaDir = abajo

    override method herir(danio) {
        super(danio * 0.75)             // recibe un 25% menos de daño (Por tener "armadura")
    }

    override method atacarAgro() {
        ultimaDir = self.dirAgroPegado()
        managerZombie.zombies().remove(self)
        self.animacionAtaque() 
        game.schedule(1250,{managerCrater.explosionEnCon(position,dmg)}) 
        game.schedule(1500,{managerZombie.agregarZ(self)})
    }

    method animacionAtaque() {
        estado = 2
        self.imagenHacia(ultimaDir)
        game.schedule(600,{estado += 1})
        game.schedule(650,{self.imagenHacia(ultimaDir)})
        game.schedule(1200,{estado += 1})
        game.schedule(1200,{self.imagenHacia(ultimaDir)})
        game.schedule(1250,{estado = 1})
        game.schedule(1450,{self.imagenHacia(ultimaDir)})
    }

    override method morir() {
        self.explotar()
        super()
    }

    method explotar() {
        managerCrater.explosionEnCon(position, dmg)
    }

    // sonido -----------------------------------------
    
    override method sonidoHerida(){
        game.sound("tank-herido.mp3").play()
    }

    override method sonidoMuerte(){
        game.sound("tank-muerte.mp3").play() 
    }

    // imagen -----------------------------------------

    override method imagenMovimiento() {
        return "tanque-" + estado.toString() + "-"
    }
}
