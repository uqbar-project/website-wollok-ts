import objetos.*
import personaje.*
import tablero.*
import musicaSonido.*

class Fantasma {
  var orientacion = self.orientacionInicial() //up
  var property position //= game.origin()//posicion inicio
  
  var property velocidad
  var property contadorAnimacion = 1
  var property velocidadDeAnimacion = 25

  method orientacionInicial() {
    var numeroAleatorio = 0.randomUpTo(2).truncate(0)
    if(numeroAleatorio ==1)
      return up
    else 
      return down
  }

  var property image = self.nivelDeGraficos()

  method nivelDeGraficos(){
      if(personaje.graficosAltos())
         return "fantasma" + orientacion.descripcion() + "V2.png"
      else
       return "fantasma3.png"
  }

  method animarGraficos() {
      if(personaje.graficosAltos())
          self.animar()
  }

  method initialize() {
    game.onTick(velocidad,"fantasma",{self.desplazarse()})
    self.animarGraficos()
  }

  method desplazarse() {
    self.avanzar()
    if(self.llego())//si encuentra su borde, gira
       self.girar()
  }

  method avanzar() {
    position = orientacion.adelante(position)// adelante: dir de avance (up)
  }
  method llego() =
      orientacion.enElBorde(position) //enElBorde: cual es el borde -- le doy mi posicion actual
  
  method girar() {
    orientacion = orientacion.siguiente()// siguiente: siguiente movimiento "U D R L"
  }
 
  method interaccion() {
    game.sound("xfxDamage.mp3").play()
    personaje.restarVida()
    barraDeVida.sacarVidas()//--actualiza la cantidad de vidas
    game.addVisual(damage)//--muestra pantalla color rojo--
    game.schedule(250, { => game.removeVisual(damage)})//--elimina la pantalla roja
    game.removeVisual(self)//--elimina el fantasma
    personaje.morir()//--va a la pantalla de gameover
  }

  //--animaciones--------------------------------------------------------
  
  method animar() {
      game.onTick(velocidadDeAnimacion,"fantasmaR",{self.animacion()})
  }

  method animacion() {
    if(contadorAnimacion !=4){
      contadorAnimacion += 1
      image = "ghost"+ orientacion.descripcion() +"V3-F"+contadorAnimacion+".png"
    }
    else{
      contadorAnimacion =1
      image = "ghost"+ orientacion.descripcion() +"V3-F"+contadorAnimacion+".png"
    }
  }

  //ubicacion al aparecer
  method ubicacionRandom() {
    return game.at(2.randomUpTo(9).truncate(0), 2.randomUpTo(9).truncate(0))
  }
}

//-------------------------------------------------------------------------------------------------
class FantasmaDiagonal inherits Fantasma{

  override method avanzar() {
    super()//position = orientacion.adelante(position)
    position = orientacion.siguiente().adelante(position)//cambia a la siguiente orientacion y luego avanza
  }

  override method llego() = super() /* orientacion.enElBorde(position) */or orientacion.siguiente().enElBorde(position)// o el borde de la sig posicion

  override method girar() {
    super()//orientacion = orientacion.siguiente()
    if (orientacion.enElBorde(position)){
      super()//orientacion = orientacion.siguiente()
      super()//orientacion = orientacion.siguiente()
    }
  }
}
class FantasmaDiagonalOpuesto inherits Fantasma{

  override method avanzar() {
    super()//position = orientacion.adelante(position)
    position = orientacion.siguienteOpuesto().adelante(position)//cambia a la siguiente orientacion y luego avanza
  }

  override method llego() = super() /* orientacion.enElBorde(position) */or orientacion.siguienteOpuesto().enElBorde(position)// o el borde de la sig posicion

  override method girar() {
    super()//orientacion = orientacion.siguiente()
    if (orientacion.enElBorde(position)){
      super()//orientacion = orientacion.siguiente()
      super()//orientacion = orientacion.siguiente()
    }
  }
}
class FantasmaPerseguidor inherits Fantasma{
  override method avanzar() {}
  override method llego() = super() /* orientacion.enElBorde(position) */or orientacion.siguiente().enElBorde(position)// o el borde de la sig posicion
  override method girar() {
    super()//orientacion = orientacion.siguiente()
    if (orientacion.enElBorde(position)){
      super()//orientacion = orientacion.siguiente()
      super()//orientacion = orientacion.siguiente()
    }
  }

  override  method nivelDeGraficos(){
    if(personaje.graficosAltos())
      return "ghostPerseguidorV3-F"+contadorAnimacion+".png"
    else
      return "ghostPerseguidorV3-F1.png"
  }

  //override method image() = "fantasma3.png"
  override method desplazarse() {
    self.perseguirA(personaje)
  }

  method perseguirA(unPersonaje) {
    if(unPersonaje.position().x() < self.position().x())
      self.position(self.position().left(1))
    else if(unPersonaje.position().x() > self.position().x())
      self.position(self.position().right(1))
    
    if(unPersonaje.position().y() < self.position().y())
      self.position(self.position().down(1))
    else if(unPersonaje.position().y() > self.position().y())
      self.position(self.position().up(1))
  }

