import mecanicas.*
import aliados.*
import UI.*
import wollok.game.*
import oleadas.*
import images.*
import pieza.*
import trucos.*

object reyBlanco inherits Pieza ( 
  ultimaFila = game.height() - 1, 
  color = blanco, 
  vidas = if (trucos.hardmode()) 0 else 3,
  position = game.at(2, 0),
  imagePieza = images.rey()

  ) {
  const property listaPiezasAliadas = []

  method piezasActivas() = listaPiezasAliadas
  
  override method image() =
    if (vidas <= 0) images.rey3()
    else if (vidas == 1) images.rey2()
    else if (vidas == 2) images.rey1()
    else if (trucos.modoDios()) images.reyDios()
    else images.rey()
  
  method puedeColocar(pieza, ubicacion) {
    return self.recursosSuficientesPara(pieza) && 
        not self.hayPiezaDeColor(blanco, ubicacion) && 
          mecanicasJuego.juegoActivo()
  }

  method recursosSuficientesPara(pieza){
    return recurso.valor() >= pieza.valor()
  }

  method intentarColocarPieza(pieza) {
      if (self.puedeColocar(pieza, self.position().up(1)) && 
        !color.hayPiezaContraria(self.position().up(1))) {
            self.colocarPiezaEn(pieza, self.position().up(1) )
      } else if (
        self.puedeColocar(pieza, self.position().up(1)) && 
        self.hayPiezaDeColor(negro, self.position().up(1))
        ) {
            recurso.restarRecursos(pieza.valor())
            self.desaparecerEnemigoSiHay(self.position().up(1))
      }
  }

  method colocarPiezaEn(pieza, pos) {
      pieza.position(pos)
      game.addVisual(pieza)
      listaPiezasAliadas.add(pieza)
      recurso.restarRecursos(pieza.valor())
  }

  method enemigoEnPosicionADesaparecer(posicion) {
    return if(color.hayPiezaContraria(posicion)) color.piezaContrariaEn(posicion) else null
  }

  method desaparecerEnemigoSiHay(pos) {
    const enemigo = self.enemigoEnPosicionADesaparecer(pos)
    if(color.hayPiezaContraria(pos)){
      enemigo.desaparece(500)
      recurso.añadirRecursos(enemigo.valor() / 2)
      score.addScore(enemigo.valor() / 2)
    }
  }

  method limpiarAliadosInactivos() {
    const aliadosAEliminar = listaPiezasAliadas.filter(
      { aliado => (aliado.position().y() == 0) or (not game.hasVisual(aliado)) }
    )
    aliadosAEliminar.forEach({ aliado => listaPiezasAliadas.remove(aliado) })
  }
  
  method reiniciar() {
    position = game.at(2, 0)
    
    listaPiezasAliadas.clear()
  }

  method disparar(proyectil) {
    if (self.recursosSuficientesPara(proyectil)) {
      self.colocarPiezaEn(proyectil, position)
      proyectil.avanzarYComer()
    }
  }
}