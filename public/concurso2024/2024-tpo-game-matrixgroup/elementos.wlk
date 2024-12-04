import utiles.celdasOcupadas
import jugador.jugador
import escena.*

object mostradorU {
  var property position = game.at(5, 2)
  
  method image() = "mostrador.png"
  
  method initialize() {
    celdasOcupadas.ocupar(position)
    celdasOcupadas.ocupar(position.right(1))
    celdasOcupadas.ocupar(position.up(1))
    celdasOcupadas.ocupar(position.right(2))
    celdasOcupadas.ocupar(position.right(2).up(1))
  }
}

class BarraProgreso {
  var property position
  var property image
  var property listaAssets
  var property progreso = 0
  var property limite
  
  method initialize() {
    limite = listaAssets.size() - 1
    image = listaAssets.get(progreso)
  }
  
  method finalizo() = progreso == limite
  
  method paciencia() {
    if (self.finalizo()) game.removeVisual(self)
    else game.schedule(
        2000,
        { 
          progreso += 1
          image = listaAssets.get(progreso)
        }
      )
  }
  
  method iniciar() {
    if (game.hasVisual(self)) self.paciencia() else game.addVisual(self)
  }
  
  method reiniciar() {
    progreso = 0
    image = listaAssets.get(progreso)
  }
}

class ModificarAtributo {
  var property atributo = 0
  
  method aumentar(monto) {
    atributo += monto
  }
  
  method reducir(monto) {
    atributo -= monto
  }
}

object vida inherits ModificarAtributo (atributo = 3) {
  var property image = "corazon3.png"
  
  method position() = game.center().right(6).down(5)
  
  override method reducir(monto) {
    atributo -= monto
    if (atributo > 0) {
      image = ("corazon" + atributo) + ".png"
    }
  }
  
  method perder() {
    if (atributo == 0) oficina.cambiarEscena(gameover)
    keyboard.f().onPressDo({ game.stop() })
  }
}

object dinero inherits ModificarAtributo {
  method position() = game.center().right(8).down(5)
  
  method text() = atributo.toString() + " $"
  
  method textColor() = "00FF00FF"
}
// la idea es que a las 24 horas salga un cartel como el de stardew valley, dia finalizado, dinero conseguido

object tiempo inherits ModificarAtributo (atributo = 7) {
  method position() = game.center().right(9).down(5)
  
  method text() = atributo.toString() + ":00hs"
}

class Imagen {
  const property position
  const property image
}

const portadaG = new Imagen(position = game.origin(), image = "inicioG.png")

const dialogoGame = new Imagen(position = game.at(8, 8), image = "dialogoG.png")

const imagenGameover = new Imagen(
  position = game.origin(),
  image = "gameover.png"
)

const dialogoLimite = new Imagen(
  position = game.at(8, 8),
  image = "limitecompra.png"
)

const sofa = new Imagen(position = game.at(15, 2), image = "sofa2.png")

const maquinaExpendedora = new Imagen(
  position = game.at(18, 4),
  image = "maquinaExpendedora.png"
)

const cafetera = new Imagen(position = game.at(16, 2), image = "cafetera.png")

const pingpong = new Imagen(position = game.at(12, 1), image = "pingpong.png")