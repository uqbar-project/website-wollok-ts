import screens.*
import nivelManager.*
import personajes.*
import objetos.*

object nivel1 {
  // se inicia el nivel 1
  method setup() {
    if ((!game.hasVisual(cartelNivel1)) and (!game.hasVisual(cartelNivel2))) {
      helpScreen.posicionNiveles()
      helpScreen.cambiarInstanciaA(1)
      menuInicial.removeElements()
      
      ambientacion.volumen(0.7)
      ambientacion.reproducir()
      ambientacion.loop(true)
      
      if (!game.hasVisual(fondoNivel1)) game.addVisual(fondoNivel1)
      
      game.addVisual(cartelNivel1)
      game.addVisual(helpKey)
      
      heroe.agregarAlJuego()
      
      nivelManager.generarMurcielagoDeCueva()
      nivelManager.generarMurcielagoDeCueva()
      nivelManager.generarMurcielagoDeCueva()
      nivelManager.generarMurcielagoDeCueva()
      
      nivelManager.picosNivel().forEach(
        { p => if (game.hasVisual(p)) game.removeVisual(p) }
      )
      nivelManager.picosNivel().forEach({ p => game.addVisual(p) })
      
      game.onTick(
        1400,
        "generarUnMurcielago",
        { nivelManager.generarMurcielagoDeCueva() }
      )
      game.onTick(200, "bordes", { colisiones.comprobarBordes() })
      game.onTick(100, "movimientoHeroe", { colisiones.cambiarMediosHeroe() })
      
      colisiones.comprobarColisionesConHostiles()
      
      nivelManager.generarEsqueletoMortal()
      nivelManager.generarEsqueletoMortal()
      
      // cada 0.9s se mueven los murcielagos
      game.onTick(
        900,
        "movimientoMurcielagos",
        { nivelManager.moverMurcielagos() }
      )
      // cada 1.5s se mueven los murcielagos
      game.onTick(
        1500,
        "movimientoEsqueletos",
        { nivelManager.moverEsqueletos() }
      )
      
      if (!game.hasVisual(puertaANivel2)) game.addVisual(puertaANivel2)
    }
  }
  
  method removeElements() {
    if (game.hasVisual(fondoNivel1)) game.removeVisual(fondoNivel1)
    if (game.hasVisual(cartelNivel1)) game.removeVisual(cartelNivel1)
    if (game.hasVisual(helpKey)) game.removeVisual(helpKey)
    if (game.hasVisual(puertaANivel2)) game.removeVisual(puertaANivel2)
    if (game.hasVisual(heroe)) game.removeVisual(heroe)
    
    nivelManager.picosNivel().forEach(
      { p => if (game.hasVisual(p)) game.removeVisual(p) }
    )
    nivelManager.murcielagosNivel().forEach(
      { m => if (game.hasVisual(m)) game.removeVisual(m) }
    )
    nivelManager.esqueletosEnNivel().forEach(
      { e => if (game.hasVisual(e)) game.removeVisual(e) }
    )
    
    game.removeTickEvent("generarUnMurcielago")
  }
}