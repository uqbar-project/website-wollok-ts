object celdasOcupadas {
  var property posiciones = []
  
  method ocupar(posicion) {
    posiciones.add(posicion)
  }
  
  method desocupar(posicion) {
    posiciones.remove(posicion)
  }
  
  method estaOcupada(posicion) = posiciones.contains(posicion)
}

class BloqueInvisible {
  var property position
}