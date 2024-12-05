import wollok.game.*
import puertas.*
import objetos.*
import personaje.*
import textos.*
import tablero.*
import barraItems.*
import musicaSonido.*
import fantasma.*

object ritual {
  var property image = "fondoRitualV2.png" 
  var property position = game.origin()
  var property contador = 0
  var property estavencido = false
  //var property elPerosnajeMurio = false

  const musicaAmviente = salaRitual

  method reproducirMusica() {
    musicaAmviente.sonar()
    musicaAmviente.loop()
  }  

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionRitual)
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 
    
    
    //--secuencia intro

    game.addVisual(dimension)//alparece el agujero
    game.sound("xfxIntoDimension.mp3").play()//se ejecuta sonido
    game.addVisual(personajeEstatico)//imagen personaje estatico 
    
    game.schedule(1000, {=>
      self.reproducirMusica()
      game.removeVisual(dimension)//se elimina visual agujero
      game.addVisual(oscuridad)//se agrega la visual oscuridad
      game.removeVisual(personajeEstatico)
      game.addVisual(personajeEstatico)//imagen personaje estatico
    })

    game.schedule(2700, {=>game.addVisual(frase)})

    game.schedule(4500, {=>
      game.removeVisual(oscuridad)
      game.addVisual(estrellas)
      game.removeVisual(personajeEstatico)
      game.addVisual(personajeEstatico)//imagen personaje estatico 
      
      game.removeVisual(frase)
      game.addVisual(frase)
    })

    game.schedule(6350, {=>game.removeVisual(estrellas)})

    game.schedule(12000, {=>
      game.removeVisual(frase)
      game.addVisual(damage)
    })
    
    game.schedule(12250, {=>
      game.removeVisual(damage)
      game.addVisual(agis)
      agis.animar()
      barraItems.refreshListaDeItems()
      game.removeVisual(personajeEstatico)
      habitacion.ubicarPersonaje(5, 1)
    })
    //------------------------------------------------------ubicacion objetos   
    
    //--Antorchas
    self.agregarAntorchas()

    //--Items

    //Items en Inventario
    //barraItems.refreshListaDeItems()

    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 11)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 11, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 0, 0)//x min Izquierda
    
    //fantasmas
    self.agregarFantasmas()
  }

  method agregarAntorchas() {
    game.schedule(9000, {=>
      habitacion.ubicarEnTablero(antorcha1, 6, 10)
      antorcha1.animar()
    })
    game.schedule(9500, {=>
      habitacion.ubicarEnTablero(antorcha3, 10, 7)
      antorcha3.animar()
    })
    game.schedule(10000, {=>
      habitacion.ubicarEnTablero(antorcha5, 8, 2)
      antorcha5.animar()
    })
    game.schedule(10500, {=>
      habitacion.ubicarEnTablero(antorcha4, 3, 2)
      antorcha4.animar()
    })
    game.schedule(11000, {=>
      habitacion.ubicarEnTablero(antorcha2, 1, 7)
      antorcha2.animar()
    })
  }

  method sumar() {
    contador += 1
  }

  method reiniciar() {
    contador = 0
  }

  method agregarFantasmas() {
    //primeros 5
    self.crearFantasmaSegunTiempo(15000,new FantasmaDiagonal(position = game.at(2,7), velocidad = 400))
    self.crearFantasmaSegunTiempo(18000,new FantasmaDiagonal(position = game.at(9,2), velocidad = 400))
    self.crearFantasmaSegunTiempo(21000,new FantasmaDiagonal(position = game.at(3,2), velocidad = 350))
    self.crearFantasmaSegunTiempo(24000,new FantasmaDiagonal(position = game.at(2,5), velocidad = 350))
    self.crearFantasmaSegunTiempo(27000,new FantasmaDiagonal(position = game.at(9,8), velocidad = 300))
    //segunada tanda
    self.crearFantasmaSegunTiempo(35000,new FantasmaDiagonal(position = game.at(6,1), velocidad = 300))
    self.crearFantasmaSegunTiempo(40000,new FantasmaDiagonal(position = game.at(7,1), velocidad = 250))
    self.crearFantasmaSegunTiempo(45000,new FantasmaDiagonal(position = game.at(8,1), velocidad = 250))
    self.crearFantasmaSegunTiempo(50000,new FantasmaDiagonal(position = game.at(9,1), velocidad = 200))
    self.crearFantasmaSegunTiempo(55000,new FantasmaPerseguidor(position = game.at(10,10), velocidad = 100))
  }

  method crearFantasmaSegunTiempo(unTiempo,unFantasma) {
    game.schedule(unTiempo, {=>
      if(self.sePuedeSeguirCreandoFantasmas())
        game.addVisual(unFantasma)
      else
        game.removeVisual(unFantasma)
    })  
  }
  method sePuedeSeguirCreandoFantasmas() {
    return !estavencido /*|| !personaje.personajeVida == 0*/ //no funciona...
  }
  /*
  method borrarFantasmas() {
      game.onTick(1000, "borrarFantasmasXSeg", {=>
        game.removeVisual(fantasmaDiagonaRitual1)
        game.removeVisual(fantasmaDiagonaRitual2)
        game.removeVisual(fantasmaDiagonaRitual3)
        game.removeVisual(fantasmaDiagonaRitual4)
        game.removeVisual(fantasmaDiagonaRitual5)
        game.removeVisual(fantasmaDiagonaRitual6)
        game.removeVisual(fantasmaDiagonaRitual7)
        game.removeVisual(fantasmaDiagonaRitual8)
        game.removeVisual(fantasmaDiagonaRitual9)
        game.removeVisual(fantasmaPerseguidorRitual1)
      })
      game.schedule(10000, {=> game.removeTickEvent("borrarFantasmasXSeg")})
  }*/

  method aparecerPuerta() {
    if(contador >=5){
      estavencido = true
      game.sound("xfxCurseDestroy.mp3").play()
      habitacion.ubicarEnTablero(puertaATunelSalida, 4, 10) 
      //self.borrarFantasmas()//

      game.removeTickEvent("fantasma")   
      game.removeTickEvent("fantasmaR") 

      game.removeVisual(agis)
      game.addVisual(agisDefeated)
      agisDefeated.animar()
      game.schedule(2500, {=>game.addVisual(fraseDefeated)})
      game.schedule(7000, {=>game.removeVisual(fraseDefeated)})
    }    
  }

}//fin de metodo iniciar