  override method animar() {
      game.onTick(velocidadDeAnimacion,"fantasmaR",{self.animacion()})
  }

  override method animacion() {
    if(contadorAnimacion !=4){
      contadorAnimacion += 1
      image = "ghostPerseguidorV3-F"+contadorAnimacion+".png"
    }
    else{
      contadorAnimacion =1
      image = "ghostPerseguidorV3-F"+contadorAnimacion+".png"
    }
  }
}

//-----------------------------------------------------------------------------------------------

object limitesFantasmas {
  method ubicacionRandom() {
    return game.at(2.randomUpTo(9).truncate(0), 2.randomUpTo(9).truncate(0))
  }
}
object up{
  method descripcion() = "R"//define el sprite
  method siguiente() = right// siguiente movimiento
  method opuesto() = down//no se usaria
  method siguienteOpuesto() = left
  method adelante(position) = position.up(1)//dir de avance
  method enElBorde(position) = position.y() >= topeArriba.position().y()-1 //game.height()-1//cual es el borde
}
object right{
  method descripcion() = "R"
  method siguiente() = down
  method opuesto() = left
  method siguienteOpuesto() = up
  method adelante(position) = position.right(1)
  method enElBorde(position) = position.x() >= topeDer.position().x()-1 //game.width()-1
}
object down{
  method descripcion() = "L"
  method siguiente() = left
  method opuesto() = up
  method siguienteOpuesto() = right
  method adelante(position) = position.down(1)
  method enElBorde(position) = position.y() <= topeAbajo.position().y()+1
}
object left{
  method descripcion() = "L"
  method siguiente() = up
  method opuesto() = right
  method siguienteOpuesto() = down
  method adelante(position) = position.left(1)
  method enElBorde(position) = position.x() <= topeIzq.position().x()+1
}
//instanciacion
  //entrada
  //const fantasmaDiagonaEntrada1 = new FantasmaDiagonal(position = game.at(11,6), velocidad = 700)
  //---------modoDificil
  //const fantasmaDiagonaEntrada2 = new FantasmaDiagonal(position = game.at(11,2), velocidad = 500)
  //-----------------------------------------------------------------------------------------------------------

  //comedor
  //const fantasmaDiagonalComedor1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 900)
  //const fantasmaDiagonalComedor2 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)
  //const fantasmaDiagonalComedor3 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800)
  //---------modoDificil
  //const fantasmaDiagonalComedor4 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)
  //const fantasmaPerseguidorComedor1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)//Per
  //-----------------------------------------------------------------------------------------------------------

  //cocina
  //const fantasmaDiagonalCocina1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 900)
  //const fantasmaDiagonalCocina2 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)
  //const fantasmaDiagonalCocina3 = new FantasmaDiagonalOpuesto(position = limitesFantasmas.ubicacionRandom(), velocidad = 800)//OP
  //---------modoDificil
  //const fantasmaDiagonalCocina4 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)
  //const fantasmaPerseguidorCocina1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)//Per
  //-----------------------------------------------------------------------------------------------------------

  //musica
  //const fantasmaDiagonalMusica1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800)
  //const fantasmaDiagonalMusica2 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 900)
  //const fantasmaDiagonalMusica3 = new FantasmaDiagonalOpuesto(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)//OP
  //---------modoDificil
  //const fantasmaDiagonalMusica4 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)
  //const fantasmaPerseguidorMusica1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)//Per
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  //----------------------------------------------------------------------------------------------------------------------------------------------------------
  //primerPiso
  //const fantasmaDiagonalPrimerPiso1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 600)
  //---------modoDificil
  //const fantasmaPerseguidorPrimerPiso1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 1500)//Per
  //-----------------------------------------------------------------------------------------------------------

  //terraza
  //const fantasmaDiagonalTerraza1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 700)
  //const fantasmaDiagonalTerraza2 = new FantasmaDiagonalOpuesto(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)//OP
  //---------modoDificil
  //const fantasmaDiagonalTerraza3 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 500)
  //-----------------------------------------------------------------------------------------------------------

  //bilbioteca
  //const fantasmaDiagonalBiblio1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800)
  //const fantasmaDiagonalBiblio2 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 900)
  //const fantasmaDiagonalBiblio3 = new FantasmaDiagonalOpuesto(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)//OP
  //---------modoDificil
  //const fantasmaDiagonalBiblio4 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)
  //const fantasmaPerseguidorBiblio1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)//Per
  //-----------------------------------------------------------------------------------------------------------

  //dormitorio
  //const fantasmaDiagonalDormi1 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 800)
  //const fantasmaDiagonalDormi2 = new FantasmaDiagonal(position = limitesFantasmas.ubicacionRandom(), velocidad = 1000)
  //const fantasmaDiagonalDormi3 = new FantasmaDiagonalOpuesto(position = limitesFantasmas.ubicacionRandom(), velocidad = 900)//OP
  //---------modoDificil
  //const fantasmaPerseguidorDormi1 = new FantasmaPerseguidor(position = limitesFantasmas.ubicacionRandom(), velocidad = 2000)//Per
//-----------------------------------------------------------------------------------------------------------