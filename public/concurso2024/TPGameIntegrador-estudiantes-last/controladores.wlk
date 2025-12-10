import interfaz.*

//Super clase de Managers
class MngrSecundario {
  const listaVisuales

  method iniciar() {listaVisuales.forEach({dig=>dig.iniciar()})}

  method desactivar() {listaVisuales.forEach({dig=>dig.desactivar()})  self.reiniciarAtributos()}

  method digitos()

  method ilustrarDigitos() {listaVisuales.forEach({dig=>dig.ilustrar()})}

  method reiniciarAtributos()
}

//Managers
object puntuacionMngr inherits MngrSecundario(listaVisuales = [digitoUnoPunt,digitoDosPunt,digitoTresPunt]){
    var puntos = 0
    var jugadas = 0
    var bonusActivo = false

    override method digitos() = (puntos+1000).toString()

    method sumarPuntos() {
        puntos += self.ganarSegunIntento()
        jugadas += 1
        self.actualizarVisuales()
        bonusActivo = true}

    method restarPuntos() {
        puntos = (puntos - self.perderSegunIntento()).max(0)
        jugadas += 1
        bonusActivo = false
        self.actualizarVisuales()}

    method ganarSegunIntento() = if(bonusActivo) self.puntosObtenidos()*2 else self.puntosObtenidos()
    method puntosObtenidos() = if(jugadas<12) 42 else if(jugadas<22) 30 else 25
    method perderSegunIntento() = if(jugadas<20) 5 else 10
        
    method actualizarVisuales() {self.ilustrarDigitos() turnosMngr.ilustrarDigitos() indicadorBonus.activarSiEncadena()}

    method puntos() = puntos
    method jugadas() = jugadas
    method bonusActivo() = bonusActivo

    override method reiniciarAtributos() {
        puntos = 0
        jugadas = 0
        bonusActivo=false}    
}


object tiempoMngr inherits MngrSecundario(listaVisuales = [digitoUnoTiempo,digitoDosTiempo,digitoTresTiempo]) {
  var segundos = 0
  const tiempo = game.tick(1000,{segundos+=1 listaVisuales.forEach({dig=>dig.ilustrar()})},false)

  override method iniciar() {super() self.contarSegundos()}

  override method desactivar() {super() self.pausar()}
  
  override method digitos() = (segundos+1000).toString()
    
  method contarSegundos() {tiempo.start()}

  method pausar() {tiempo.stop()}

  method tiempoActual() = segundos

  override method reiniciarAtributos() {segundos=0}

}

object turnosMngr inherits MngrSecundario(listaVisuales = [digitoUnoTurno,digitoDosTurno,digitoTresTurno]) {

  override method digitos() = (puntuacionMngr.jugadas()+1000).toString()

  override method reiniciarAtributos() {}
}

//Visuales de números
class NumeroVisual {
  const position
  const index
  var image = "n0.png"

  method ilustrar() {image = "n" + self.traducirDigito() + ".png"}// image = "nX.png"

  method traducirDigito() = puntuacionMngr.digitos().charAt(index)// Devuelve "X"

  method iniciar() {game.addVisual(self)}

  method desactivar() {self.reiniciarAtributos() game.removeVisual(self)}

  method image() = image
  method position() = position

  method reiniciarAtributos()
}

object digitoUnoPunt inherits NumeroVisual(position=game.at(0,0),index=1) {

  override method reiniciarAtributos() {image="n0.png"}
}

object digitoDosPunt inherits NumeroVisual(position=game.at(1,0),index=2) {
  
  override method reiniciarAtributos() {image="n0.png"}
}

object digitoTresPunt inherits NumeroVisual(position=game.at(2,0),index=3) {
  
  override method reiniciarAtributos() {image="n0.png"}
}

object digitoUnoTiempo inherits NumeroVisual(position=game.at(3,0),index=1,image="n0a.png") {

  override method ilustrar() {image = "n" + self.traducirDigito() + "a.png"}

  override method traducirDigito() = tiempoMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0a.png"}
}

object digitoDosTiempo inherits NumeroVisual(position=game.at(3,0),index=2,image="n0b.png") {

  override method ilustrar() {image = "n" + self.traducirDigito() + "b.png"}

  override method traducirDigito() = tiempoMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0b.png"}
}

object digitoTresTiempo inherits NumeroVisual(position=game.at(3,0),index=3,image="n0c.png") {

  override method ilustrar() {image = "n" + self.traducirDigito() + "c.png"}

  override method traducirDigito() = tiempoMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0c.png"}

}

object digitoUnoTurno inherits NumeroVisual(position=game.at(4,0),index=1,image="n0a.png") {
  
  override method ilustrar() {image = "n" + self.traducirDigito() + "a.png"}

  override method traducirDigito() = turnosMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0a.png"}    
}

object digitoDosTurno inherits NumeroVisual(position=game.at(4,0),index=2,image="n0b.png") {
  
  override method ilustrar() {image = "n" + self.traducirDigito() + "b.png"}

  override method traducirDigito() = turnosMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0b.png"}    
}

object digitoTresTurno inherits NumeroVisual(position=game.at(4,0),index=3,image="n0c.png") {
  
  override method ilustrar() {image = "n" + self.traducirDigito() + "c.png"}

  override method traducirDigito() = turnosMngr.digitos().charAt(index)

  override method reiniciarAtributos() {image="n0c.png"}    
}