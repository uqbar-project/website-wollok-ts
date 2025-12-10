import objetos.*
import enemigos.*
import cachito.*
import escenario.*
import ubicaciones.*
object dificultadFacil {
  method configurar() {
    escenario.enDificil(false)
    escenario.dificultad(self)
    casa.pista(pistaCasa)
    pueblo.pista(pistaPueblo)
    salaNahuelito.pista(pistaNahuelito)
    salaAlien.pista(pistaAlien)
    salaLuzMala.pista(pistaLuzMala)
    pomberito.vidaMaxima(4)
  }

  method ataquePomberito() {
    const ataques = [ataque1, ataque2, ataque3]
    ataques.anyOne().atacar()
  }
  method agregarEspinasDelAlien() {
    const coordenadas = [[1, 10], [1, 9], [1, 8], [1, 6], [1, 5], [1, 3], [9, 10], [9, 8], [9, 7], 
                         [9, 6], [9, 4], [9, 3], [9, 2], [5, 6], [7, 1], [4, 10]]
    coordenadas.forEach({c => escenario.obstaculosAnimados().add(escenario.calidad().espinasDelAlien(c.first(), c.last()))})
    escenario.obstaculosAnimados().forEach({o => o.ubicar()})  
  }
  method flashLuzMala() {
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
  }  
  method moverTotem() {
    luzMala.contador(luzMala.contador() + 1)
    totemL.position(luzMala.posicionesTotem().anyOne())
  }
  
  method ataqueNahuelito() {
    game.onTick(850, "atacar", { nahuelito.atacar() })
  }
  method cambiar() {
    dificultadDificil.configurar()
  }
}

object dificultadDificil {
  method configurar() {
    escenario.enDificil(true)
    escenario.dificultad(self)
    casa.pista(pistaCasaH)
    pueblo.pista(pistaPuebloH)
    salaNahuelito.pista(pistaNahuelitoH)
    salaLuzMala.pista(pistaLuzMalaH)
    salaAlien.pista(pistaAlienH)
    luzMala.image("luzMalaH.png")
    pomberito.vidaMaxima(6)
  }

  
  method ataquePomberito() {
    const ataques = [ataque1, ataque2, ataque3, ataque4]
    ataques.anyOne().atacar()
  }
  
