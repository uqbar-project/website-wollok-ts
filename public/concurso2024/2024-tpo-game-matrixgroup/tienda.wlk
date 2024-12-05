import jugador.*
import escena.*
import constantes.*
import elementos.*
import computadora.*
import empleado.*

class Tienda {
  var property image = "tienda.png"
  var property position = game.at(8, 7)
  
  method llegoCliente() {
    if (self.enTienda()) {
      game.addVisual(dialogoGame)
      game.onTick(5000, "aparecer dialogo", { game.removeVisual(dialogoGame) })
    }
  }
  
  method venderEmpleados() {
    if (dinero.atributo() >= 100) {
      dinero.reducir(100)
      oficina.play("compratienda.mp3")
      computadora.nuevaComputadora(0, 7)
    }
  }
  
  method nuevoEmpleado(posX, posY) {
    const empleadoN = new Empleado(
      position = game.at(posX, posY),
      objetivo = game.at(posX, posY)
    )
    game.addVisual(empleadoN)
    jugador.empleados().add(empleadoN)
  }

  method enTienda() = jugador.position() == entradaTienda.position()
}

const tienda = new Tienda() //Armo en clase por si queremos actualizar la tienda