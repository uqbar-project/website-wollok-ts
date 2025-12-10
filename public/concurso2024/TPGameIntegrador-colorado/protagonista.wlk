import final.*
import nivelUno.*
import nivelDos.*
import nivelDosDificil.*
import sistema2.*


object carlitos {
  var property position = game.center()
  var tieneArma = false
  var vida = 100
  var tieneLlave = false
  const property inventario = []

  method recogerLLave(){
    tieneLlave = true
  }

  method recoger(algo) {
    inventario.add(algo)
  }

  method vaciarInventario() {
    inventario.clear()
  }

  method inventario() = inventario

  method sacarLLave() {
    tieneLlave = false
  }

  method tieneLlave() = tieneLlave

  method image() = if(vida > 0) "protagonista.png" else 'protagonista_muerto.png'

  method recogerArma() { 
    tieneArma = true
    game.say(self, "Ahora si podre destruir a los enemigos")
  }
  method tieneArma() = tieneArma 

  method recibirDaño(daño) {
    if (!tieneArma){
      game.say(self, "Necesitas tener un arma para matar a los patos")
    }
    vida = (vida-daño).max(0)
    self.condicionDeMuerte()
    game.say(self, vida.toString() + " es tu vida ")
  }

  method recuperarVida(cura) {
    vida = (vida + cura).min(100)
      game.say(self, vida.toString() + " es tu nueva vida")
  }

  method condicionDeMuerte() {
      if(vida == 0){
        game.schedule(1000, {gameOver.iniciar()})
      }
  }

  method move(nuevaPosicion) {
    if (nuevaPosicion.x() >= 1 and nuevaPosicion.x() < 19 and nuevaPosicion.y() >= 1 and nuevaPosicion.y() < 11) {
      self.position(nuevaPosicion)
      }
    }

  method hablar(contenido) {
    game.say(self, contenido)
  } 

  method reiniciar() {
    self.vaciarInventario()
    tieneArma = false
    vida = 100

  }

}
