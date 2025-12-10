import nivel1.*
import nivel2.*
import personajes.*
import objetos.*
import screens.*

object colisiones {
  var limiteIzq = 1
  
  method aumentarLimiteIzq() {
    limiteIzq = -1
  }
  
  // colisiones del heroe con el entorno (evita que atraviese las paredes)
  method comprobarBordes() {
    if (heroe.position().y() >= (game.height() - 2)) heroe.position(
        heroe.position().down(1)
      )
    if (heroe.position().y() <= 1) heroe.position(heroe.position().up(1))
    if (heroe.position().x() <= limiteIzq) heroe.position(
        heroe.position().right(1)
      )
    if (heroe.position().x() >= (game.width() - 2)) heroe.position(
        heroe.position().left(1)
      )
  }
  
  method cambiarMediosHeroe() {
    keyboard.left().onPressDo({ heroe.cambiarAssetIzq() })
    keyboard.right().onPressDo({ heroe.cambiarAssetDer() })
  }

  method comprobarColisionesDeEsqueletoCorrupto() {
    game.whenCollideDo(
      esqueletoCorrupto,
      { elemento =>
        if (!elemento.esElJugador()) {
          elemento.moverse()
        }
      }
    )
  }
  
  method comprobarColisionesConHostiles() {
    game.whenCollideDo(
      heroe,
      { elemento =>
        if (elemento.esHostil()) {
          heroe.perderVida(elemento.daño())
          heroe.volverAlOrigen()
          nivelManager.reordenarPicos()
          
          if (!game.hasVisual(cartelNivel2)) {
            nivelManager.generarEsqueletoMortal()
          } else {
            nivelManager.generarEsqueletoMortal()
            nivelManager.generarEsqueletoMortal()
          }
          
          if (elemento.atacaConVeneno()) heroe.serEnvenenado()
          
          if (elemento.esPersonaje()) elemento.moverse()
          
          game.schedule(700, { heroe.restaurarAsset() })
          
          if (heroe.vida() <= 0) {
            game.addVisual(helpScreenBg)
            game.addVisual(gameOver)
            
            if (game.hasVisual(menuKey)) {
              game.removeVisual(menuKey)
              game.addVisual(menuKey)
            } else {
              game.addVisual(menuKey)
            }
            ambientacion.stop()
            
            // Desactivar colisiones
            game.whenCollideDo(heroe, { elemento => return })
            
            // Remover tick events para detener el movimiento
            game.removeTickEvent("generarUnMurcielago")
            game.removeTickEvent("movimientoMurcielagos")
            game.removeTickEvent("movimientoEsqueletos")
            game.removeTickEvent("bordes")
            game.removeTickEvent("movimientoHeroe")
            
            // Configurar tecla M para volver al menú
            keyboard.m().onPressDo(
              { if (game.hasVisual(gameOver)) {
                  // Remover elementos de Game Over
                  gameOverScreen.removerElementos()
                  
                  // Reiniciar completamente el juego
                  nivelManager.reiniciarJuego()
                  
                  // Volver al menú inicial
                  menuInicial.setup()
                  helpScreen.activarInput()
                } }
            )
          }
        }
        
        if (elemento.esLaPuertaAlNivel2()) nivel2.setup()
        
        if (elemento.esPicoCorrupto() and (!elemento.estaDestruido())) {
          esqueletoCorrupto.serDañado()
          elemento.romperse()
          nivelManager.reordenarPicosCorruptos()
        }
        
        if (elemento.esLaPuertaFinal()) nivelManager.escaparDeLaMazmorra()
      }
    )
  }
}

object gameOverScreen {
  method removerElementos() {
    // Verificamos si los objetos están en juego antes de removerlos para evitar errores
    if (game.hasVisual(helpScreenBg)) {
      game.removeVisual(helpScreenBg)
      game.removeVisual(gameOver)
      game.removeVisual(menuKey)
    }
  }
}

object ambientacion {
  const sonido = game.sound("ambientacion.mp3")
  
  method reproducir() {
    if (sonido.played()) {
      sonido.stop()
      sonido.play()
    } else {
      sonido.play()
    }
  }
  
  method pausa() {
    if (sonido.paused()) {
      return
    } else {
      sonido.pause()
    }
  }
  
  method resumir() {
    if (sonido.paused()) sonido.resume()
  }
  
  method volumen(num) {
    sonido.volume(num)
  }
  
  method loop(bool) {
    sonido.shouldLoop(bool)
  }
  
