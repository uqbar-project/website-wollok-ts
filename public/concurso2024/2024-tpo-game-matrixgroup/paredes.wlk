import utiles.celdasOcupadas

class Pared {
  var property position

  method initialize() {
    celdasOcupadas.ocupar(position)
  }
  
  method dibujar() {
    game.addVisual(self)
  }
  
  method image() = "pared.png"
}

class ParedInvertida inherits Pared {
  override method image() = "pared_invertida2.png"
}

object pared {
  var property position = game.origin()

  method initialize() {
    (0 .. 3).forEach(
      { n => new Pared(position = new Position(x = 11, y = n))
      .dibujar()}
    )

    (0 .. 8).forEach(
      { n => new ParedInvertida(
          position = new Position(x = 11 + n, y = 5)
        ).dibujar() }
    )
  }
}