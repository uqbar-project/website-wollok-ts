import gameManager.*
import controladores.*
import sonidosGlobales.*
import wollok.game.*
import interfaz.*

//El menu que controla al highscoreMngr
//Con Espacio se acepta la letra, 3º vez automatiza el ending hasta reiniciar
object menuCrearHighscore inherits MenuBase(image="CrearRecord.png") {
    var letrasIngresadas = 0
    var desactivarEditor = false
    

    override method iniciar() {
      super()
      gameManager.deshabilitarReinicio()
      highscoreMngr.iniciar()}

    method sumarletraIngresada() {letrasIngresadas = letrasIngresadas + 1}

    method accionKeySpace() {if(keyboardActivo) self.accionKeyboard()}

    method desactivarIngresoDeLetra() {
      if(letrasIngresadas==3) desactivarEditor=true}  

    method accionKeyboard() {
        highscoreMngr.registrarLetra()
        self.sumarletraIngresada()
        self.desactivarIngresoDeLetra()
        self.moverORedireccionar()}

    method moverORedireccionar() {
      if(!desactivarEditor) {highscoreMngr.pasarAlSiguenteCaracter()}
       else {
        keyboardActivo = false
        highscoreMngr.crearFicha()
        highscoreMngr.desactivarEditor()
        self.autoRedireccionUno()}}

    method autoRedireccionUno() {game.schedule(1000,{self.redireccionar()})}

    override method redireccionar() {
      fadeOut.iniciar() 
      game.schedule(1100,{
        self.desactivar() 
        menuListaHighscores.iniciar() 
        fadeIn.iniciar()
        self.autoRedireccionDos()})
    }

    method autoRedireccionDos() {game.schedule(5000, {self.redireccionarDos()})}

    method redireccionarDos() {
      fadeOut.iniciar()
      game.schedule(1100, {
        menuListaHighscores.desactivar()
        menuFinal.iniciar()
        fadeIn.iniciar()})
    }

    override method desactivar() {
      highscoreMngr.desactivar()
      fondoPuntajes.desactivar()
      puntuacionMngr.desactivar()
      tiempoMngr.desactivar()
      turnosMngr.desactivar()
      super()
      }

    override method reiniciarAtributos() {letrasIngresadas=0 desactivarEditor=false}

    override method iniciarControles() {}  

    method letrasIngresadas() = letrasIngresadas // PARA TESTS
    method desactivarEditor() = desactivarEditor // PARA TESTS    
}

// Es un editor de letras. Por encima, el menuCrearHighscore
// Necesita de menuCrearHighscore para visual de fondo y dirección de flujo con Espacio
object highscoreMngr {
  var property position = game.at(0, 3)
  const inicialesActuales = []
  var puntajeActual = 0
  const letrasPlasmadas = []
  const puntajesPlasmados = []
  var image = coleccionLetras.imagenLetra()
  var keyboardActivo = false
  
  method iniciar() {
    inicialesActuales.clear()
    game.addVisual(self) 
    keyboardActivo=true 
    puntajeActual = puntuacionMngr.puntos()
    self.plasmarPuntaje(puntajeActual, game.at(3,3))}

  method desactivarEditor() {
    game.removeVisual(self)
    keyboardActivo = false}

  method desactivar() {
    self.destruirPlasmados()
    self.reiniciarAtributos()
    }

  method accionKeyUp() {
    if(keyboardActivo)self.letraAnt()
  }

  method accionKeyDown() {
    if(keyboardActivo)self.letraSig()
  }

  method letraSig() {
    coleccionLetras.siguienteLetra()
    image = coleccionLetras.imagenLetra()
    sonidosGlobales.playCursor()}

  method letraAnt() {
    coleccionLetras.anteriorLetra()
    image = coleccionLetras.imagenLetra()
    sonidosGlobales.playCursor()}

  method registrarLetra() {
    if (keyboardActivo) {
        inicialesActuales.add(coleccionLetras.imagenLetra())
        self.plasmarVisualLetra(coleccionLetras.imagenLetra(),self.position())
        sonidosGlobales.playCursor()}
  }

  method pasarAlSiguenteCaracter() {self.position(self.position().right(1)) coleccionLetras.reiniciarAtributos() image = "L0.png"}

  method plasmarVisualLetra(unPng,unaPosicion) {
    const letra = new LetraVisualFija(image = unPng, position=unaPosicion)
    game.addVisual(letra)
    letrasPlasmadas.add(letra)
  }

  method plasmarPuntaje(unPuntaje,unaPosicion) {
    const visualDeUnPuntaje = []
    const puntajeComoString = (unPuntaje+1000).toString()

    visualDeUnPuntaje.add(new NumeroVisualFijo(pos=unaPosicion,num=puntajeComoString.charAt(1),orden="a"))
    visualDeUnPuntaje.add(new NumeroVisualFijo(pos=unaPosicion,num=puntajeComoString.charAt(2),orden="b"))
    visualDeUnPuntaje.add(new NumeroVisualFijo(pos=unaPosicion,num=puntajeComoString.charAt(3),orden="c"))

    visualDeUnPuntaje.forEach({v => game.addVisual(v)})
    puntajesPlasmados.addAll(visualDeUnPuntaje)
  }