  method stop() {
    if (sonido.played()) sonido.stop()
  }
}

object nivelManager {
  var picosNivel = [
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico(),
    new Pico()
  ]
  var murcielagosNivel = []
  var esqueletosEnNivel = []
  var limiteDeMurcielagosActual = 5
  var limiteDeEsqueletosActual = 2
  const picoCorrupto1 = new PicoCorrupto()
  const picoCorrupto2 = new PicoCorrupto()
  const picoCorrupto3 = new PicoCorrupto()
  var picosCorruptosEnNivel = [picoCorrupto1, picoCorrupto2, picoCorrupto3]
  
  method picosNivel() = picosNivel
  
  method murcielagosNivel() = murcielagosNivel
  
  method esqueletosEnNivel() = esqueletosEnNivel
  
  method picosCorruptosEnNivel() = picosCorruptosEnNivel
  
  method reordenarPicos() {
    picosNivel.forEach({ p => p.reordenar() })
  }
  
  method moverMurcielagos() {
    murcielagosNivel.forEach({ m => m.moverse() })
  }
  
  method reiniciarEsqueletosNivel() {
    esqueletosEnNivel = []
  }
  
  method reiniciarEnemigosYObjetosNivel() {
    murcielagosNivel = []
    esqueletosEnNivel = []
    picosNivel = []
  }
  
  method cambiarLimiteDeEsqueletosA(unaCantidad) {
    limiteDeEsqueletosActual = unaCantidad
  }
  
  method cambiarLimiteDeMurcielagosA(unaCantidad) {
    limiteDeMurcielagosActual = unaCantidad
  }
  
  method generarMurcielagoDeCueva() {
    if (murcielagosNivel.size() == limiteDeMurcielagosActual) {
      return
    } else {
      const nuevoMurcielago = new MurcielagoDeCueva(
        vida = 30.randomUpTo(70).truncate(0)
      )
      
      murcielagosNivel.add(nuevoMurcielago)
      game.addVisual(nuevoMurcielago)
    }
  }
  
  method generarEsqueletoMortal() {
    if (esqueletosEnNivel.size() == limiteDeEsqueletosActual) {
      return
    } else {
      const nuevoEsqueleto = new EsqueletoMortal()
      
      esqueletosEnNivel.add(nuevoEsqueleto)
      game.addVisual(nuevoEsqueleto)
    }
  }
  
  method moverEsqueletos() {
    esqueletosEnNivel.forEach({ e => e.moverse() })
  }
  
  method reordenarPicosCorruptos() {
    picosCorruptosEnNivel.forEach({ pc => pc.reordenar() })
  }
  
  method reaparecerMurcielagos() {
    game.onTick(
      1400,
      "generarUnMurcielago",
      { self.generarMurcielagoDeCueva() }
    )
    murcielagosNivel.forEach({ m => game.addVisual(m) })
  }
  
  method reiniciarJuego() {
    // Remover todos los onTicks
    game.removeTickEvent("generarUnMurcielago")
    game.removeTickEvent("movimientoMurcielagos")
    game.removeTickEvent("movimientoEsqueletos")
    game.removeTickEvent("bordes")
    game.removeTickEvent("movimientoHeroe")
    
    // Remover los visuales de enemigos
    murcielagosNivel.forEach(
      { m => if (game.hasVisual(m)) game.removeVisual(m) }
    )
    esqueletosEnNivel.forEach(
      { e => if (game.hasVisual(e)) game.removeVisual(e) }
    )
    
    // Remover los visuales de objetos
    picosNivel.forEach({ p => if (game.hasVisual(p)) game.removeVisual(p) })
    picosCorruptosEnNivel.forEach(
      { pc => if (game.hasVisual(pc)) game.removeVisual(pc) }
    )
    
    
    // Remover otros visuales de elementos si estan visibles
    if (game.hasVisual(puertaANivel2)) game.removeVisual(puertaANivel2)
    if (game.hasVisual(puertaFinal)) game.removeVisual(puertaFinal)
    if (game.hasVisual(esqueletoCorrupto)) game.removeVisual(esqueletoCorrupto)
    if (game.hasVisual(heroe)) game.removeVisual(heroe)
    
    // Limpiar listas de elementos y reiniciar limites
    self.reiniciarEnemigosYObjetosNivel()
    self.cambiarLimiteDeEsqueletosA(2)
    self.cambiarLimiteDeMurcielagosA(5)
    
    
    // Se vuelven a instanciar los picos para el nivel 1
    picosNivel = [
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico(),
      new Pico()
    ]
    
    
    // Reiniciar estado de los picos corruptos y esqueleto corrupto
    picosCorruptosEnNivel = [picoCorrupto1, picoCorrupto2, picoCorrupto3]
    picosCorruptosEnNivel.forEach({ pc => pc.reiniciarEstado() })
    esqueletoCorrupto.reiniciarEstado()
    
    // Reiniciar estados y posiciones del juego
    corrosion.reiniciarCorrosion()
    helpScreen.reiniciarPosicion()
    heroe.reiniciarPosicion()
    heroe.reiniciarVida()
    helpScreen.reiniciarInstancia()
    menuKey.menuInicial()
    
    // Remover elementos de niveles
    nivel1.removeElements()
    nivel2.removeElements()
    
    // Detener música de fondo
    ambientacion.stop()
  }
  
