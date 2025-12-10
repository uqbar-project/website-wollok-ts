import pantalla.*
import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*

class Torre{
  var nivelTorre
  const rango
  var torreActiva =true
  ///const costo
  const daño
  var assetActual
  const assetNormal
  const assetMejora
  const audioConstruccion="hammer.mp3"
  const positionOpcion // direccion en la cual es  reflagada en el menu , esto para poder saber donde esta en el menu -> solo lo conoce la torre . 
  const property  position 
  method reporducirAudioConstruir() {
    game.sound(audioConstruccion).play()
  }
  method subirNivel(){
    nivelTorre = nivelTorre + 1
  }
  method posicionDeOpcion() =positionOpcion 
  method costoDeMejora()
  method cursor() ="cursorTorre.png" 

    method rangoEfectivo() {
    return  [
        position.up(rango),position.down(rango),position.left(rango),position.right(rango), arriba.siguientePosicion(position.up(rango)),
        abajo.siguientePosicion(position.down(rango)),
        izquierda.siguientePosicion(position.left(rango)),
        derecha.siguientePosicion(position.right(rango)),
        izquierda.diagonalInferior(position),
        izquierda.diagonalSuperior(position),
        derecha.diagonalInferior(position),
        derecha.diagonalSuperior(position)
        ]
  }
  method reproducirAudioMejora(){
    game.sound("upgradeTorre.mp3").play()
  }
  method animar(){
            const upgradeParteUno = new Pantalla(imagen="upgradeTorre -1.png",position=position)
            const upgradeParteDos=new Pantalla(imagen="upgradeTorre -2.png",position=position)
            upgradeParteUno.iniciarSiNoEliminar()
            self.reproducirAudioMejora()
            game.schedule(200,{upgradeParteUno.iniciarSiNoEliminar() upgradeParteDos.iniciarSiNoEliminar()
            game.schedule(200, {upgradeParteDos.iniciarSiNoEliminar()})
            })
  }
  method mejorar(unPersonaje){ // esto lo usa torre opciones.
    if (unPersonaje.monedas()>=self.costoDeMejora()) {   
            self.animar()
            self.subirNivel()
            self.cambiarAsset() 
            unPersonaje.gastarMonedas(self.costoDeMejora()) 
    }
  }
  method cambiarAsset(){
    if(assetActual != assetMejora){
      assetActual=assetMejora
    }
  }
  method atacarSiEstaEnRango(unEnemigo) {

    if(torreActiva  and unEnemigo.estaVivo() and self.rangoEfectivo().contains(unEnemigo.post()))
        game.schedule(105, {unEnemigo.recibirDaño(self.atacar())})
  }
  method eliminar() {
    torreActiva=false
    game.removeVisual(self)

  }
  method image()
  method atacar() = daño + nivelTorre
  method costo()

}

class TorreNormal inherits Torre(assetActual="torre1.png",assetNormal="torre1.png",assetMejora="torre1Up.png"){

  override method costo() = 3
  override method image() = assetActual
  override method costoDeMejora() =2
  //override method atacar() = super() + self.costo()
}

class TorreCañon inherits Torre(assetActual="torre2.png", assetNormal="torre2.png",assetMejora="torre2Up.png"){
  override method costo() = 5
  override method image() = assetActual
  //override method atacar() = super() + self.costo()
  override method costoDeMejora() =3
}

class TorreTesla inherits Torre(assetActual="torre3.png",assetNormal="torre3.png",assetMejora="torre3Up.png"){
  override method costo() = 10
  override method image() = assetActual
  override method costoDeMejora() = 5
  //override method atacar() = super() + self.costo()
}


object torresOpciones {
  //listar torres posibles que se pueden elegir 
    const opciones=[[1,3],[1,4],[1,5],[1,6],[1,0]] //1,3 -> torre flecha // 1,4 -> torre cañon // 1,5 -> torre tesla // 1,6 -> eliminarTorre
    const torres=[]
    const torresExistentes=[]
    method image() ="cursor.png"
    var property position = game.at(1, 3) 
    method torres() =torresExistentes 
    method posicionActualComoColeccion() =[position.x(),position.y()] // "como coleccion" refiere a  la posicion que refleja dentro del menu, y esta la mete en una coleccion para luego comparar.
    
    method torreExistenteBuscada(unaPostion) = torresExistentes.find({ t=>t.position() ==unaPostion  }) //metodo el cual usa unicamente eliminar torre.
    method esPosibleEliminar()  =  opciones.get(3) == self.posicionActualComoColeccion()       //revisa si la posicion es correcta para eliminar.    
    method esPosibleMejorar()=opciones.get(4) == self.posicionActualComoColeccion()//revisa si la posicion es correcta para mejorar. 
    method mejorarTorre(unaPostion,unPersonaje) {
      self.torreExistenteBuscada(unaPostion).mejorar(unPersonaje) // mejora la torre dentro de la lista.             
    }
    method eliminarTorre(unaPostion) {
      if(self.esPosibleEliminar()){ //elimina la torre si es posible
        self.torreExistenteBuscada(unaPostion).eliminar() // elimina la torre dentro de la lista. 
        torresExistentes.remove(self.torreExistenteBuscada(unaPostion))   //remueve la torre existente dentro de la lista de torres existentes
      }                  
    }

    method torreBuscada() =torres.find({t=> t.posicionDeOpcion() == self.posicionActualComoColeccion()}) // para repeticion                                                                                             
    
    method torreSeleccionada(x, y) { // X, Y -> porque el game.at necesita dos numeros. no una posicion entera.

    torres.clear() // sirve para poder comparar las 3 torres creadas, ya con la posicion pasada por parametro, y esta sea comparada por ->  torreBuscada() 
    const normal = new TorreNormal(
        nivelTorre = 1,
        daño = 3,
        rango = 2,
        position = game.at(x, y),
        positionOpcion = opciones.get(0)
    )
    torres.add(normal)

    const canon = new TorreCañon(
        nivelTorre = 2,
        daño = 5,
        rango = 1,
        position = game.at(x, y),
        positionOpcion = opciones.get(1)
    )
    torres.add(canon)

    const tesla = new TorreTesla(
        nivelTorre = 3,
        daño = 18,
        rango = 1,
        position = game.at(x, y),
        positionOpcion = opciones.get(2)
    )
    torres.add(tesla)
    return self.torreBuscada()
} 
    method elegirTorre(){ //metodo el cual llama el jugador al poner la torre, si  se evaluo correctamente, se pone el visual de la torre acá.
      self.agregarTorreExistente(self.torreBuscada())
    }
    method agregarTorreExistente(unaTorre) { // agrega la torre dentro de torresOpcioens, esto evita  que en el caso de que se quiera repetir dentro de la lista.
      if(!torresExistentes.any({ t => t.position() == unaTorre.position()}) ){ 
        torresExistentes.add(unaTorre)
        game.addVisual(unaTorre)
      }
    }
    method posicionEliminar() =opciones.get(3)
    method partidaFinalizada() {
      if(torresExistentes.size()>0) torresExistentes.forEach({ t=> t.eliminar()})
      torresExistentes.clear()
    }
 

    //movimientos de las torres, recomiendo dejar aca y no moverlo a controles para que sea mas entendible
    method moverseHaciaArriba() {
        if(self.position().y() >1 and self.position().y() <6 ){
		      self.position(self.position().up(1))
        }
        else{
            position=game.at(1,3)
        }
	  } 
    method moverseHaciaAbajo()  {
        if(self.position().y() >3){
		      self.position(self.position().down(1))
        }
        else{
            position=game.at(1,0)   
        }
	  }
}
