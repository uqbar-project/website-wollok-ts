import juego.*

class Pokemon {
    const property tipoPokemon 
    var property hp 
    const property ataques
    const property imagenPokemon
    var property position   

    method image() = imagenPokemon

    method text() = "La vida es de " + hp

    method ataqueRandom() = ataques.anyOne()

    method esDebil(tipo) = tipoPokemon.esDebilA(tipo)

    method perdio() = self.hp() <= 0 


}


object fuego {
    method esDebilA(tipo) = tipo == agua

}
object agua {
    method esDebilA(tipo) = tipo == planta or tipo == electrico
}

object planta {
    method esDebilA(tipo) = tipo == fuego
  
}

object electrico {

    method esDebilA(tipo) = false
  
}

object normal{

  method esDebilA(tipo) = false
}

object siniestro {
  method esDebilA(tipo) = false
  
}


class Ataque {
    var property tipoAtaque 
    var property poderAtaque
    var property sonidoAtaque

    method play() {
      game.sound(sonidoAtaque).play()
    } 

    method saberMulti(poke) =  if(poke.esDebil(tipoAtaque)) 2 else 1
      
    
    
    method danioReal(poke) = poderAtaque * self.saberMulti(poke)


}

class Entrenador {
    const property pokemonEntrenador  
    const property imagenEntrenador
    var property position  
    method image() = imagenEntrenador
  
}

class Protagonista inherits Entrenador {

    
    method mover() {
      position = game.at(11,1)
    } 

    method dialogos(){
    game.onCollideDo(alf,{elemento => self.consultarAlf()}) 
    game.onCollideDo(lucas,{elemento => self.consultarLucas()}) 
    game.onCollideDo(ivo,{elemento => self.consultarIvo()})
  }

   method pelearConAlf() {
      game.onCollideDo(alf, {elemento => batalla.inicializarPeleaAlf()})
    }



    method pelearConLucas() {
      game.onCollideDo(lucas, {elemento => batalla.inicializarPeleaLucas()})
    }

    method pelearConIvo() {
      game.onCollideDo(ivo, {elemento => batalla.inicializarPeleaIvo()})
    }   



  method consultarAlf() {
    game.say(alf,"Si me queres enfrentar, preparate para conocer la muerte apretando la Z")
  }
  method consultarLucas() {
    game.say(lucas,"Es hora de darte catedra de esto, toca la E si te animas")
  }

  method consultarIvo() {
   game.say(ivo,"Hoy soy el ayudante de la muerte, toca Y")
  }

  
}


object fondoPelea {
  var property position = game.origin()
  method image() = "escenarioFinal2.jpg"
}
object barraMenu {
  var property position = game.at(1,1)
  method image() = "barraAtaquePikachu.png"
}

object pokebola {
 method play() {
   game.sound("sonidoPokebola.mp3").play()
 }




}
object batalla {
    var nosotros = naza 
    var rival = alf
    var property pokemon1 = pikachu
    var property pokemon2 = rival.pokemonEntrenador() 
    var property turnoAtacante = true   
    var property sonido = game.sound("musicaBatalla.mp3")


      method inicializarPeleaLucas() { if(!self.batallaFinalizada())
      keyboard.e().onPressDo({ self.setearLucas() self.pelear()})
      }
      method inicializarPeleaAlf() { if(!self.batallaFinalizada())
      keyboard.z().onPressDo({ self.setearAlf() self.pelear()})
      }
      method inicializarPeleaIvo() { if(!self.batallaFinalizada())
      keyboard.y().onPressDo({ self.setearIvo() self.pelear()})
      }



    method setearLucas(){
      rival = lucas
      nosotros = naza
      pokemon1 = naza.pokemonEntrenador()
      pokemon2 = charmander

    }

    method setearAlf(){
      rival = alf
      nosotros = naza
      pokemon1 = naza.pokemonEntrenador()
      pokemon2 = squirtle
    }

    method setearIvo(){
      rival = ivo
      nosotros = naza
      pokemon1 = naza.pokemonEntrenador()
      pokemon2 = bulbasaur
    }



    method pelear() {
      if(!self.batallaFinalizada())
      game.addVisual(fondoPelea)
      game.addVisual(pokemon2)
      game.addVisual(pokemon1)
      game.addVisual(barraMenu)
      self.elegirAtaque()
      pokebola.play()
      sonido.play()
      sonido.shouldLoop(true)
      }

    


