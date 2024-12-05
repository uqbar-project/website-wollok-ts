import wollok.game.*
import proyectiles.*
import posiciones.*
import juego.*
import extras.*
import enemigos.*
import stats.*
import nivelManager.*

object managerCrater {

    method explosionEnCon(pos,dmg) {
        tablero.alrededoresDe(pos).forEach({pos => self.aparecerCraterEn(pos,dmg)})
    }

    method aparecerCraterEn(pos,dmg) {
        const craterNuevo = new Crater(position=pos)
        game.addVisual(craterNuevo)
        craterNuevo.daniar(dmg)
    }
}

object managerItems {
    
    const property drops = #{}  
    var balasEnTablero = 0

    method restarBalasDeTablero() {
        balasEnTablero = balasEnTablero - 1
    }

    method darleTodoAlPersonaje() {
        drops.forEach({d => d.colisionPj()})
    }

    // Oro = 50% / Municion = 35% / Vida = 10% / Nada = 5% 
    method generarDrop(posicion) {
        const numero = 0.randomUpTo(100).round()
        if (numero <= 50) { 
            self.spawnearOro(0.randomUpTo(3).round().max(1), posicion)
        } else if (numero > 50 and numero <= 85) {
            self.spawnearMunicion(posicion)
        } else if (numero > 85 and numero <= 95) {
            self.spawnearCura(0.randomUpTo(3).round().max(1) , posicion)
        } 
    }


    method quitarItem(item) {
        drops.remove(item)
    }

    method revisarPorItems(pos) {
        const itemAhi = drops.filter({d => d.position() == pos})
        itemAhi.forEach({d => d.colisionPj()})
    }

    method spawnearCura(numero, posicion) {
        const nuevaCura = managerCuras.cura(numero, posicion)
        game.addVisual(nuevaCura)
        drops.add(nuevaCura)
    }

    method spawnearOro(numero, posicion) {
        const oroNuevo = managerMonedas.monedas(numero, posicion)
        game.addVisual(oroNuevo)
        drops.add(oroNuevo)
    }

    method spawnearMunicion(posicion) {
        balasEnTablero += 1
        const nuevaMunicion = new Balas(position = posicion)
        game.addVisual(nuevaMunicion)
        drops.add(nuevaMunicion)
    }

    method siNoHayBalasSoltarle() {
        if (balasEnTablero <= 0) {
            self.spawnearMunicion(game.at(10,7))
        }
    }
}

object managerCuras {
    const vida = [20, 40, 80]

    method cura(numero, position) {
        return new Cura(image = juego.jugador().visualHealth(numero)
                , vidaDada = self.vida(numero), position = position)
    }

    method vida(numero) {
        return vida.get(numero - 1)
    }
}

object managerMonedas {
    const oro = [25, 35, 55]
    
    method monedas(numero, position) {
        return new Oro(image = "oro" + numero + ".png",
                valor = self.oro(numero), position = position)
    }

    method oro(numero) {
        return oro.get(numero - 1)
    }
}

object managerZombie {
    const property zombies = #{}
    const property spawnPoints = #{game.at(3,0),game.at(15,0),game.at(3,13),game.at(15,13)} 
    var property zombiesSpawneados = 0


// Zombies del tablero ---------------------------------------------------------


      method posTieneZombie(pos) {
        return (zombies.any({zom => zom.position() == pos}))
    }

    method agregarZ(zombie) {
        zombies.add(zombie)
    }

    method quitarZ(zombie) {
        zombies.remove(zombie)
        especial.murioZombie()
        nivelManager.murioZombie()
    }

    method spawnearZ(zombie) {
        zombies.add(zombie)
        game.addVisual(zombie)
        zombiesSpawneados += 1
    }


// SpawnCycle-------------------------------------------------------------------


    method spawnCycle(cant) {
        game.onTick(3000,"spawnCycle",{self.spawneoRandom(cant)})
    }

    method terminarSpawnCycle() {
        game.removeTickEvent("spawnCycle")
        zombiesSpawneados = 0
    }

    method posicionDeSpawneoRandom() {
        return spawnPoints.anyOne()
    }

    method condicionSpawneoRandom(cant) {
        return (zombies.size() < 3 and (cant > zombiesSpawneados))
    }

    method spawneoRandom(cant) {
        if (self.condicionSpawneoRandom(cant)) { 
            self.realizarSpawneoRandom()
        }
    }

    method realizarSpawneoRandom() {
        const zombieNuevo = 1.randomUpTo(3).round()
        if(zombieNuevo == 1) {
            self.spawnearZ(new ZombieComun(position=self.posicionDeSpawneoRandom()))
        }
        else if(zombieNuevo == 2) {
            self.spawnearZ(new ZombiePerro(position=self.posicionDeSpawneoRandom()))
        }
        else {
            self.spawnearZ(new ZombieTanque(position=self.posicionDeSpawneoRandom()))
        }
    }


// Persecución ---------------------------------------------------------------------


    method persecucion() {
        game.onTick(650,"persecucionGame",{zombies.forEach({z => z.perseguirAJugador()})})
    }

    method terminarPersecucion() {
        game.removeTickEvent("persecucionGame")
    }

}