  method destruirPlasmados() {
    puntajesPlasmados.forEach({v => game.removeVisual(v)})
    letrasPlasmadas.forEach({v => game.removeVisual(v)})
    puntajesPlasmados.clear()
    letrasPlasmadas.clear()}

  method crearFicha() {
    menuListaHighscores.ingresar(new FichaHighscore(
      inA=inicialesActuales.get(0),inB=inicialesActuales.get(1),inC=inicialesActuales.get(2),puntajeNum=puntajeActual))
  }

  method image() = image

  method reiniciarAtributos() {
    self.position(game.at(0, 3))
    image = "L0.png"
    puntajeActual = 0
    coleccionLetras.reiniciarAtributos()
    }  

  method letrasPlasmadas() = letrasPlasmadas // PARA TESTS  
  method puntajesPlasmados() = puntajesPlasmados // PARA TESTS  
  method keyboardActivo() = keyboardActivo // PARA TESTS  
}

object coleccionLetras {
    var index = 0

    method imagenLetra() = "L" + index.toString() + ".png"

    method siguienteLetra() {
        if((index + 1) == 26) {index = 0} else index += 1}

    method anteriorLetra() {
        if((index - 1) == -1) {index = 25} else index -= 1}

    method reiniciarAtributos() {index=0}

    method index() = index // PARA TESTS
}


// Registro de cada record. Al principio, las iniciales se guardaban en una lista. 
// Pero, al crear una nueva instancia de esta clase,
// la lista de todas las anteriores se reemplazaba por la nueva. Cosa que no debería pasar.
class FichaHighscore {
    const inA
    const inB
    const inC
    const puntajeNum

    method inA() = inA
    method inB() = inB
    method inC() = inC

    method puntajeNumero() = puntajeNum

    method puntajeString() = (puntajeNum+1000).toString()
}

object menuListaHighscores inherits MenuBase(image="menuRecords.png") {
  const records = []
  const listaHighscoresOrdenada = []
  var fila = game.at(0,3)

  override method iniciar() {super() self.ordenarHighscores() self.mostrarHighscores()}

  override method desactivar() {highscoreMngr.destruirPlasmados() visualNoHighscore.desactivar() super() }

  method ingresar(record) {records.add(record)}
  
  method records() = records // PARA TESTS
  method listaHighscoresOrdenada() = listaHighscoresOrdenada // PARA TESTS  
  method fila() = fila // PARA TESTS  

  method ordenarHighscores() {
      records.sortBy({e1,e2 => e1.puntajeNumero() > e2.puntajeNumero()})
      listaHighscoresOrdenada.addAll(records)}

  method mostrarHighscores() {
    if(listaHighscoresOrdenada.isEmpty()) {
      self.visualNoHayRecords()} else {self.desplegarRecords()}
  }

  method mejoresCuatro() = listaHighscoresOrdenada.take(4)

  method desplegarRecords() {
    self.mejoresCuatro().forEach({ficha => self.plasmarFicha(ficha)})
    self.reiniciarFila()
  }

  method plasmarFicha(unaFicha) {
    self.plasmarLetrasYPuntaje(unaFicha,fila)
    self.siguienteFila()
  }

  method plasmarLetrasYPuntaje(laFicha,unaFila) {
    const posicion = unaFila
    highscoreMngr.plasmarVisualLetra(laFicha.inA(),posicion)
    highscoreMngr.plasmarVisualLetra(laFicha.inB(),posicion.right(1))
    highscoreMngr.plasmarVisualLetra(laFicha.inC(),posicion.right(2))
    highscoreMngr.plasmarPuntaje(laFicha.puntajeNumero(), posicion.right(3))
  }

  method siguienteFila() {fila = fila.down(1)}

  method reiniciarFila() {fila = game.at(0,3)}

  method visualNoHayRecords() {visualNoHighscore.iniciar()}

  method siguientesMejoresCuatro() = listaHighscoresOrdenada.drop(4).take(4)

  override method iniciarControles() {}//Si se quiere pasar a siguente página, iría acá
    
  override method reiniciarAtributos() {listaHighscoresOrdenada.clear() self.reiniciarFila()}
}

class LetraVisualFija {
  const image   //Espera "L0.png"
  const position//Espera game.at(x,y) 

  method iniciar() {game.addVisual(self)}

  method desactivar() {game.removeVisual(self)}

  method image() = image

  method position() = position
}

// Una instancia de esta clase puede generar cualquier digito (1º ò 2º ò 3º) en una misma celda,
// según el atributo 'orden' que se le asigne
class NumeroVisualFijo  {
  var image = null
  const pos     //Espera game.at(x,y) 
  const num     //Espera un numero como string EJ: "0" ó "1" ó "9"
  const orden   //Espera una letra de estas: "a" ó "b" ó "c"

  method initialize() {image = "n" + num + orden + ".png"}

  method desactivar() {game.removeVisual(self)}

  method image() = image

  method position() = pos
}

object visualNoHighscore {

  method iniciar() {game.addVisual(self)}

  method desactivar() {if(game.hasVisual(self)) game.removeVisual(self)}

  method image() = "NoRec.png"
  method position() = game.at(0,0)
}
