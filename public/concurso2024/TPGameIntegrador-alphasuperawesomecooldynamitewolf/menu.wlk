import castillo.*
import pantalla.*
import niveles.*
import controles.*
import juegoBase.*
import armas.*

class Menu{
    const menu =[] // menus <- posiciones
    const menuElementos=[] //elementos que existen dentro del entorno
    var property position =game.at(0,0) 

    const imagen
    method image() =imagen 
    method seleccionNivel() 
    method estaActivo() =menuElementos.size()>0 //esta activo si hay elementos dentro del menu. osea el menu esta activo. 

    method reiniciarPartida(){ //metodo Exclusivo de la tecla R.
      juegoDelCastillo.reiniciarPartida()
      personajePrincipal.reiniciarKills()
    }    

}

//clase del menu de inicio. (pantalla despues de la intro)
class MenuInicio inherits Menu(menu =[[7,1],[11,1]], imagen="juegoInicio.jpeg"){
  const musica = game.sound("menu2.mp3")
    override method seleccionNivel() {
        controles.configurarTeclaMenu()
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const entrenamiento = new Pantalla(imagen="maniqui.png" ,position=game.at(self.entrenamientoPosition().get(0),self.entrenamientoPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(entrenamiento)
        menuElementos.add(play)
        menuElementos.add(entrenamiento) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.
        musica.play()
        musica.shouldLoop(true)
    }
    const pantallaControles = new Pantalla(imagen="fondoReglas2.png", position=game.at(0,0))
    method verControles(){
      pantallaControles.iniciarSiNoEliminar()
    }
    method verNiveles() {
      menuNiveles.iniciar()
      musica.stop()
    }
    method playPosition() =menu.get(0) 
    method entrenamientoPosition() =menu.get(1) 
}
//
class MenuNextLevel inherits Menu(menu =[[7,1],[9,1],[7,4],[11,1] ],imagen="nivelGanado.png") { //menu del panta del siguiente nivel
    override method seleccionNivel() {
        controles.configurarTeclaSiguienteOver()
        if(!game.hasVisual(self)) game.addVisual(self)
        const nextLevel= new Pantalla(imagen="nextLevel.png", position=game.at(self.nextLevelPosition().get(0),self.nextLevelPosition().get(1)))
        const siguiente = new Pantalla(imagen="siguiente.png", position=game.at(self.siguientelPosition().get(0),self.siguientelPosition().get(1)))
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const reiniciar = new Pantalla(imagen="reiniciar.png" ,position=game.at(self.reiniciarPosition().get(0),self.reiniciarPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(reiniciar)
        game.addVisual(nextLevel)
        game.addVisual(siguiente)
        menuElementos.add(play)
        menuElementos.add(siguiente)
        menuElementos.add(nextLevel)
        menuElementos.add(reiniciar) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.
    }

    method iniciarSiguienteNivel(){
      personajePrincipal.reiniciarKills()
      juegoDelCastillo.partidaNueva()
    }
    
    method siguientelPosition() =menu.get(3) 
    method nextLevelPosition() =menu.get(2) 
    method reiniciarPosition() =menu.get(1) 
    method playPosition() =menu.get(0) 

}
class MenuGameOver inherits Menu(menu =[[7,1],[11,1],[7,4]],imagen="filterOver.png") {
    //esto habilita imagenes dentro del entorno.
       override method seleccionNivel() {
        controles.configurarTeclaGeneral()
        const gameOver= new Pantalla(imagen="gameOver.png", position=game.at(self.gameOverPosition().get(0),self.gameOverPosition().get(1)))
        const play = new Pantalla(imagen="playIcon.png" ,position=game.at(self.playPosition().get(0),self.playPosition().get(1))) 
        const reiniciar = new Pantalla(imagen="reiniciar.png" ,position=game.at(self.reiniciarPosition().get(0),self.reiniciarPosition().get(1))) 
        game.addVisual(play)
        game.addVisual(reiniciar)
        game.addVisual(gameOver)
        menuElementos.add(play)
        menuElementos.add(gameOver)
        menuElementos.add(reiniciar) //son agregados, porque despues al querer eliminarlos no funciona sin referencias, solo existió en el llamado y sus referencias murieron ahi.
        
    }
    method playPosition() =menu.get(0) 
    method gameOverPosition() =menu.get(2) 
    method reiniciarPosition() =menu.get(1) 

}
object menuNiveles {
  var property position =game.at(0,0) 
  method image() = "selectorNiveles.png"

  method iniciar() {
    if(!game.hasVisual(self)) game.addVisual(self)
    controles.teclasSelecNiveles()

  }

  method iniciarNivel(unNivel) {        
      juegoDelCastillo.iniciarNivel(unNivel)
      self.terminarMenuNiveles()
  }
  method terminarMenuNiveles() {
    game.removeVisual(self)
  }
}