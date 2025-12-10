import pantallas.*
import juego.*


class Vida{
  const corazon
  var x
  var property image = "Co1.png"
  var property position = game.at(x, 0)


  method vidaPerdida(){
    image = "Co2.png"
  }

  method reinicio(){
    image = "Co1.png"
  } 
}

object barraDeVida{
    const barra = [new Vida(corazon = 1, x =0),new Vida(corazon = 2, x =5),new Vida(corazon = 3, x =10)]
    var cantidad = 3
    var posiciones = 0

    method addVisual(){
      barra.forEach({v => game.addVisual(v)})
    }
    method removeVisual(){
      barra.forEach({v => game.removeVisual(v)})
    }    

    method reiniciar(){
      barra.forEach({c => c.reinicio()})
      posiciones = 0
      cantidad = 3
    }

    method cantidadVidas(){
      return cantidad
    }
    method restarCantidad(){
      barra.get(posiciones).vidaPerdida()
      cantidad -= 1
      posiciones += 1
      self.perder()  
    }
    method aumentarCantidad(){
      if(cantidad < 3){
        cantidad += 1
        posiciones -= 1
        barra.get(posiciones).reinicio()
      }
      
    }       

    method perder(){
      if(cantidad==0){       
        juego.rendirse()
      }  
    }

}

