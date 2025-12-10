import personaje.*
import extras.*
import niveles.*

const monstruosNivel1 =  [new Monstruo(),  new Monstruo(), new Calabera(), new Calabera()]
const monstruosNivel2 =  [new ReyDuende(), new Monstruo(), new Calabera()]
const pocionesNivel1 = [new Pociones(position=game.at(10, 11)), new Pociones(position=game.at(4, 5)),new Pociones(position=game.at(12, 4))]
const pocionesNivel2 = [new Pociones(position=game.at(10, 11)), new Pociones(position=game.at(11, 3)), new Pociones(position=game.at(4, 3))] 

//(Si hay tiempo le podriamos poner una barra de vida al jefe)

object juego{
  var nivelActual = 0 
  var nivelIniciado = false
  var objetoNivel = nivel1
  const musicaInicio = game.sound("musicaDeInicio.wav")
  
  method nivelIniciado() = nivelIniciado
  method nivelActual() = nivelActual
  method nivelIniciado(estaIniciado){nivelIniciado = estaIniciado}

  method iniciarJuego(){
    musicaInicio.shouldLoop(true)  // Hacerlo en loop
    musicaInicio.volume(0.1)          // Volumen 
    game.schedule(500, { musicaInicio.play() }) // inicia musica


    self.prepararPantallaDeInicio()
    keyboard.space().onPressDo{
      if(!self.nivelIniciado())
        musicaInicio.stop()
        game.removeVisual(imagenInicial)//Hacer lo de la imagen inicial
        nivelActual = 1
        objetoNivel = nivel1
        self.prepararJuego()
        self.nivelIniciado(true)
    }
  }

  method prepararPantallaDeInicio(){
    game.title("CocoAdventure")
    game.width(16)
    game.height(16)
	  game.cellSize(32)
    game.boardGround("fondoOscuro.png")//fondo.jpg
    game.addVisual(imagenInicial)
  }

  method prepararJuego(){
    self.crearNivel(objetoNivel)
  }

  method crearNivel(nivel){
    nivel.sonidoNivel().shouldLoop(true)  // Hacerlo en loop
    nivel.sonidoNivel().volume(0.2)          // Volumen 
    game.schedule(500, { nivel.sonidoNivel().play() }) // inicia musica

    game.addVisual(nivel.image()) // Crear en un archivo aparte que contenga la clase nivel
    game.addVisualCharacter(coco)
    coco.posicionInicial(nivelActual)
    self.crearVidas()
    self.configurar(nivel)
    self.perseguirACoco(nivel) //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    self.agregarPociones(nivel)  
    self.colisionarConCoco()
    self.cocoMorir()
  }

  // method imagenBug() = game.allVisuals().filter({imagen => imagen.position() == game.at(2,2)}) Intento de encontrar el visual


  method crearVidas(){
    const vida3 = new Vidas(position=game.at(15, 15))
    const vida2 = new Vidas(position=game.at(14, 15))
    const vida1 = new Vidas(position=game.at(13, 15))
    game.addVisual(vida3)
    game.addVisual(vida2)
    game.addVisual(vida1)

    game.onTick(10, "perderVidas", {self.calcularVidaPerdida(vida1,vida2,vida3)})
    game.onTick(10, "perderVidas", {self.calcularVidaRecuperada(vida1,vida2,vida3)})
  }

  method calcularVidaPerdida(c1,c2,c3) {
    if(coco.vidas() >= 2){
      c3.perderVida()
    }else if(coco.vidas() >= 1){
      c3.perderVida()
      c2.perderVida()
    } else if(coco.vidas() == 0){
      c3.perderVida()
      c2.perderVida()
      c1.perderVida()
    }
  }

  method calcularVidaRecuperada(c1,c2,c3) {
    if(coco.vidas() == 3){
      c3.recuperarVida()
      c2.recuperarVida()
      c1.recuperarVida()
    }
  }

  method colisionarConCoco(){
    game.onCollideDo(coco, {p =>
      p.colisionarConCoco()
    })
  }

  method cocoMorir(){
    game.onTick(500, "gameOver", {if(!coco.estaVivo()) self.gameOver()})
  }

  method gameOver(){
    //Logica de game over
    self.finalizarNivel()
    game.addVisual(imagenGameOver)
    nivelIniciado = false
  }

  //method reiniciarJuego(){
  //  nivelActual = 1
  //  objetoNivel = nivel1
  //  self.recuperarVidaDeMonstruos()
  //  coco.recuperarVida()
  //}

  method recuperarVidaDeMonstruos(){
    nivel1.enemigos().forEach({m => m.reiniciarVidas()})
    nivel2.enemigos().forEach({m => m.reiniciarVidas()})
  }

  method perseguirACoco(monstruosNivel){
    //Lista con los monstruos de cada nivel, que aparezcan y que lo sigan
    monstruosNivel.enemigos().forEach({m => 
      const id = m.identity().toString()
      game.addVisual(m)
      m.perseguirACoco(id, monstruosNivel)
     })
  }

  method configurar(nivel){
    self.atacarAMonstruo(nivel)
    self.consultarVida()
    self.movimientoPersonaje()
    game.onTick(200, "comprobar", {self.pasoDeNivel()})
  }   

  method pasoDeNivel(){
    if(self.todosLosEnemigosMuertos(objetoNivel) and (coco.position() == game.at(13, 8) or objetoNivel == nivel2)) self.siguienteNivel()
  }

  method todosLosEnemigosMuertos(nivel) = nivel.enemigos().all({m => m.estaMuerto()})

  method atacarAMonstruo(nivel) {
    keyboard.e().onPressDo({
      coco.atacar()
      nivel.enemigos().forEach({m => 
        const id  = m.identity().toString()
        if(m.position() == coco.position()) m.recibirAtaque(id)
      })
    })
  }

  method consultarVida() {
    keyboard.q().onPressDo({
      game.say(coco, "mi vida es " + coco.vidas())
    })
  }

  method siguienteNivel(){
    nivelActual += 1
    self.finalizarNivel()
    objetoNivel = nivel2
    if ((nivelActual == 2)){
      self.crearNivel(objetoNivel)
    }else
      self.pantallaGanaste()
  }

  method pantallaGanaste(){
    game.addVisual(imagenDeVictoria)
  }

  method finalizarNivel(){
      game.clear()
      objetoNivel.sonidoNivel().pause()
      nivelIniciado = false
  }


  //method cocoEnPosicionDeSalida() = (coco.position().x()  == 13) and (coco.position().y() == 7)
  
  method agregarPociones(pocionesDelNivel){
    //Aparecen las pociones del respectivo nivel
    pocionesDelNivel.pociones().forEach({p =>
    game.addVisual(p) 
  })
  }

  method movimientoPersonaje(){
    keyboard.right().onPressDo({coco.irHaciaDerecha(objetoNivel)})
    keyboard.left().onPressDo({coco.irHaciaIzquierda(objetoNivel)})
    keyboard.up().onPressDo({coco.irHaciaArriba(objetoNivel)})
    keyboard.down().onPressDo({coco.irHaciaAbajo(objetoNivel)})

    // keyboard.right().onPressDo({derecha.irHaciaDerecha()})
    // keyboard.left().onPressDo({izquierda.irHaciaIzquierda()})
    // keyboard.up().onPressDo({arriba.irHaciaArriba()})
    // keyboard.down().onPressDo({abajo.irHaciaAbajo()})
  }
}