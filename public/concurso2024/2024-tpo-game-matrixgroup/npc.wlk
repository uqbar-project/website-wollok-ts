class NPC {
  var property position = game.origin()
  var property image
  var property frente
  var property atras
  var property izquierda
  var property derecha
  var property objetivo
  
  method llego() = position == objetivo
  
  method moverse() {
    const deltaPosX = objetivo.x() - position.x()
    const deltaPosY = objetivo.y() - position.y()
    
    if (deltaPosX > 0) {
      position = position.right(1)
      image = derecha
      return
    }
    if (deltaPosX < 0) {
      position = position.left(1)
      image = izquierda
      return
    }
    if (deltaPosY > 0) {
      position = position.up(1)
      image = atras
      return
    }
    if (deltaPosY < 0) {
      position = position.down(1)
      image = frente
      return
    }
    
    return
  }
}