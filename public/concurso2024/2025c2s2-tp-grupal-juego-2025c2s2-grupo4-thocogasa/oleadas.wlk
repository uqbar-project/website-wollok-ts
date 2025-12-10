import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import enemigo.*
import enemigos.*
import images.*
import timers.*
import trucos.*

object oleada {
  const property enemigosPorSpawnear = []
  const property enemigosActivos = []
  var property intervaloSpawn = if (trucos.lento()) 5000 else 2000
  var property intervaloMovimiento = if (trucos.lento()) 2500 else 1500
  var property spawnerActivo = false
  var property movimientoActivo = false
  var property enTransicion = false
  var property nivel = 1

  method piezasActivas() = enemigosActivos
  
  method enemigoAleatorio() {
    const disponibles = []
    if (nivel >= 0) disponibles.add(new PeonEnemigo())
    if (nivel >= 3) disponibles.add(new TorreNegro())
    if (nivel >= 5) disponibles.add(new AlfilNegro())
    if (nivel >= 7) disponibles.add(new CaballoNegro())
    if (nivel >= 20) disponibles.add(new DamaNegro())

    return if (disponibles.isEmpty()) new PeonEnemigo() else disponibles.anyOne()
  }

  method crearOleada(cantidad) {
    cantidad.times({ i => enemigosPorSpawnear.add(self.enemigoAleatorio()) })
  }
  
  method spawnearSiguienteEnemigo() {
    if (not enemigosPorSpawnear.isEmpty()) {
      const nuevoEnemigo = enemigosPorSpawnear.first()
      enemigosPorSpawnear.remove(nuevoEnemigo)
      enemigosActivos.add(nuevoEnemigo)
      game.addVisual(nuevoEnemigo)
    } else {
      self.detenerSpawner()
    }
  }
  
  method moverTodosLosEnemigos() {
    const enemigosParaMover = enemigosActivos.copy()
    enemigosParaMover.forEach({ enemigo => enemigo.avanzar() })
    
    reyBlanco.limpiarAliadosInactivos()
    self.limpiarEnemigosInactivos()
  }
  
  method limpiarEnemigosInactivos() {
    const enemigosAEliminar = enemigosActivos.filter(
      { enemigo => (enemigo.position().y() == 0) or (not game.hasVisual(
          enemigo
        )) }
    )
    enemigosAEliminar.forEach({ enemigo => enemigo.desaparece(0) enemigosActivos.remove(enemigo) })
  }
  
  method iniciarSpawner() {
    if (not spawnerActivo) {
      spawnerActivo = true
      game.onTick(
        intervaloSpawn,
        "spawner_enemigos",
        { self.spawnearSiguienteEnemigo() }
      )
    }
  }
  
  method detenerSpawner() {
    if (spawnerActivo) {
      spawnerActivo = false
      game.removeTickEvent("spawner_enemigos")
    }
  }
  
  method iniciarMovimientoEnemigos() {
    if (not movimientoActivo) {
      movimientoActivo = true
      game.onTick(
        intervaloMovimiento,
        "movimiento_enemigos",
        { self.moverTodosLosEnemigos() }
      )
    }
  }
  
  method detenerMovimientoEnemigos() {
    if (movimientoActivo) {
      movimientoActivo = false
      game.removeTickEvent("movimiento_enemigos")
    }
  }
  
  method iniciarOleada() {
    self.iniciarSpawner()
    self.iniciarMovimientoEnemigos()
    enTransicion = false
  }
  
  method detenerOleada() {
    self.detenerSpawner()
    self.detenerMovimientoEnemigos()
  }
  
  method enemigosRestantes() = enemigosPorSpawnear.size() + enemigosActivos.size()
  
  method oleadaCompleta() = enemigosPorSpawnear.isEmpty() and enemigosActivos.isEmpty()
  
  method reiniciar() {
    self.detenerOleada()
    timers.nextId(0)
    
    enemigosPorSpawnear.clear()
    enemigosActivos.clear()
    spawnerActivo = false
    movimientoActivo = false
    enTransicion = false
  }

  method iniciarTransicion() {
    enTransicion = true
    game.addVisual(transiciónOleada)
  }

  method terminarTransicion() {
    enTransicion = false
    game.removeVisual(transiciónOleada)
  }

  method estaEnTransicion() = enTransicion
}

object transiciónOleada {
  var property position = game.at(2, 4)
  var property image = images.transicionOleada()
}