import utiles.*
import inicio.*
import escena.*
import empleado.*
import tienda.*
import elementos.*
import constantes.*
import jugador.*

class Computadora {
  var property position
  var property image
  var property silla
  
  method initialize() {
    silla = new Silla(position = self.position().down(1))
    game.addVisual(silla)
  }
  
  method nuevaComputadora(posX, posY) {
    if (!oficina.celdasBloqueadas().contains(game.at(posX, posY))) {
      if (posX > 20) {
        game.addVisual(dialogoLimite)
        game.onTick(4000, "Limite", { game.removeVisual(dialogoLimite) })
        dinero.aumentar(100)
        return
      }
      const compu = new Computadora(
        position = game.at(posX, posY),
        image = "computadora.gif"
      )
      
      tienda.nuevoEmpleado(posX, posY - 1)
      game.addVisual(compu)
      oficina.celdasBloqueadas().add(compu.position())
      return
    } else {
      self.nuevaComputadora(posX + 2, posY)
    }
  }
}

object producto {
  var property position = computadora.position().left(1)
  var property flag = true
  
  method image() = "producto.png"
  
  method colocarProducto() {
    if (flag) game.addVisual(self)
    flag = false
  }
  
  method sacarProducto() {
    if (!flag) game.removeVisual(self)
    flag = true
  }
  
  method reiniciarPosicion() {
    position = computadora.position().left(1)
  }
}

class Silla {
  var property position
  
  method image() = "silla.png"
}

const computadora = new Computadora(
  position = game.at(6, 7),
  image = "computadora.gif"
)