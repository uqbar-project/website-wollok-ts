import _08dementores.*
import _07harry.*
import _06sonidos.*
import _03niveles.*


object visuales {
    const dementor4 = new DementorFijo(position = game.at(2,2), puntoA = game.at(2,2), puntoB = game.at(8, 6), objeto = null)
    const dementor1 = new Dementor(position = game.at(5,9), objeto = null )
    const dementor2 = new Dementor(position = game.at(10,5), objeto = null)
    const dementor3 = new Dementor(position = game.at(18,5), objeto = null)
    const dementorConCopa = new Dementor(position = game.at(12,8), objeto = llave)
    const vidasVisuales = [vida1, vida2, vida3]

    const fragmento1 = new InvitacionHogwarts(image = "InvitacionHW1-rbg.png" , position = game.at(1, 10))
    const fragmento2 = new InvitacionHogwarts(image = "InvitacionHW2-rbg.png", position = game.at(9, 2))
    const property enemigos = [dementor1, dementor2, dementor3, dementor4, dementorConCopa]

    const property fragmentos = [fragmento1, fragmento2]
    
  method cantidadDeFragmentos() = fragmentos.size()

   method agregarDementores() {
      enemigos.forEach({d=>d.reiniciar()})
      enemigos.forEach({d => game.addVisual(d)})
    }
    
    
    method agregarFragmentos() {
      fragmentos.forEach({f => game.addVisual(f)})    
    }
    method agregarVidas(){
      vidasVisuales.take(harry.vida()).forEach({v => game.addVisual(v)})
    }
  
}


object hogwarts {
  var property image = "hogwarts.png"
  var property position = game.at(15,8)
  method perderVida(){}
  method colisionarConHarry(){harry.irAHogwarts()}

  
}
class Vida {
  const property image = "prueba_rayo_vida.png"
  method position()//metodo abstracto
  method remove(){
    game.removeVisual(self)
  }



	method serEncontrada(){}
	method perderVida(){}
	method colisionarConHarry() {}
  method colisionarConHechizo() {}

}

object vida3 inherits Vida{
  var property position = game.at(17, 11)
  override method position() = position
  
}
object vida2 inherits Vida{
  var property position = game.at(16, 11)
  override method position() = position

}
object vida1 inherits Vida{
  var property position = game.at(15, 11)
  override method position() = position

}

class InvitacionHogwarts{
  const property image 
  var property position
  method perderVida(){}
  method colisionarConHarry(){
    game.removeVisual(self)
    harry.encontrarFragmento(self)
  } 

}

object llave{
  var property image = "llaveHogwarts.png"
  var property position = game.center()
  method perderVida(){}
  method colisionarConHarry(){
    game.removeVisual(self)

    game.say(harry, "¡Ya tengo la llave, ahora puedo entrar en Hogwarts!")
    game.addVisual(puertaHogwarts)
    game.removeVisual(harry)
    game.addVisual(harry)
    game.say(hogwarts, "Tienes la llave, puedes pasar!")

  }
}

object puertaHogwarts{
  var property image = "puertaHogwartsAbierta.jpg"
  var property position = game.at(6,7.5)
  method perderVida(){}
  method colisionarConHarry(){harry.entrarAHogwarts()} 
}
object hermione{
  const property image = "hermioneFrente.png" 
  const property position = game.at(1,5)
  var property activo = true

  method colisionarConHarry(){
   if (self.activo()){
    game.say(self, "Vamos Harry,te espero en clase!")
    game.schedule(3000,{game.removeVisual(self)})
    activo = false
   }
  }
method reiniciar() { activo = true }



}

object ron{
  const property image = "RonFrente2.png" 
  const property position = game.at(16,5)

  var property activo = true

  method colisionarConHarry(){
   if (self.activo()){
    game.say(self, "Vamos tarde a clases, Hermione nos matara, Vamos!")
    game.schedule(3000,{game.removeVisual(self)})
    activo = false
    nivel3.pasarDeNivel()
   }
  }
method reiniciar() { activo = true }




}