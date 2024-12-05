object marco{
  var property position = game.at(0,2)
  // es una variable que le dice al marco si se puede mover
  var property puedeMoverse = true
  method image() = "marco.png"
  method intentarMoverA(unaPosicion){
    //verifica si la posicion pasada por parametro se puede alcanzar y si puede se mueve
    if(self.esPosicionValida(unaPosicion) and puedeMoverse)
    {
      position = unaPosicion
    }
  }
  method esPosicionValida(unaPosicion){
    return unaPosicion.x() >= 0 and unaPosicion.x() < game.width()/2 and
    unaPosicion.y() >= 0 and unaPosicion.y() < game.height()
  }
}
