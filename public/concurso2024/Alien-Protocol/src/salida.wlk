import src.mapas.*
import src.elementos.*
import Personajes.personaje.*
class Lado{
  var property rango = [1,2,3,4,7,8,9,10]
  method posiciones()
  
}
object ladoIzquierdo inherits Lado{
  override method posiciones() = [game.at(0,6),game.at(0,5)]
  //var property imgs=[]
  method renderizar(productor){
    productor.renderizarVertical(0,paredIzq,self.rango()) //se renderiza paredes que ya pertenecen a una
  }
  
}

object ladoDerecho inherits Lado{
  override method posiciones() = [game.at(11,6), game.at(11,5)]
  //var property imgs=[]
  method renderizar(productor){
    productor.renderizarVertical(11,paredDer,self.rango())
  }
}

object ladoArriba inherits Lado{
  //var property imgs=[]
  override method posiciones() = [game.at(5,11), game.at(6,11)]
  method renderizar(productor){
    productor.renderizarHorizontal(11,paredSuperior,self.rango())
  }
}

object ladoAbajo inherits Lado{
  //var property imgs=[]
  override method posiciones() = [game.at(5,0), game.at(6,0)]
  method renderizar(productor){
    productor.renderizarHorizontal(0,paredInferior,self.rango())
  }
}


object imgSalida{
  var property comun = new Dictionary()
  var property emergencia = new Dictionary()
  var property final = new Dictionary()
  
  method deComun(){
    comun.put(ladoIzquierdo, ["salidaIzq1.png", "salidaIzq2.png"])
    comun.put(ladoDerecho,  ["salidaDer1.png", "salidaDer2.png"])
    comun.put(ladoArriba,   ["salidaArriba1.png", "salidaArriba2.png"])
    comun.put(ladoAbajo,    ["salidaAbajo1.png", "salidaAbajo2.png"])
    return comun
  }
  method deEmergencia(){
    emergencia.put(ladoIzquierdo, ["salidaEIzq1.png", "salidaEIzq2.png"])
    emergencia.put(ladoDerecho,  ["salidaEDer1.png", "salidaEDer2.png"])
    emergencia.put(ladoArriba,   ["salidaEArriba1.png", "salidaEArriba2.png"])
    emergencia.put(ladoAbajo,    ["salidaEAbajo1.png", "salidaEAbajo2.png"])
    return emergencia
  }
  
  method deFinal(){
    final.put(ladoIzquierdo, ["salidaFIzq1.png", "salidaFIzq2.png"])
    final.put(ladoDerecho,  ["salidaFDer1.png", "salidaFDer2.png"])
    final.put(ladoArriba,   ["salidaFArriba1.png", "salidaFArriba2.png"])
    final.put(ladoAbajo,    ["salidaFAbajo1.png", "salidaFAbajo2.png"])
    return final
  }
}

class Salida inherits Obstaculo{

  override method esSalida() = true
  var property lado=null
  var property imgs=[]
  var property destino=null
  var property ubicacion
  override method esObstaculo() = false 

  method renderizar(productor){
    lado.renderizar(productor)
  }
  method cambiarHabitacion(){
    //console.println("accediendo sector2")
    if(destino!=null){
      //console.println(destino)
      destino.cargar()
      personaje.position(ubicacion)
    }
    
  }
  method analizarCambioSector(){
    game.onCollideDo(personaje,{otro=>
            if(otro==self){
              self.cambiarHabitacion()
            }
            
    })
  }
}

