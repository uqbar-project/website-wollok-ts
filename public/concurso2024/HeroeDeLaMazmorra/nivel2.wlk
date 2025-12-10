import screens.*
import nivelManager.*
import personajes.*
import objetos.*
import nivel1.*

object nivel2 {
  // se inicia el nivel 2
  method setup() {
    colisiones.aumentarLimiteIzq()
    helpScreen.cambiarInstanciaA(2)
    nivel1.removeElements()
    
    corrosion.corromperEsqueletos()

    nivelManager.cambiarLimiteDeEsqueletosA(4)
    nivelManager.cambiarLimiteDeMurcielagosA(7)
    
    if (!game.hasVisual(fondoNivel2)) game.addVisual(fondoNivel2)
    
    if (!game.hasVisual(helpKey)) game.addVisual(helpKey)
    
    nivelManager.murcielagosNivel().forEach({ m => game.removeVisual(m) })
    
    nivelManager.picosNivel().forEach({ p => game.addVisual(p) })
    nivelManager.reordenarPicos()
    
    nivelManager.picosCorruptosEnNivel().forEach({ pc => game.addVisual(pc) })
    
    heroe.agregarAlJuego()
    
    nivelManager.generarEsqueletoMortal()
    nivelManager.generarEsqueletoMortal()
    
    game.addVisual(esqueletoCorrupto)
    if (!game.hasVisual(cartelNivel2)) game.addVisual(cartelNivel2)
  }
  
  method removeElements() {
    if (game.hasVisual(fondoNivel2)) game.removeVisual(fondoNivel2)
    if (game.hasVisual(cartelNivel2)) game.removeVisual(cartelNivel2)
    if (game.hasVisual(helpKey)) game.removeVisual(helpKey)
    if (game.hasVisual(puertaFinal)) game.removeVisual(puertaFinal)
    if (game.hasVisual(heroe)) game.removeVisual(heroe)
    if (game.hasVisual(esqueletoCorrupto)) game.removeVisual(esqueletoCorrupto)
    
    nivelManager.picosNivel().forEach(
      { p => if (game.hasVisual(p)) game.removeVisual(p) }
    )
    nivelManager.picosCorruptosEnNivel().forEach(
      { pc => if (game.hasVisual(pc)) game.removeVisual(pc) }
    )
    nivelManager.murcielagosNivel().forEach(
      { m => if (game.hasVisual(m)) game.removeVisual(m) }
    )
    nivelManager.esqueletosEnNivel().forEach(
      { e => if (game.hasVisual(e)) game.removeVisual(e) }
    )
  }
}