import wollok.game.*
import direcciones.*
import hechizos.*
import pantallas.*
import juego.*

class Personaje {
        var property image
        var property position = self.posicionAleatoria()
        var vida = 5
        const vidaInicial = 5

        method poder()

        method imagenDePoder() = self.poder()

        method vida() = vida

        method estaVivo() = vida > 0

        method restaurar() { vida = vidaInicial }

        method sacarVida(cantidad) {
                vida = (vida - cantidad).max(0)
        }

        method recibirAtaque(hechizo) {
                // comportamiento por defecto: no hace nada
        }

        method posicionAleatoria() {
            const x = 2.randomUpTo(limiteMaximo)
            const y = 2.randomUpTo(limiteMaximo)
            return game.at(x, y)
        }
}

class Jugador inherits Personaje {
    const nombre
    var direccionActual = este

    override method imagenDePoder() = self.poder() + self.ultimaDireccion().nombre() + ".png"

    method alternarImagen(unaDireccion) {
        image = nombre + unaDireccion.nombre() + ".png"
    }

    override method restaurar() { vida = vidaInicial }

    method moverseHacia(direccion) {
        self.alternarImagen(direccion)
        direccion.mover(self)
        direccionActual = direccion
    }

    method ultimaDireccion() = direccionActual

    method darVida() { vida = vidaInicial }

    override method sacarVida(cantidad) {
        super(cantidad)
        pantallas.barraDeVida().actualizarse(self)
        if(!self.estaVivo()) {
            charcoDeSangre.dejarCharcoDeSangre(self.position())
            game.schedule(3000, {juego.gameOver()})
        }
    }

    override method recibirAtaque(hechizo) {
        if (vida > 0 && hechizo.esMalvado()) {
            self.sacarVida(hechizo.danio())
            hechizo.destruir()
        }
    }

    override method posicionAleatoria() {
            return game.center()
        }
}

class Guerrero inherits Jugador { 
        override method poder() = "lanza"
}

class Arquero inherits Jugador {
        override method poder() = "flecha"
}

class Barbaro inherits Jugador {
         override method poder() = "hacha"
}

class Mago inherits Jugador {
        override method poder() = "bolaDeFuego"
}

class Enemigo inherits Personaje {
    var pasosRestantes = 0
    var ultimaDireccion = sur
    var direccionActual = sur

    const poder = ""

    override method poder() = poder 

    override method imagenDePoder() = self.poder()

    method mostrarDanio() {}

    method ultimaDireccion() = ultimaDireccion

    method moverAleatoriamente() { 
        pasosRestantes = 2.randomUpTo(12) 
        direccionActual = [norte2, oeste2, sur2, este2].randomized().first()
        if(pasosRestantes == 0 || direccionActual.estaChocandoBorde(self)) {
            direccionActual = [norte2, oeste2, sur2, este2].randomized().first()
            pasosRestantes = 2.randomUpTo(12) 
        } 
        self.moverseHacia(direccionActual, pasosRestantes)
    }

    method moverseHacia(direccion, pasos) {
        if(pasosRestantes > 0){
            direccionActual.mover(self)
            pasosRestantes -= 1        
            ultimaDireccion = direccionActual
        }
    }

    // Enemigo usa la implementación por defecto de sacarVida de Personaje

    override method recibirAtaque(hechizo) {
        if (vida > 0 && !hechizo.esMalvado()) {
            self.sacarVida(hechizo.danio())
            hechizo.destruir()
        }
    }
}

class Arania inherits Enemigo {
    override method poder() = "telaarania.png"
  
    override method sacarVida(cantidad) {
        super(cantidad)
        self.mostrarDanio()
        if (!self.estaVivo()) {
                juego.removerEnemigo(self)
                charcoDeSangre.dejarCharcoDeSangre(self.position())
            }  
    }
  
    override method mostrarDanio() {
                game.schedule(200, { self.image("araniadanio.png") })
        game.schedule(400, { self.image("arania.png") })
    }
}

class Orco inherits Enemigo {
    override method poder() = "bolaOscura.png"

    override method sacarVida(cantidad) {
        super(cantidad)
        self.mostrarDanio()
        if (!self.estaVivo()) {
                juego.removerEnemigo(self)
                charcoDeSangre.dejarCharcoDeSangre(self.position())
        }  
    }
    override method mostrarDanio() {
        game.schedule(200, { self.image("orcoDanio.png") })
        game.schedule(400, { self.image("orco.png") })
    }
}

class Jefe inherits Enemigo {
    override method restaurar() { vida = 8 }

    override method sacarVida(cantidad) {
        super(cantidad)
        self.mostrarDanio()
        if (!self.estaVivo()) {
            game.removeVisual(self)
            charcoDeSangre.dejarCharcoDeSangre(self.position())
            game.schedule(2100, {juego.finDelJuego()})
        }
    }
  
    override method poder() = "bolaDeFuegoVerde.png"

    override method mostrarDanio() {
        game.schedule(200, { self.image("jefedanio.png") })
        game.schedule(400, { self.image("jefe.png") })
    }
}

object charcoDeSangre {
    var property image = "charcoDeSangre.png"
    var property position = game.at(0,0)
    method dejarCharcoDeSangre(posicion) {
        self.image("charcoDeSangre.png")
        game.addVisual(self)
        self.position(posicion)
        game.schedule(2000, {game.removeVisual(self)})
    }

    method recibirAtaque(otroHechizo) {
        // Un hechizo no hace nada cuando choca con el fondo, no choca con ningun enemigo tampoco
        // Se agrega este método vacío para evitar el error 
        // "MessageNotUnderstoodException" cuando colisiona con el fondo.
        otroHechizo.destruir() {}
    }
}
