import enemigo.*
import config.*
import tablero.*
class Entidad{
  var vida
  method cumplirObjetivoInicial()

  //indicador de vida

  method text() = vida.stringValue()

  method recibirDanio(cantDanio){
    vida -= cantDanio
    if(vida <= 0){
      self.morir()
    }
  }

  method morir(){
    tablero.borrarEntidad(self)
    const sonidoMuerte = game.sound("sonido-muerte.mp3")
    sonidoMuerte.volume(0.3)
    sonidoMuerte.play()
  }
  method cambiarDeEquipo(){}
}

class Personaje inherits Entidad{
  const danio
  var equipo
  var position

  method equipo() = equipo
  method position() = position
  method textColor() = equipo.color()
  method costo()

  override method cambiarDeEquipo(){
    equipo = equipo.contrario()
  }

  override method cumplirObjetivoInicial(){
    self.irATorreMasCercana()
  }

  method irATorreMasCercana(){
    game.onTick(1000, "comportamiento", {self.moveteHaciaTorreEnemigaMasCercanaSiHay()})
  }

  method irA(unaPosicion){
    game.onTick(1000, "comportamiento", {self.moveteHacia(unaPosicion)})
  }

  method moveteHaciaTorreEnemigaMasCercanaSiHay(){
    if(vida > 0 and not tablero.torres(equipo.contrario()).isEmpty()){
      self.moveteHacia(tablero.posicionTorreEnemigaMasCercanaA(self))
    }
  }

  method moveteHacia(unaPosicion){
    const proximaPosicion =  self.proximaPosicionHacia(unaPosicion)
    if(position != proximaPosicion and (tablero.hayAlgoAlrededor(self.position(), self) or tablero.hayAlgoEn(proximaPosicion))){
      const objetivos = tablero.enemigosAlRededor(self.position(), self)
      objetivos.forEach({
        objetivo => self.atacar(objetivo)
      })
    }
    else{
      position = proximaPosicion
    }
  }

  method proximaPosicionHacia(unaPosicion){
    if (position.x() < unaPosicion.x())
      return position.right(1)
    else if (position.x() > unaPosicion.x())
      return position.left(1)
    else if (position.y() < unaPosicion.y())
      return position.up(1)
    else if (position.y() > unaPosicion.y())
      return position.down(1)
    else
      return position
  }


  method atacar(unPersonaje){
      unPersonaje.recibirDanio(danio)
      const sonidoAtaque = game.sound("espadazo.mp3")
      sonidoAtaque.play()
  }

}

class Monje inherits Personaje(vida = 50, danio = 2){
  //puede cambiar de bando a otros, sanar alrededor
  // el equipo es "Rojo" o "Azul"

  method tipo() = "Unidad"
  method image() = "monje"+ equipo.name() +".png"
  method nombre() = "monje"

  override method irATorreMasCercana(){
    game.onTick(3000, "comportamiento", {self.moveteHaciaTorreEnemigaMasCercanaSiHay()})
  }

  override method costo()= 3

  override method atacar(unPersonaje){
    unPersonaje.cambiarDeEquipo()
    unPersonaje.image()
    const sonidoAtaque = game.sound("wololo.mp3")
    sonidoAtaque.volume(0.3)
    sonidoAtaque.play()
  }
}

class Infanteria inherits Personaje(vida = 50, danio = 10){
  method tipo() = "Unidad"
  method image() = "infanteria"+ equipo.name() +".png"
  method nombre() = "Infantería"
  override method atacar(unPersonaje){
      unPersonaje.recibirDanio(danio)
      const sonidoAtaque = game.sound("espadazo.mp3")
      sonidoAtaque.play()
  }
  override method costo()= 2
}



class Arquero inherits Personaje(vida = 20, danio = 8){
  const property rango = 3 // Rango de ataque del arquero

  method tipo() = "Unidad"
  method image() = "arquero" + equipo.name() + ".png"
  method nombre() = "Arquero"

  // Método para atacar considerando el rango
  override method atacar(unPersonaje){
    if (self.estaEnRango(unPersonaje.position())) { // Verifica si está dentro del rango
      unPersonaje.recibirDanio(danio) // Inflige daño
      const sonidoAtaque = game.sound("flechazo.mp3")
      sonidoAtaque.volume(0.3)
      sonidoAtaque.play()
    }
  }

  // Verifica si una posición está dentro del rango del arquero
  method estaEnRango(unaPosicion) =
    position.distance(unaPosicion) <= rango

  // Movimiento hacia la torre más cercana o ataques a distancia
  
  override method moveteHaciaTorreEnemigaMasCercanaSiHay(){
    if (vida > 0 and not tablero.torres(equipo.contrario()).isEmpty()) {
      const torreEnemiga = tablero.torreMasCercanaA(position, equipo.contrario())
      if (self.estaEnRango(torreEnemiga.position())) {
        self.atacar(torreEnemiga)
      } else {
        self.moveteHacia(torreEnemiga.position())
      }
    }
  }

  override method costo()= 5

}

object equipoRojo {
  method name()= "Rojo"
  method contrario() = equipoAzul
  method color() = paleta.rojo()
}

object equipoAzul{
  method name()= "Azul"
  method contrario() = equipoRojo
  method color() = paleta.verde()
}

class Torre inherits Entidad(vida = 200){
  const danio = 15
  const position
  const equipo

  method equipo() = equipo
  method position() = position
  method textColor() = equipo.color()
  method tipo() = "Torre"
  method image() = "castillo"+equipo.name()+".png"

  override method cumplirObjetivoInicial(){
    game.onTick(1000, "comportamiento", {self.atacarAlRededor()})
  }
  
  var trompetaTocada = false

  method atacarAlRededor(){
    if (vida > 0) {
      const objetivos = tablero.enemigosAlRededor(self.position(), self)
      if (objetivos.size() >= 1) {
        objetivos.forEach({
          objetivo => self.atacar(objetivo)
        })
        if(!trompetaTocada) {
          const sonidoAtaque = game.sound("trompeta.mp3")
          sonidoAtaque.volume(0.5)
          sonidoAtaque.play()
          trompetaTocada = true
          game.schedule(5000, {trompetaTocada = false})
        }
      }
    }
  }

  override method morir(){
    tablero.borrarEntidad(self)
    const sonidoDestruccion = game.sound("sonido-destruccion.mp3")
    sonidoDestruccion.volume(0.3)
    sonidoDestruccion.play()

    if(self.esLaUltimaTorre()){
      if(equipo.name() == 'Rojo'){
        juego.ganar()
      }
      if(equipo.name() == 'Azul'){
        juego.perder()
      }
      juego.partidaTerminada(true)
    }
  }
  method esLaUltimaTorre() = tablero.torres(equipo).isEmpty()

  method atacar(unPersonaje){
    unPersonaje.recibirDanio(danio)
  }
}