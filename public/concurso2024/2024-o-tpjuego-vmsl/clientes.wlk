import mozo.*
import wollok.game.*
import platos.*
import mueblesMapa.*
import vidasYpuntos.*
import dialogos.*

// Añadir diferentes clientes ej especial, etc
const clientes = [
  "cliente1uno.png",
  "cliente2dos.png",
  "cliente3tres.png",
  "cliente4cuatro.png"
]



//1 es ya era hora
class Cliente {
  var property id = 0.randomUpTo(200000000).truncate(0)
  var property position = game.at(0, 0)
  var property paciencia = 35000.randomUpTo(45000).truncate(0)
  //agrego esto para probar metodos de agarrar y entregar
  var property plato = pasta
  // Estados:
  // 0 -> Esperando a ser atendido
  // 1 -> Esperando plato de comida
  // 2 -> Comiendo
  var property estado = 0
  const property image = clientes.anyOne()
  var property emocion = null
  
  method posicionDialogoX() = self.position().x() + 1
  
  method posicionDialogoY() = self.position().y() + 2
  
  method sentarseEnMesa(mesa) {
    position = game.at(mesa.position().x(), mesa.position().y() + 1)
    mesa.ocuparMesa(self)
  }

  method multiplicador() = 1
  
  method comer() {
    
  }
  
  method agradecer() {
    const dialogo = new Dialogo(
      position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
      duration = 1000,
      image = "mensajeGracias.png" 
    )
    dialogo.mostrar()
  }
}


class ClienteEspecial inherits Cliente (
  id = 0.randomUpTo(200000000).truncate(0),
  image = "clienteSpe.png",
  paciencia = 15000,
  plato = pasta,
  estado = 0
) {
  /*
  override method sentarseEnMesa(_) 
    position = game.at(mesa3.position().x(), mesa3.position().y() + 1)
    mesa3.ocuparMesa(self)
  }*/
  
  override method comer() {
    if (vida.vidas().size() < 3) {
      const posicionVidaTop = vida.vidas().get(0).position()
      const nuevaVida = new Estrella(
        position = game.at(posicionVidaTop.x() + 1, 14)
      )
      vida.vidas().add(nuevaVida) //mozo.vidas(mozo.vidas().reverse())
      
      game.addVisual(nuevaVida)
    }
    spawnerClientes.comenzar()
    return
  }
  
  override method agradecer() {
        const dialogo = new Dialogo(
      position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
      duration = 1000,
      image = "mensajeMuchasGracias.png"
    )
    dialogo.mostrar()
  }
}

class ClienteEstricto inherits Cliente (
  id = 0.randomUpTo(200000000).truncate(0),
  image = "clienteEstr.png",
  paciencia = 15000,
  plato = pasta,
  estado = 0
) {
  /*
  override method sentarseEnMesa(_) {
    position = game.at(mesa1.position().x(), mesa1.position().y() + 1)
    mesa1.ocuparMesa(self)
  }*/
  
  override method agradecer() {
    const dialogo = new Dialogo(
      position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
      duration = 1000,
      image = "mensajeYaEraHora.png"
    )
    dialogo.mostrar()
  }

  override method multiplicador() = 10
}

object spawnerClientes {
  method pacienciaHandler(cliente, mesa, estado) {
    if (estado !== 0) game.removeTickEvent(
        "pacienciaCliente/" + (estado - 1) + "/" + cliente.id()
      )
    
    const dialogo = new Dialogo(
      position = game.at(
        cliente.position().x() + 0.5,
        cliente.position().y() + 2.5
      ),
      duration = (cliente.paciencia() / 3).truncate(0),
      image = if (estado == 0) {
        "feliz1.png"
      } else {
        if (estado == 1) "esperando1.png" else "enojado1.png"
      }
    )
    cliente.emocion(dialogo)
    dialogo.mostrar()
    game.onTick(
      (cliente.paciencia() / 3).truncate(0),
      (("pacienciaCliente/" + cliente.estado()) + "/") + cliente.id(),
      { if (estado == 4) {
          mesa.desocuparMesa()
          vida.perderVida()
          dialogo.eliminar()
          game.removeVisual(cliente)
        } else {
          self.pacienciaHandler(cliente, mesa, estado + 1)
        } }
    )
  }
  
  method comenzar() {
    /* Spawn de clientes en la posicion de la mesa si es que hay disponibles */
    game.onTick(
      5000,
      "spawnClientes",
      { 
        const mesasDisponibles = mesas.filter(
          { mesa => not mesa.estaOcupada() }
        )
        if (mesasDisponibles.size() !== 0) {
          const mesa = mesasDisponibles.head()
          const cliente = new Cliente()
          cliente.sentarseEnMesa(mesa)
          // Crea un objeto nuevo de cliente y le asigna una mesa de las disponibles           
          
          game.addVisual(cliente)
          // Este onTick se encarga de eliminar al cliente y desocupar la mesa cuando se le acaba la paciencia    
  
          self.pacienciaHandler(cliente, mesa, 0)
        }
      }
    )
  }
}