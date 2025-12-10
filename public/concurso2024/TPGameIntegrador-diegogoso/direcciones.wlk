
//limites del tablero
const limiteMaximo = 15
const limiteMinimo = 0
object norte {
  method nombre() = "norte"
  method mover(personaje) {
    if(personaje.position().y() < limiteMaximo) {
      personaje.position(personaje.position().up(1))
    }
  }
  method estaChocandoBorde(personaje) {
    return personaje.position().y() == limiteMaximo 
  }
}

object sur {
  method nombre() = "sur"
  method mover(personaje) {
    if(personaje.position().y() > limiteMinimo) {
      personaje.position(personaje.position().down(1))
    }
  }
  
  method estaChocandoBorde(personaje) {
    return personaje.position().y() == limiteMinimo
  }
}

object este {
  method nombre() = "este"
  method mover(personaje) {
    if(personaje.position().x() < limiteMaximo) {
      personaje.position(personaje.position().right(1))
    }
  }

  method estaChocandoBorde(personaje) {
    return personaje.position().x() == limiteMaximo
  }
}

object oeste {
  method nombre() = "oeste"
  method mover(personaje) {
    if(personaje.position().x() > limiteMinimo) {
      personaje.position(personaje.position().left(1))
    }
  }

  method estaChocandoBorde(personaje) {
    return personaje.position().x() == limiteMinimo
  }
}

const limiteMaximo2 = 14
const limiteMinimo2 = 1
object norte2 {
  method nombre() = "norte"
  method mover(personaje) {
    if(personaje.position().y() < limiteMaximo2) {
      personaje.position(personaje.position().up(1))
    }
  }
  method estaChocandoBorde(personaje) {
    return personaje.position().y() == limiteMaximo2 
  }
}

object sur2 {
  method nombre() = "sur"
  method mover(personaje) {
    if(personaje.position().y() > limiteMinimo2) {
      personaje.position(personaje.position().down(1))
    }
  }
  
  method estaChocandoBorde(personaje) {
    return personaje.position().y() == limiteMinimo2
  }
}

object este2 {
  method nombre() = "este"
  method mover(personaje) {
    if(personaje.position().x() < limiteMaximo2) {
      personaje.position(personaje.position().right(1))
    }
  }

  method estaChocandoBorde(personaje) {
    return personaje.position().x() == limiteMaximo2
  }
}

object oeste2 {
  method nombre() = "oeste"
  method mover(personaje) {
    if(personaje.position().x() > limiteMinimo2) {
      personaje.position(personaje.position().left(1))
    }
  }

  method estaChocandoBorde(personaje) {
    return personaje.position().x() == limiteMinimo2
  }
}