  method derrotarEsqueletoCorrupto() {
    esqueletosEnNivel.forEach({ e => game.removeVisual(e) })
    murcielagosNivel.forEach({ m => game.removeVisual(m) })
    picosNivel.forEach({ p => game.removeVisual(p) })
    picosCorruptosEnNivel.forEach({ p => game.removeVisual(p) })
    
    game.removeTickEvent("movimientoMurcielagos")
    game.removeTickEvent("movimientoEsqueletos")
    game.removeTickEvent("generarUnMurcielago")
    
    game.addVisual(puertaFinal)
  }
  
  method pausarJuego() {
    if (game.hasVisual(cartelNivel2) or game.hasVisual(cartelNivel1)) {
      // se pausa la musica de fondo
      ambientacion.pausa()
      
      // se desaparece al jugador para que no se mueva mientras se esta en pausa
      heroe.guardarUltimaPosicion(heroe.position().x(), heroe.position().y())
      game.removeVisual(heroe)
      
      // se remueven los ticks de los enemigos para que mientras el usuario ve las instrucciones del nivel no sufra daño
      game.removeTickEvent("movimientoMurcielagos")
      game.removeTickEvent("movimientoEsqueletos")
      game.removeTickEvent("generarUnMurcielago")
    }
  }
  
  method reanudarJuego() {
    if (game.hasVisual(cartelNivel2) or game.hasVisual(cartelNivel1)) {
      // se reanuda la musica de fondo
      ambientacion.resumir()
      
      // reaparece el jugador
      game.addVisual(heroe)
      
      // se vuelve a añadir el movimiento cada cierto tiempo a los murcielagos y esqueletos
      game.onTick(900, "movimientoMurcielagos", { self.moverMurcielagos() })
      game.onTick(1500, "movimientoEsqueletos", { self.moverEsqueletos() })
      game.onTick(
        1400,
        "generarUnMurcielago",
        { self.generarMurcielagoDeCueva() }
      )
    }
  }
  
  method escaparDeLaMazmorra() {
    nivel2.removeElements()
    menuInicial.removeElements()
    
    // Desactivar colisiones
    game.whenCollideDo(heroe, { elemento => return })
    
    // Remover tick events para detener el movimiento
    game.removeTickEvent("generarUnMurcielago")
    game.removeTickEvent("movimientoMurcielagos")
    game.removeTickEvent("movimientoEsqueletos")
    game.removeTickEvent("bordes")
    game.removeTickEvent("movimientoHeroe")
    
    if (game.hasVisual(fondoEscape)) {
      game.removeVisual(fondoEscape)
      game.addVisual(fondoEscape)
    } else {
      game.addVisual(fondoEscape)
    }
    
    titulo.pantallaFinal()
    
    if (game.hasVisual(titulo)) {
      game.removeVisual(titulo)
      game.addVisual(titulo)
    } else {
      game.addVisual(titulo)
    }
    
    menuKey.pantallaFinal()
    
    if (game.hasVisual(menuKey)) {
      game.removeVisual(menuKey)
      game.addVisual(menuKey)
    } else {
      game.addVisual(menuKey)
    }
    
    // Configurar tecla M para volver al menú
    keyboard.m().onPressDo(
      { if (game.hasVisual(menuKey)) {
          // Remover elementos de Game Over
          gameOverScreen.removerElementos()
          
          // Reiniciar completamente el juego
          self.reiniciarJuego()
          
          titulo.menuInicial()
          
          // Volver al menú inicial
          menuInicial.setup()
          helpScreen.activarInput()
        } }
    )
  }
}