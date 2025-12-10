import wollok.game.*

object menu {
    method image() = "menu-principal.png"
    var property position = game.at(20, 15)
}

object gameOver {
  method image() = "gameover.png"
  var property position = game.at(20, 40)
}


object pantallaDificultad {
  var property position = game.at(20, 15)
  const imagenes = ["menu-dificultades.png", "menu-dificultades-facil.png", "menu-dificultades-medio.png", "menu-dificultades-dificil.png"]
  var indice = 0

  method image() = imagenes.get(indice)

  method actualizarIndice(valor) {
    indice = valor
  }
}

object dificultad {
  var property valor = 20
  var property position = game.at(20, 15)

  method facil() {
    valor = 20
    pantallaDificultad.actualizarIndice(1)
  }

  method medio() {
    valor = 15
    pantallaDificultad.actualizarIndice(2)
  }

  method dificil() {
    valor = 10
    pantallaDificultad.actualizarIndice(3)
  }
}
