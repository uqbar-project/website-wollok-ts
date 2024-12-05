import sonidos.*
import pantallas.*
import wollok.game.*
import estadosJuego.*
import juego.*
import tienda.*
import managers.*
import etapas.etapa1.*
import etapas.etapa2.*
import etapas.etapa3.*
import etapas.etapa4.*

import personajes.personaje.*

object nivelManager {
    const property niveles = [niv1,tienda,niv2,tienda,niv3,tienda,niv4]
    var property actual = niv2
    var property obstaculos = #{}

    var property enemigosTotales = 0
    var property enemigosAsesinados = 0

    method posicionesTapadas() {
        return obstaculos.map({o => o.position()})
    }

    method hayCajaEn(pos) {
        return self.posicionesTapadas().any({p => p==pos})
    }

    method iniciarSigNivel() {
        self.validarSigNivel()
        juego.jugador().arma().maxearCargador()
        juego.jugador().position(game.at(10, 7))
        actual = niveles.first()
        actual.inicializar()
        niveles.remove(actual)
    }

    method validarSigNivel() {
        if (niveles.isEmpty()) {
            pantalla.fin()
            juego.estado(cargando)
            self.error("")
        }
    }

    method limpieza() {
        obstaculos.clear()
        actual.ost().stop() 
        managerZombie.terminarPersecucion()
        managerZombie.terminarSpawnCycle()
    }

    method terminarNivel() {
        managerItems.darleTodoAlPersonaje()
        self.limpieza()
        pantalla.animacionCargando()
    }

    method terminarTienda() {
        tienda.ost().stop()
        pantalla.animacionCargando()
    }

    method murioZombie() {
        enemigosAsesinados += 1
        if (enemigosAsesinados == enemigosTotales) {
            self.terminarNivel()
            enemigosAsesinados = 0
        }
    }

}

//Idea: Entre cada nivel aparece la tienda para poder mejorar el Arma/Salud/Energia
//El primer nivel debe ser una pantalla donde presete el juego
//Luego una pantalla donde este el menu y se seleccione el personaje


class Nivel {

    const img
    const enemigos
    method tablero() 
    const property ost 


    method inicializar() {
        ost.play()
        suelo.visualizarCon(img)
        juego.estado(jugando)
        managerZombie.persecucion()
        nivelManager.enemigosTotales(enemigos)
        managerZombie.spawnCycle(enemigos)

        (0..game.width() - 1).forEach({ x =>
            (0..game.height() -1).forEach({y =>
                self.tablero().get(y).get(x).dibujarEn(game.at(x,y))
            })
        })
        hudVisible.dibujar()
    }
}

object _ {
    method dibujarEn(pos) {}
}

//caja
object c {
    method dibujarEn(pos) {
        const cajaNueva = new Caja(position=pos)
        game.addVisual(cajaNueva)
        nivelManager.obstaculos().add(cajaNueva)
    }
}

object p {
    method dibujarEn(pos) {
        const pared = new Pared(position=pos)
        game.addVisual(pared)
    }
}

object m {
    method dibujarEn(pos) {
        const pared = new ParedMusgo(position=pos)
        game.addVisual(pared)
    }
}

class Pared {
    var property image = "Ladrillo1.png"
    var property position 
}

class ParedMusgo inherits Pared(image="Ladrillo2.png") {
}

class Caja {
    var property image = "caja2.png"
    var property position
}


