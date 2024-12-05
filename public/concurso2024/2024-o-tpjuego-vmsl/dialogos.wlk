const dialogos = []
class Dialogo {
  const position
  const duration
  const text = ""
  const image
  
  method position() = position
  
  method text() = text
  
  method image() = image
  
  method mostrar() {
    game.addVisual(self)
    dialogos.add(self)
    //console.println(dialogos)
    game.schedule(duration, { game.removeVisual(self) dialogos.remove(self) })
  }
  
  method eliminar() {
    game.removeVisual(self)
  }
}
