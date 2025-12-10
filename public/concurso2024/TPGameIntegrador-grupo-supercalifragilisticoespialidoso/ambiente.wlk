import wollok.game.*

object piso {
  var property position = game.at(-5, 0)
  method image() = "base.png"

  method avanzar() {
    if (position.x() <= -1){
      position = position.right(1)
    }else{
      position = position.left(4)
    }
  }
  method detener() {
    position = game.at(-5, 0)
  }
}

object fondo{
  method image() = "background-day.png"
}