    method quitarPelea() {
      game.removeVisual(fondoPelea)
      game.removeVisual(pokemon2)
      game.removeVisual(pokemon1)
      game.removeVisual(barraMenu)
      sonido.stop()
      naza.mover()
      game.removeVisual(rival)
      pokemon1.hp(320)
      pokemon2.hp(320)
      
    }  
  
    method ataca1(ataque) { if(self.turnoAtacante()) pokemon2.hp(pokemon2.hp() - ataque.danioReal(pokemon2)) ataque.play() 
      
    } 
    



    method ataca2() {
    if(!self.turnoAtacante()) pokemon1.hp(pokemon1.hp() - (pokemon2.ataqueRandom()).poderAtaque()) (pokemon2.ataqueRandom()).play()
    }

   
    
    method alternarTurno(){
    if(turnoAtacante) turnoAtacante = false else turnoAtacante = true
    }



    method elegirAtaque() {
    keyboard.f().onPressDo({self.ataca1(impactrueno)                        
                            self.alternarTurno()
                            self.ataca2()
                            self.alternarTurno()
                            if(self.batallaFinalizada()) self.quitarPelea()})
    keyboard.g().onPressDo({self.ataca1(placaje)
                            placaje.play()
                            self.alternarTurno()
                            self.ataca2()
                            self.alternarTurno()
                            if (self.batallaFinalizada()) self.quitarPelea()})
    keyboard.h().onPressDo({self.ataca1(mordisco)
                            mordisco.play()
                            self.alternarTurno()
                            self.ataca2()
                            self.alternarTurno()
                            if (self.batallaFinalizada()) self.quitarPelea()})
    keyboard.j().onPressDo({self.ataca1(descanso)
                            descanso.play()
                            self.alternarTurno()
                            self.ataca2()
                            self.alternarTurno()
                            if (self.batallaFinalizada()) self.quitarPelea()})
    }
    

   
    method batallaFinalizada() = pokemon1.perdio() or pokemon2.perdio() 
}

const pikachu = new Pokemon(tipoPokemon = electrico,hp = 320,ataques = [impactrueno,placaje,mordisco,descanso],imagenPokemon = "pikachu5.gif", position = game.at(2,2))
const bulbasaur = new Pokemon(tipoPokemon = planta,hp = 320,ataques = [latigoCepa,placaje,mordisco,descanso],imagenPokemon = "Bulbasaur.gif", position = game.at(11,5))
const charmander = new Pokemon(tipoPokemon = fuego,hp = 320,ataques = [lanzaLLamas,placaje,mordisco,descanso],imagenPokemon = "charmander5.gif",position = game.at(11, 5))
const squirtle = new Pokemon(tipoPokemon = agua ,hp = 320,ataques = [pistolaDeAgua,placaje,mordisco,descanso],imagenPokemon = "squirtle.gif",position = game.at(11, 5))   

const impactrueno = new Ataque(tipoAtaque = electrico,poderAtaque = 15,sonidoAtaque = "sonidoElectrico.mp3")
const placaje = new Ataque(tipoAtaque = "normal",poderAtaque = 10, sonidoAtaque = "sonidoPlacaje.mp3")
const mordisco = new Ataque(tipoAtaque = "siniestro",poderAtaque = 12,sonidoAtaque = "sonidoMordido.mp3") 
const descanso = new Ataque(tipoAtaque = "normal",poderAtaque = 1, sonidoAtaque ="")
const latigoCepa = new Ataque(tipoAtaque = planta,poderAtaque = 15, sonidoAtaque = "sonidoLatigo.mp3")
const lanzaLLamas = new Ataque(tipoAtaque = fuego,poderAtaque = 15, sonidoAtaque ="")
const pistolaDeAgua = new Ataque(tipoAtaque = agua,poderAtaque = 15, sonidoAtaque ="")

const naza = new Protagonista(pokemonEntrenador = pikachu, imagenEntrenador= "protagonista.png", position = game.at(11,1))
const alf = new Entrenador(pokemonEntrenador = squirtle, imagenEntrenador= "alfredo.png", position = game.at(8, 7))
const lucas = new Entrenador(pokemonEntrenador = charmander, imagenEntrenador = "lucasS.png", position= game.at(13, 7))
const ivo = new Entrenador(pokemonEntrenador = bulbasaur, imagenEntrenador = "ivan.png", position = game.at(3,3))