//instancias fantasma
  //const fantasmaDiagonaRitual1 = new FantasmaDiagonal(position = game.at(1,2), velocidad = 400)
  //const fantasmaDiagonaRitual2 = new FantasmaDiagonal(position = game.at(2,1), velocidad = 400)
  //const fantasmaDiagonaRitual3 = new FantasmaDiagonal(position = game.at(3,1), velocidad = 350)
  //const fantasmaDiagonaRitual4 = new FantasmaDiagonal(position = game.at(4,1), velocidad = 350)
  //const fantasmaDiagonaRitual5 = new FantasmaDiagonal(position = game.at(5,1), velocidad = 300)

  //const fantasmaDiagonaRitual6 = new FantasmaDiagonal(position = game.at(6,1), velocidad = 300)
  //const fantasmaDiagonaRitual7 = new FantasmaDiagonal(position = game.at(7,1), velocidad = 250)
  //const fantasmaDiagonaRitual8 = new FantasmaDiagonal(position = game.at(8,1), velocidad = 250)
  //const fantasmaDiagonaRitual9 = new FantasmaDiagonal(position = game.at(9,1), velocidad = 200)
  //const fantasmaPerseguidorRitual1 = new FantasmaPerseguidor(position = game.at(10,10), velocidad = 100)//Per

//------------------------------------------------------------------------------------------------Clase Antrocha
class Antorcha {
  var property image = "torch_1V2.png"
  var property position = game.origin()
  const numeroComparador
  const numeroFinal
  var property contador=1

  method animar() {
    game.onTick(5,"Antorcha",{self.animacion()})
  }

  method animacion() {
    if(contador !=4){
      contador += 1
      image = "torch_"+contador+"V2.png"
    }
    else{
      contador =1
      image = "torch_"+contador+"V2.png"
    }
  }

  method ubicarEn(unaUbicacion) {
    self.position(unaUbicacion)  
  }

  method interaccion() {//utiliza la colicion
    self.destruir(ritual)
  }

