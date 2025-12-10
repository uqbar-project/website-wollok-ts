import objetos.*
import screens.*
import wollok.game.*
import nivelManager.*

object heroe {
  var property imagen = "heroe.png"
  var property position = game.at(2, 4)
  var property vida = 150
  var property estaEnvenenado = false
  
  var yaSeAgregoComoCharacter = false
  
  method agregarAlJuego() {
    if (!yaSeAgregoComoCharacter) {
      game.addVisualCharacter(self)
      yaSeAgregoComoCharacter = true
    } else {
      if (!game.hasVisual(self)) game.addVisual(self)
    }
  }
  
  method image() = imagen
  
  method position() = position

  method esElJugador() = true
  
  method estaEnvenenado() = estaEnvenenado
  
  method serEnvenenado() {
    estaEnvenenado = true
    imagen = "heroeEnvenenado.png"
    game.say(self, "Veneno... Ahora los golpes van a doler mas")
  }
  
  method vida() = vida
  
  method reiniciarVida() {
    vida = 150
    imagen = "heroe.png"
  }
  
  method perderVida(cantidad) {
    var dañoRecibido = cantidad
    
    if (self.estaEnvenenado()) {
      dañoRecibido += 10
    }
    
    vida -= dañoRecibido
    imagen = "heroeDañado.png"
  }
  
  method cambiarAssetIzq() {
    if (imagen == "heroeAUnGolpe.png") {
      imagen = "heroeAUnGolpeIzq.png"
    } else {
      if (imagen == "heroe.png") {
        imagen = "heroeIzq.png"
      }
    }
  }
  
  method cambiarAssetDer() {
    if (imagen == "heroeAUnGolpeIzq.png") {
      imagen = "heroeAUnGolpe.png"
    } else {
      if (imagen == "heroeIzq.png") {
        imagen = "heroe.png"
      }
    }
  }
  
  method guardarUltimaPosicion(x, y) {
    position = game.at(x, y)
  }
  
  method reiniciarPosicion() {
    position = game.at(2, 4)
  }
  
  method volverAlOrigen() {
    if (game.hasVisual(cartelNivel2)) {
      position = game.at(20, 4)
    } else {
      position = game.at(2, 4)
    }
  }
  
  method restaurarAsset() {
    imagen = "heroe.png"
    
    // el heroe esta muy debilitado
    if (((vida <= 45) and (imagen !== "heroeAUnGolpe.png")) or ((vida <= 30) and (imagen !== "heroeAUnGolpeIzq.png"))) {
      imagen = "heroeAUnGolpe.png"
      game.say(self, "Me queda poca vida...")
    }
  }
}

class MurcielagoDeCueva {
  var property vida
  var property daño = vida.div(10)
  var property esVenenoso = vida.even()
  var property image = "murcielagoDeCueva.png"
  const x = 2.randomUpTo(game.width() - 2).truncate(0)
  const y = 2.randomUpTo(game.height() - 2).truncate(0)
  var position = game.at(x, y)

  method esElJugador() = false

  method esPersonaje() = true
  
  method atacaConVeneno() = false
  
  method esLaPuertaAlNivel2() = false
  
  method esLaPuertaFinal() = false
  
  method esHostil() = true
  
  method esPicoCorrupto() = false
  
  method daño() {
    if (!esVenenoso) {
      return daño
    } else {
      return daño + 15
    }
  }
  
  method image() = image
  
  method position() = position
  
  method moverse() {
    var xNueva = 2.randomUpTo(game.width() - 2).truncate(0)
    var yNueva = 2.randomUpTo(game.height() - 2).truncate(0)
    
    if ((xNueva == 2) and (yNueva == 4)) {
      xNueva += 1
      yNueva += 1
    }
    
    position = game.at(xNueva, yNueva)
  }
}

class EsqueletoMortal {
  const x = 2.randomUpTo(game.width() - 2).truncate(0)
  const y = 2.randomUpTo(game.height() - 2).truncate(0)
  var position = game.at(x, y)

  method esPersonaje() = true

  method esElJugador() = false
  
  method esLaPuertaAlNivel2() = false
  
  method esHostil() = true
  
  method esPicoCorrupto() = false
  
  method esLaPuertaFinal() = false
  
  method image() = corrosion.image()
  
  method atacaConVeneno() = corrosion.estado()
  
  method daño() = 30
  
  method position() = position
  
  method moverse() {
    const xNueva = 2.randomUpTo(game.width() - 2).truncate(0)
    const yNueva = 2.randomUpTo(game.height() - 2).truncate(0)
    
    position = game.at(xNueva, yNueva)
  }
}

object corrosion {
  var estado = false // si esta corrupto ataca con veneno generando mas daño
  var imagen = "esqueletoMortal.png"
  
  method estado() = estado
  
  method image() = imagen
  
  method corromperEsqueletos() {
    estado = true
    imagen = "esqueletoMortalCorrupto.png"
  }
  
  method reiniciarCorrosion() {
    estado = false
    imagen = "esqueletoMortal.png"
  }
}

object esqueletoCorrupto {
  var imagen = "esqueletoCorrupto.png"
  var picosCorruptosEnNivel = 3
  
  method esPersonaje() = true

  method esElJugador() = false

  method esPicoCorrupto() = false
  
  method esLaPuertaAlNivel2() = false
  
  method esLaPuertaFinal() = false
  
  method esHostil() = true
  
  method atacaConVeneno() = false
  
  method daño() = 0
  
  method image() = imagen
  
  method position() = game.at(2, 4)
  
  method invocarMurcielagos() {
    if (picosCorruptosEnNivel == 2) nivelManager.reaparecerMurcielagos()
  }

  method moverse(){}
  
  method debilitarse() {
    if (picosCorruptosEnNivel == 1) {
      imagen = "esqueletoCorruptoDañadoFase2.png"
      game.schedule(900, { imagen = "esqueletoCorruptoFase2.png" })
    } else {
      imagen = "esqueletoCorruptoDañadoFase1.png"
      game.schedule(900, { imagen = "esqueletoCorrupto.png" })
    }
  }
  
  method serDañado() {
    picosCorruptosEnNivel -= 1
    
    if (picosCorruptosEnNivel == 0) {
      imagen = "esqueletoCorruptoDañadoFase2.png"
      game.say(self, "Esto no va a quedar asi...")
      game.schedule(1500, { game.removeVisual(self) })
      nivelManager.derrotarEsqueletoCorrupto()
    } else {
      self.invocarMurcielagos()
      self.debilitarse()
      game.say(self, "Ah si? ahora vas a ver!")
    }
  }

  method reiniciarEstado(){
    imagen = "esqueletoCorrupto.png"
    picosCorruptosEnNivel = 3
  }
}