  method crearYDispararRocaAbajo(x, y, velocidad) {
    const roca = new RocaAbajo(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }
  
  method crearYDispararRocaIzq(x, y, velocidad) {
    const roca = new RocaIzq(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }
  
  method crearYDispararRocaDer(x, y, velocidad) {
    const roca = new RocaDer(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }
  
  method paredCentral() {
    (2 .. 7).forEach({ x => self.crearYDispararRocaAbajo(x, 9, 150) })
  }
  
  method paredConHuecosYDesface(x, y) {
    (0 .. 7).forEach({ i => self.crearYDispararRocaAbajo((i * 2) + x, y, 150) })
  }
  
  method agregarEspinasDelAlien() {
    const coordenadas = [[1, 10],[1, 9],[1, 8],[1, 6],[1, 5],[1, 3],[9, 10],[9, 8], [9, 7],
                         [9, 6],[9, 4], [9, 3],[9, 2],[5, 9],[5, 6],[5, 3],[3, 1],[5, 1],
                         [7, 1],[2, 10],[3, 10],[4, 10]]
    coordenadas.forEach({c => escenario.obstaculosAnimados().add(escenario.calidad().espinasDelAlien(c.first(), c.last()))})
    escenario.obstaculosAnimados().forEach({o => o.ubicar()})
  }
  method flashLuzMala() {
    luzMala.ubicarEspina()
    flash.agregar()
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
  }
  method moverTotem() {
    luzMala.contador(luzMala.contador() + 1)
    totemL.position(
      luzMala.posicionesTotem().filter(
        { p => p != luzMala.espina().position() }
      ).anyOne()
    )
  }
  
  method ataqueNahuelito() {
    game.onTick(700, "atacar", { nahuelito.atacar() })
    game.onTick(3500, "atacar", { nahuelito.ataqueEspecial() })
  }
  method cambiar() {
    dificultadFacil.configurar()
  }

  method ataquePomberitoPoseido() {
    const ataques = [ataqueFuego1 , ataqueFuego2]
    ataques.anyOne().atacar()
    game.onTick(9000, "ataquePomberitoPoseido", {if (not pomberitoPoseido.derrotado()) ataques.anyOne().atacar()})
  }
}

object ataqueFuego1 {
  method atacar() {
    game.onTick(
      1000,
      "ataque1PomberitoPoseido",
      { 
        const fuego = new FuegoGuiado(x = pomberito.position().x(), y = pomberito.position().y())
        fuego.position(pomberito.position())
        fuego.disparar()
      }
    )
    game.schedule(5000, { 
      game.removeTickEvent("ataque1PomberitoPoseido")
    })
  }
}

object ataqueFuego2 {
  const posX = [1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 ,  10]
  const posY = [1 , 1 , 1 , 1 , 1 , 2 , 2 , 2 , 2 , 2 , 3 , 3 , 3 , 3 , 3 , 4 , 4 , 4 , 4 , 4]
  const humos = []
  const llamas = []
  const coordenadas = []

  method crearObjetos() {
    posY.forEach({c => coordenadas.add([posX.anyOne() , c])})
    coordenadas.forEach({p => humos.add(escenario.calidad().humo(p.first() , p.last()))})
    coordenadas.forEach({p => llamas.add(escenario.calidad().fuego(p.first() , p.last()))})
    coordenadas.clear()
  }
  method atacar() {
    self.crearObjetos()
    self.iniciarHumo()
    game.schedule(3000 , {self.iniciarFuego()})

  }

  method iniciarHumo() {
    humos.forEach({a =>a.ubicar()})
    game.schedule(3100, {
      humos.forEach({a => a.remover()})
      humos.clear()
    })
  }

  method iniciarFuego() {
    llamas.forEach({a => a.ubicar()})
    game.schedule(6000, {
      llamas.forEach({a => a.remover()})
      llamas.clear()
    })
  }

  method eliminarTodosLosElementos() {
    if (not humos.isEmpty()) {
      humos.forEach({a => a.remover()})
    }
    if (not llamas.isEmpty()) {
      llamas.forEach({a => a.remover()})
    }

  }
}

object ataque1 {
  method atacar() {
    dificultadDificil.paredCentral()
    game.schedule(
      5000,
      { 
        const roca = new RocaAbajo(vel = 100, x = cachito.position().x(), y = 9)
        roca.position(pomberito.position())
        return roca.disparar()
      }
    )
  }
}

object ataque2 {
  method atacar() {
    dificultadDificil.paredConHuecosYDesface(0, 7)
    dificultadDificil.paredConHuecosYDesface(1, 9)
    dificultadDificil.paredConHuecosYDesface(0, 11)
  }
}

object ataque3 {
  method atacar() {
    game.onTick(
      200,
      "ataque3Pomberito",
      { 
        const roca = new RocaAbajo(
          vel = 100,
          x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].anyOne(),
          y = 9
        )
        roca.position(pomberito.position())
        return roca.disparar()
      }
    )
    game.schedule(5500, { game.removeTickEvent("ataque3Pomberito") })
  }
}

object ataque4 {
  method atacar() {
    game.onTick(
      750,
      "ataque4Pomberito",
      { 
        const roca = new RocaAbajo(vel = 100, x = cachito.position().x(), y = 9)
        roca.position(pomberito.position())
        roca.disparar()
        const roca1 = new RocaIzq(vel = 250, x = 1, y = 7)
        roca1.position(pomberito.position())
        roca1.disparar()
        const roca2 = new RocaDer(vel = 250, x = 10, y = 7)
        roca2.position(pomberito.position())
        return roca2.disparar()
      }
    )
    
    game.schedule(5500, { game.removeTickEvent("ataque4Pomberito") })
  }
}