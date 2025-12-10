import Personajes.personaje.personaje
object inicio{
  var property esObstaculo=false
  var property position = game.at(0,0)
  var property image = "intro.png"
}

object caja{
    var property position = game.origin()
    var property image = "caja1.png"
}

class Obstaculo{
  var property esSalida=false
    var property position = game.at(0,0)
    var property image=""
    var property esObstaculo=true
    /*method cambioposicion(x,y){
      position = game.at(x,y)
    }*/

    method estaEnCelda(x,y) = position.x() == x and position.y() == y
    /*method estaPresente(posVecinoX,posVecinoY){
        const obstaculos = game.allVisuals().filter({visual=>visual.esObstaculo()})
        return obstaculos.any({obstaculo=>obstaculo.position().x()==posVecinoX&&obstaculo.position().y()==posVecinoY}) //eavluaci+on necesaria para ver si es una celda sin nada o si es de un obstaculo
    }*/
}

object esquinaInfIzq inherits Obstaculo{
  override method image() = "esquina1.png"
  override method position() = game.at(0,0)
}
object esquinaInfDer inherits Obstaculo{
  override method image()= "esquina2.png"
  override method position() = game.at(11,0)
}
object esquinaSupIzq inherits Obstaculo{
  override method image()= "esquina3.png"
  override method position() = game.at(0,11)
}
object esquinaSupDer inherits Obstaculo{
  override method image()= "esquina4.png"
  override method position()= game.at(11,11)
}

object paredSuperior inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredSup.png",position=game.at(1,11))
  }
}
object paredInferior inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredInf.png",position=game.at(1,0))
  }
}
object paredDer inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredDer.png",position = game.at(11,1))
  }
}

object paredIzq inherits Obstaculo{
   method generar(){
    return new Obstaculo(image="paredIzq.png",position=game.at(0,1))
  }
}
class Superviviente{
  var property esObstaculo = false
  var property imagen = "amogus.png"
  method image() = imagen
  method position()= game.at(8, 8)
  method rescate(visualsuperviviente) {
    
    if(self.position().distance(personaje.position())<2){
      imagen="amogusE.png"
      keyboard.e().onPressDo{
        game.schedule(100000, game.removeVisual(visualsuperviviente))
        game.removeTickEvent("rescate")
      }
    }else imagen = "amogus.png"
  }
}