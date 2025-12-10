import castillo.*
import enemigos.*
import niveles.*
import wollok.game.*
import menu.*
import controles.*
import armas.*
import intro.*



object juego {
  const menusActivos=[]
  method menus() =menusActivos 
  method iniciar() {
    game.title("Orcs defense")
    game.height(10)
    game.width(20)
    game.boardGround("fondo.png")
    game.addVisual(secuencia)
    self.configurarEntorno()
    secuencia.saltar()
    game.start()
    
  }
  //configura los menus del juego. 
  method configurarEntorno() {
    const menu = new MenuInicio()
    const menuNextLevel= new MenuNextLevel()
    const menuGameOver=new MenuGameOver()
    menusActivos.addAll([menu,menuNextLevel,menuGameOver])
  } 
    method  obtenerMenuInicial()=menusActivos.get(0)
    method  obtenerMenuNextLevel()=menusActivos.get(1)
    method  obtenerMenuGameOver()=menusActivos.get(2)

    method volverMenuBase(){
      if(!game.hasVisual(menu.menuNiveles)){
        game.clear()
        juegoDelCastillo.obtenerNivel(juegoDelCastillo.nivel()).detenerMusica()
        game.addVisual(self.obtenerMenuInicial())
        self.obtenerMenuInicial().seleccionNivel()
      }
    }
}

object juegoDelCastillo {//para mantener la estructura del juego. <- primero debe pasar por el menu
 
  var  property nivel = 0//Numero
  const niveles=[nivel1 , nivel2 , nivel3]
  const nivelesCompeltos=[]

  method tieneNiveles() =niveles.size()>0 //util para teclas del selector nivel. impide que se agreguen multiple veces los niveles. (revisar Menu) 
  method iniciarNivel(unNivel) { 
    game.clear()
    nivel=unNivel
    //reinicia todos los parametros para empezar de 0 siempre
    personajePrincipal.reiniciarMonedas()
    personajePrincipal.reiniciarKills()
    castillo.reiniciarVida()  
    controles.configurarTeclas()
    game.addVisual(torresOpciones) 
    self.obtenerNivel(unNivel).iniciar()
    self.obtenerNivel(unNivel).iniciarMusica()
    self.iniciarReglas()
  }
  method iniciarReglas(){
      juego.obtenerMenuInicial().verControles() // le dice al juego que inicie su visual de las reglas.
      game.schedule(5500, {juego.obtenerMenuInicial().verControles() controles.configurarReglas() })  // cuando pasen 5 segundos volvela a llamar (esta sabe que al llamarla de nuevo se tiene que eliminar).
                                                                                    // configura las teclas de forma permanente.
  }
  method nivelActual() =niveles.get(nivel) 
  method obtenerNivel(unNivel) = niveles.get(unNivel.min(2))

  method reiniciarPartida() {  // reinicia  enteramente la partida.
    game.clear()
    self.iniciarNivel(nivel)

  } 
  method reproducirGameOver() {
   game.sound("gameOver.mp3").play()
  }
  method partidaFinalizada() { //le indica al menu de torres de opcion que su partida finalizo, y selecciona el primer nivel y habilita su manera de perder el nivel (parando y eliminando.)  
    self.obtenerNivel(nivel).detenerMusica()
    self.obtenerNivel(nivel).partidaFinalizada()
    torresOpciones.partidaFinalizada()     
    game.removeVisual(torresOpciones)
    self.reproducirGameOver()
    self.generarGameOver() //llama al menu GameOver para que vuevla con una pantalla.
  }  
  method reproducirVictoria() {
    game.sound("victoria.mp3").play()
  }
  method ganarPartida() {  // lo llama Nivel al terminar de evaluar las condiciones de victoria.
    self.obtenerNivel(nivel).detenerMusica()
    torresOpciones.partidaFinalizada() 
    self.obtenerNivel(nivel).partidaFinalizada()
    self.reproducirVictoria()
    game.removeVisual(torresOpciones)
    juego.obtenerMenuNextLevel().seleccionNivel()
  }
  method partidaNueva() { //si en el menu Next Level se tocó la Tecla E , se carga la siguiente partida.
    self.iniciarNivel(self.irAsiguienteNivel())
    
  }
  method generarGameOver() {
      game.addVisual(juego.obtenerMenuGameOver())
      juego.obtenerMenuGameOver().seleccionNivel()
      personajePrincipal.partidaFinalizada()
    }
  method nivelQueSigue()= niveles.filter({ n => nivelesCompeltos.any({ nc => n !=nc})}).first() // filtrame por los niveles que no están dentro de los niveles pasados por el jugador
  method irAsiguienteNivel(){
    nivel = (nivel + 1).min(2)
    return nivel
  }


// const musicaMenu = game.sound("Menu2.mp3") 
 
}
