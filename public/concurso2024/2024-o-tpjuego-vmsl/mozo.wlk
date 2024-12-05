import posicionesYdistancias.*
import configuracion.*
import platos.*
import clientes.*
import mueblesMapa.*
import vidasYpuntos.*
import dialogos.*



object mozo {
  var property bandeja = null
  var property position = game.at(1, 3)

  var property clientesAtendidos = 0

  method image() = "imagenMozo.png"
  
  method posicionDialogoX() = self.position().x() + 1
  method posicionDialogoY() = self.position().y() + 2


  method moverse(direccion) {
    if (distancia.dentroDeLimites(direccion)){
      self.position(direccion)
    }
    else { 
      console.println("Movimiento bloqueado")
    } 
   }

  method liberarMesas(mesa) {
    if(mesa.clienteSentado() !== null){
      mesa.clienteSentado().emocion().eliminar() 
      game.removeVisual(mesa.clienteSentado()) 
      mesa.desocuparMesa()
      }
  }

  method clienteEspecial() {
    if(clientesAtendidos % 4 == 0) {
      game.removeTickEvent("spawnClientes")
      //mesas.forEach({mesa => self.liberarMesas(mesa)})
      self.liberarMesas(mesa3)
      const clienteEspecial = new ClienteEspecial()
      game.addVisual(clienteEspecial)
      clienteEspecial.sentarseEnMesa(mesa3)
      spawnerClientes.pacienciaHandler(clienteEspecial, mesa3, 0)
    }
  }

    method clienteEstricto() {
    if(clientesAtendidos % 5 == 0) {
      game.removeTickEvent("spawnClientes")
      //mesas.forEach({mesa => self.liberarMesas(mesa)})
      self.liberarMesas(mesa1)
      const clienteEstricto = new ClienteEstricto()
      game.addVisual(clienteEstricto)
      clienteEstricto.sentarseEnMesa(mesa1)
      spawnerClientes.pacienciaHandler(clienteEstricto, mesa1, 0)
    }
  }

  method mostrarBandeja() {
    if (self.bandeja() !== null) {
      const dialogo = new Dialogo(
        position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
        duration = 1000,
        image = bandeja.imagenDialogo()
      ) // Dura 2 segundos
      dialogo.mostrar()
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.posicionDialogoX(), self.posicionDialogoY()),
        duration = 1000,
        image = "vacioDialogo.png"
      ) // Dura 2 segundos
      dialogo.mostrar()
    }
  }
  
  
  method agarrar() {
    const plato = distancia.platoCercano()
    if (plato !== null) {
      bandeja = plato
      self.mostrarBandeja()
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.position().x() + 1, self.position().y() + 2),
        duration = 1500,
        image = "dialogoBarraLejos.png"
      )
      dialogo.mostrar()
    }
  }
  
  
  method entregarPlato(cliente, mesa) {
    // Chequea si el plato que quiere el cliente es el mismo que el que tenemos en la bandeja
    game.removeTickEvent("pacienciaCliente/" + cliente.estado() + "/" + cliente.id())
    cliente.emocion().eliminar()
    if (cliente.plato() == self.bandeja()) {
      puntaje.sumarPuntos(cliente)
      cliente.estado(2)
      cliente.agradecer()
      console.println("Plato entregado")
      cliente.comer()
      game.schedule(
        1000,
        { 
          game.removeVisual(cliente)
          return mesa.desocuparMesa()
        }
      )
      clientesAtendidos += 1
      self.clienteEspecial()
      self.clienteEstricto()

    } else {
      puntaje.restarPuntos(cliente)
      console.println("Plato equivocado")
    }
    self.bandeja(null)
  }
  
  method tomarPedido(cliente) {
    const platoElegido = comidas.anyOne()
    cliente.estado(1)
    cliente.plato(platoElegido)
    const dialogo = new Dialogo(
      position = game.at(
        cliente.position().x() + 1,
        cliente.position().y() + 2
      ),
      duration = 1500,
      image = platoElegido.imagenDialogo()
    )
    dialogo.mostrar()
  }
  
  method interactuarConCliente() {
    // Chequea que tengamos un cliente cerca
    if (distancia.mesaCercana() !== null) {
      const clienteCercano = distancia.mesaCercana().clienteSentado()
      // El cliente esta esperando que le tomen el pedido
      if (clienteCercano.estado() == 0) {
        self.tomarPedido(clienteCercano)
      } else {
        if ((clienteCercano.estado() == 1) && (self.bandeja() !== null))
          // El cliente esta esperando que le tomen el pedido
          self.entregarPlato(clienteCercano, distancia.mesaCercana())
      }
    } else {
      const dialogo = new Dialogo(
        position = game.at(self.position().x() + 1, self.position().y() + 2),
        duration = 1500,
        image = "dialogoClientesLejo.png"
      )
      dialogo.mostrar()
    }
  }

}