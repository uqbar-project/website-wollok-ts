
class Mesa {
  var property image = "mesita.png"
  var property position
  var property estaOcupada = false
  var property clienteSentado = null 
  method ocuparMesa(cliente) {
    estaOcupada = true
    clienteSentado = cliente
  }
  method desocuparMesa() {
    estaOcupada = false
    clienteSentado = null
  }
}

const mesa1 = new Mesa(position = game.at(3,9))
const mesa2 = new Mesa(position = game.at(21,9))
const mesa3 = new Mesa(position = game.at(12,6.6))
const mesa4 = new Mesa(position = game.at(3,3.5))
const mesa5 = new Mesa(position = game.at(21,4))

const mesas = [mesa1, mesa2, mesa3, mesa4, mesa5]
