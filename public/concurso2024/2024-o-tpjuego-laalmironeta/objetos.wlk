import wollok.game.*
import juego.*


/*object entrenador {
  var property position = game.center()
  method position() = position
  method image() = "entrenador2.png"
  const pokemon = pokemonNuestro
  

  
  method iniciarPelea() {
    game.onCollideDo(alf,{elemento => self.consultarPelea()}) 
    game.onCollideDo(lucas,{elemento => self.consultarPelea()}) 
 
  }
  
  method consultarPelea() {

    keyboard.e().onPressDo({juego.pelea()})
    keyboard.q().onPressDo({juego.quitarPelea()})
    game.say(alf,"Si queres pelear conmigo apreta la E")
  }
  


  
}
*/






/*
object pokemonNuestro {
  var property nombre = "Pikachu"
  const tipo = "electrico"
  var property vida = 100
  const poderes = [impactrueno,placaje,mordisco,descanso]
  method image() = "pikachu.png"
  var property position = game.at(2, 10)

  method recibirDanio(poder){
 		vida = 0.max(vida - poder.danioBase())
    }
  method atacarAOtroPokemon(poder,contrincante) {
    if(contrincante.tipo() == "Electrico") contrincante.recibirDanio(poder) else contrincante 
  }

}
*/
// Poderes:
/*
object impactrueno {
  const tipoAtaque = "electrico"
  var property danioBase = 35
}

object mordisco {
  const tipoAtaque = "Siniestro" 
  const danioBase = 15
}

object descanso {
  const tipoAtaque = "normal" 
  const danioBase = 0
}

object lanzallamas {
  const tipoAtaque = "fuego" 
  const danioBase = 35
}

object pistolaDeAgua {
  const tipoAtaque = "agua" 
  const danioBase = 35
}

object placaje {
  const tipoAtaque = "normal" 
  const danioBase = 20
}

object latigoCepa {
  const tipoAtaque = "planta" 
  const danioBase = 35
}
*/
/*object alf {
  const pokemon = pokemonAlf
  method image() = "alf2.png"
  var property position = game.at(4, 23)

   

}

object pokemonAlf {
  var nombre = "wartortle"
  const tipo = "agua"
  var vida = 100
  var poderes =[pistolaDeAgua,placaje,mordisco,descanso]
  method image() = "squirtle.png"
  var property position = game.at(23, 16) 
   
}

object lucas {
  const pokemon = pokemonLucas
  
}

object pokemonLucas {
  var nombre = "charmeleon"
  const tipo = "fuego"
  var vida = 100
  var poderes =[lanzallamas,mordisco,placaje,descanso]

}

object fede {
  const pokemon = pokemonFede
  
}

object pokemonFede {
  var nombre = "treecko"
  const tipo = "planta"
  var vida = 100
  var poderes =[latigoCepa,placaje,mordisco,descanso]

}

*/