  method mostrarMensaje(unMensaje) {
    game.addVisual(unMensaje)//--muestra texto--
    game.schedule(2000, { => game.removeVisual(unMensaje)})
  }

  method destruir(unRitual) {
    if(itemPolvoEstrellas.enInventario()){//si tenes el polvo
        if(self.siEsLaCombinacionCorrecta(unRitual)){//si haces la combinacion correcta
          self.sumar(unRitual)
          if(unRitual.contador()<=4)
            self.mostrarMensaje(textoAntorchaOk)//mensaje OK
          else
            self.mostrarMensaje(textoMaldicionRota)//mensaje MAL
          unRitual.aparecerPuerta()//verifica si se habrio la puerta
        }
        else{//si haces MAL la combinacion
          self.reiniciar(unRitual)
          self.mostrarMensaje(textoAntorchaMal)
        }
    }
    else//si NO tenes el polvo. PERDISTE
      self.mostrarMensaje(textoAntorchaSinPolvo)
  }
  method siEsLaCombinacionCorrecta(unRitual) {
    return unRitual.contador()==numeroComparador || unRitual.contador()==numeroFinal
  }
  
  method sumar(unRitual) {
    unRitual.sumar()
  }
  method reiniciar(unRitual) {
    unRitual.reiniciar()
  }
}

const antorcha1 = new Antorcha(numeroComparador = 0, numeroFinal = 0)
const antorcha2 = new Antorcha(numeroComparador = 1, numeroFinal = 1)
const antorcha3 = new Antorcha(numeroComparador = 2, numeroFinal = 2)
const antorcha4 = new Antorcha(numeroComparador = 3, numeroFinal = 3)
const antorcha5 = new Antorcha(numeroComparador = 4, numeroFinal = 5)

//-------------------------------------------------------------------------------------------Agis
object agis {
  var property image = "AgisF1V2.png"
  const property position = game.at(2, 3)
  var property contador=1
 
  method animar() {
    game.onTick(5,"Agis",{self.animacion()})
  }

  method animacion() {
    if(contador !=15){
      contador += 1
      image = "AgisF"+contador+"V2.png"
    }
    else{
      contador =1
      image = "AgisF"+contador+"V2.png"
    }
  }
}
//--------------------------------------------------------------------------------Agis derrotado
object agisDefeated {
  var property image = "AgisDef1.png"
  const property position = game.at(2, 3)
  var property contador=1
 
  method animar() {
    game.onTick(5,"AgisDef",{self.animacion()})
  }

  method animacion() {
    if(contador !=2){
      contador += 1
      image = "AgisDef"+contador+".png"
    }
    else{
      contador =1
      image = "AgisDef"+contador+".png"
    }
  }
}
//------------------------------------------------------------------------------Frase intro
object frase {
  method position() = game.at(5,7)
  method textColor() = "#ffffff"

  method text() = "     Te he estado esperando...
      Veo que mi pequeño esclavo hizo su trabajo...
      No te enojes con el, solo tome posesión 
      de su ser para atraerte hasta aquí.
      
      Ya no puedes salir de este lugar...

      ¡¡ENTREGAME TU ALMA!! 
      ¡YA NO PUEDES ESCAPÁR DE MI!"
}
object fraseP2 {
  method position() = game.at(5,7)
  method textColor() = "#ffffff"

  method text() = "¡¡ENTREGAME TU ALMA!! 
      ¡YA NO PUEDES ESCAPÁR DE MI!"
}

//-------------------------------------------------------------------------------Frase final
object fraseDefeated {
  method position() = game.at(5,7)
  method textColor() = "#ffffff"

  method text() = "     Nooo!! que has hecho!!
      No puedes irte de aquí!!
      ¡¡¡Te lo pRohiiíbOo00o0o00Ooo0o!!!"
}
//--imagenes--
object dimension {
  const property image = "dimension.png"
  var property position = game.origin()
}
object oscuridad {
  const property image = "fondoOscuridad.png"
  var property position = game.origin()
}
object estrellas {
  const property image = "fondoRitual.png"
  var property position = game.origin()
}
object personajeEstatico {
  const property image = "personajeU1.png"
  var property position = game.at(5,1)
  method interaccion() {  }
}

