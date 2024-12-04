import instrucciones.*
import personajes.*
import config.*
import oro.*

object tablero{
  var oroActual = 5
  const oroMaximo = 10
  const property entidadesActivas = []
  const property teclasInstruciones = []

  method oroActual()= oroActual

  method regenerarOro() {
        if (oroActual < oroMaximo) {
            oroActual = oroActual + 1
        }
    }
  method gastarOro(cantidad) {
      if (oroActual >= cantidad) {
          oroActual = oroActual - cantidad
      } 
  }
  method obtenerOro() {
      oroActual
  }

  method reiniciarOro() {
    oroActual = 5
  }

  method intentarAgregarEntidad(unaEntidad){
    if(self.puedeColocarCarta(unaEntidad)) {
      self.agregarEntidad(unaEntidad)
      self.gastarOro(unaEntidad.costo())
    }
    else {
      if (!self.noLlegoAlMaximoDeTropas()) {
        notificacionDeAlertaMaximaEntidades.mostrarNotificacion()
      }
      else {
        notificacionNoHayOro.mostrarNotificacion()
      }
    }
  }

  method agregarEntidad(unaEntidad){
    game.addVisual(unaEntidad)
    entidadesActivas.add(unaEntidad)
    unaEntidad.cumplirObjetivoInicial()
  }

  method oroSuficiente(unaEntidad) {
    var suficiente = false
    if (oroActual >= unaEntidad.costo()) {
      suficiente = true
    }
    return suficiente
  }

  method noLlegoAlMaximoDeTropas() {
    var puede = false
      if ((self.tropas(equipoAzul).size() < config.maximoTropas()) and instrucciones.estaCerrado()) {
        puede = true
    }
    return puede
  }

  method puedeColocarCarta(unaCarta) {
    return self.noLlegoAlMaximoDeTropas() and self.oroSuficiente(unaCarta)
  }

  method agregarTeclasInstrucciones(unaTecla) {
    game.addVisual(unaTecla)
    teclasInstruciones.add(unaTecla)
  }

  method descongelarEntidades(){
    entidadesActivas.forEach({e => e.cumplirObjetivoInicial()})
  }

  method borrarEntidad(unaEntidad){
    entidadesActivas.remove(unaEntidad)
    game.removeVisual(unaEntidad)
  }

  method torres(equipo) = 
    entidadesActivas.filter({entidad => entidad.tipo() == "Torre" and entidad.equipo() == equipo})

  method torreMasCercanaA(unaPosicion,equipo){
    return self.torres(equipo).min({torre => torre.position().distance(unaPosicion)})
  }

  method tropas(equipo) = entidadesActivas.filter({entidad=>entidad.tipo() == "Unidad" and entidad.equipo() == equipo})
  method cantTropas(equipo) = self.tropas(equipo).size()

  method tropaMasCercanaA(unaPosicion, equipo){
    return self.tropas(equipo).min({tropa => tropa.position().distance(unaPosicion)})
  }

  method hayAlgoEn(unaPosicion)=
    entidadesActivas.any({entidad => entidad.position() == unaPosicion})

  method hayAlgoAlrededor(unaPosicion, tropa) {
    return entidadesActivas.any({entidad => entidad.position().distance(unaPosicion) == 1 and entidad.equipo() != tropa.equipo() and entidad.tipo() != "Torre"})  
  }

  method enemigosAlRededor(unaPosicion,tropa)=
    entidadesActivas.filter({entidad => entidad.position().distance(unaPosicion) == 1 and entidad.equipo() != tropa.equipo()})

  method limpiar(){
    self.entidadesActivas().forEach({e => game.removeVisual(e)})
    self.teclasInstruciones().forEach({e => game.removeVisual(e)})
    self.entidadesActivas().clear()
    self.teclasInstruciones().clear()
  }

  method entidadEn(unaPosicion) =
    entidadesActivas.find({entidad => entidad.position() == unaPosicion})
  
  method posicionTorreEnemigaMasCercanaA(unaEntidad){
    return self.torreMasCercanaA(unaEntidad.position(),unaEntidad.equipo().contrario()).position()
  }
}