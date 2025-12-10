import sistema2.*
import objetos2.*
import nivelDos.*
import protagonista.*
import objetos1.*

class Enemigos inherits Visual{
  override method image() = if(vida > 0) "patoLV3-F2.png" else 'patoPequeMuerto.png'
  // override method image() = "patoLV3-F2.png"
  var property daño = 30
  var property vida = 100
  
  method recibirDaño() {
      vida = (vida-50).max(0)
      self.eliminarSiEstaMuerto()

  }

  method eliminarSiEstaMuerto(){
    if(self.estaMuerto()){
      game.schedule(1000, {game.removeVisual(self)})
    }
  }

  override method interactuar() {
    if (carlitos.tieneArma()){
      self.recibirDaño()
      carlitos.recibirDaño(5)
      sistema2.aparecerLlave()
    }else{
      carlitos.recibirDaño(daño)
    }
  }

  method estaMuerto() = vida == 0

  method moverse() {
    const x = 0.randomUpTo(game.width()-2).truncate(0)
    const y = 0.randomUpTo(game.height()-2).truncate(0)
    position = game.at(x,y)
  }

  method activarMovimientoPato() {
    game.onTick(3000,"MoverPato",{self.moverse()})
  }

  method reiniciar() {
    vida = 100
  }
}

class PatoGigante inherits Enemigos {  // para dificultad 2
  // var image = "patoGiganteVivoV2.png"
  
  override method image() = if(vida > 0) "patoGiganteVivoV2.png" else 'patoGiganteMuerto.png'

  override method daño() = 50

  override method recibirDaño() {
     vida = (vida-10).max(0)
     self.condicionDeMuerte()
    }

  override method interactuar(){
    if (carlitos.tieneArma()){
        self.recibirDaño()
        carlitos.recibirDaño(15)
        game.say(self, "¡Auch! me queda solo de vida " + vida.toString())
        sistema2.aparecerLlaveD()
    }else{
        game.say(self, "¡Te destruire maldito!")
        carlitos.recibirDaño(self.daño())
    }
  }
    method condicionDeMuerte() {
      if(self.estaMuerto()){
      position = game.origin()
      game.schedule(3000, {game.removeVisual(self)})
    }}
    
    override method moverse() {   
      const x = 0.randomUpTo(game.width()-3).truncate(0)
      const y = 0.randomUpTo(game.height()-3).truncate(0)
      position = game.at(x,y)
    }

    // method cambiarImage() {
    //   image = "patoGiganteMuerto.png"
    //   position = game.origin()
    //   game.schedule(3000, {game.removeVisual(self)})
    // }

}




