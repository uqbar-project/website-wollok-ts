import tableroYCartas.*
import general.*
import gameManager.*
import controladores.*
import highscores.*


//Super clase de Menus
class MenuBase {
    const image
    var keyboardActivo = false

    method iniciar() {game.addVisual(self) keyboardActivo=true}

    method desactivar() {game.removeVisual(self) keyboardActivo=false self.reiniciarAtributos()}

    method redireccionar() {self.desactivar()}

    method position() = game.origin()

    method image() = image    

    method reiniciarAtributos()

    method iniciarControles()
}

object menuInicio inherits MenuBase(image="menuInicio.png") {
    var esSoloDibujos = true
    var esFacil = true

    override method iniciarControles() {
        //Seleccionar cantidad de cartas
        keyboard.num1().onPressDo({esFacil = true   selIzq.apuntarOpcionUno() cursor.esDifFacil()})
        keyboard.num2().onPressDo({esFacil = false  selIzq.apuntarOpcionDos() cursor.esDifNormal()})

        //Seleccionar tipo de cartas
        keyboard.num8().onPressDo({esSoloDibujos=true selDer.apuntarOpcionUno()})
        keyboard.num9().onPressDo({esSoloDibujos=false selDer.apuntarOpcionDos()})

        //Manejar al tutorial
        keyboard.i().onPressDo({if(keyboardActivo) {self.mostrarOcultarTuto()} })

        //Mostrar HighScores
        keyboard.h().onPressDo({if(keyboardActivo) self.mostrarOcultarHighscores()})

        //Dirigir al tablero
        keyboard.c().onPressDo({if(keyboardActivo){self.redireccionar()}})
    }

    override method iniciar() {super() selDer.iniciar() selIzq.iniciar() fadeIn.iniciar()}

    override method desactivar() {super() selDer.desactivar() selIzq.desactivar()}

    method mostrarOcultarTuto() {if(game.hasVisual(menuTuto)) menuTuto.desactivar() else menuTuto.iniciar()}

    method mostrarOcultarHighscores() {
        if(game.hasVisual(menuListaHighscores)) menuListaHighscores.desactivar() else menuListaHighscores.iniciar()}

    method cantidadPares() = if (esFacil) 7 else  10

    method esFacil() = esFacil

    override method redireccionar() {
        menuTuto.desactivar()
        menuListaHighscores.desactivar()
        selDer.desactivar()
        selIzq.desactivar()
        gameManager.inicioDelJuego(self.cantidadPares(),esSoloDibujos)
        super()}

    override method reiniciarAtributos() {esFacil=true esSoloDibujos=true}         
}

object menuTuto inherits MenuBase(image="templateTuto.png") {

    override method reiniciarAtributos() {}

    override method iniciarControles() {}
}

object selIzq inherits MenuBase(image="selec2.gif") {
    const imageB = "selec1.gif"
    var opcionArriba = true

    method apuntarOpcionUno() {opcionArriba=true}

    method apuntarOpcionDos() {opcionArriba=false}

    override method image() = if(opcionArriba) imageB else image

    override method position() = game.at(1,2)
  
    override method reiniciarAtributos() {opcionArriba = true}

    override method iniciarControles() {}
}

object selDer inherits MenuBase(image="selec8.gif") {
    const imageB = "selec9.gif"
    var opcionArriba = true

    method apuntarOpcionUno() {opcionArriba = true}

    method apuntarOpcionDos() {opcionArriba=false}

    override method image() = if(opcionArriba) image else imageB

    override method position() = game.at(2,2)
  
    override method reiniciarAtributos() {opcionArriba = true}

    override method iniciarControles() {}
}

object menuFinal inherits MenuBase(image="menuFinal.gif") {

    override method iniciar() {super() self.autoRedireccion()}

    method autoRedireccion() {game.schedule(5000,{self.redireccionar()})}

    override method redireccionar() {fadeOut.iniciar() game.schedule(1100,{self.desactivar() gameManager.reiniciar()})}

    override method reiniciarAtributos() {}

    override method iniciarControles() {}
}

object fondoPuntajes inherits MenuBase(image="tabP.png") {

    override method iniciar() {super() self.crearSombra()}

    method crearSombra() {if(gameManager.paresTotales()<10) sombra.iniciar()}

    override method reiniciarAtributos() {}    

    override method iniciarControles() {}   
}

object indicadorBonus {

  method iniciar() {game.addVisual(self) game.schedule(1200,{self.desactivar()})}

  method desactivar() {game.removeVisual(self)}

  method activarSiEncadena() {if(puntuacionMngr.bonusActivo()) self.iniciar()}

  method image() = "bonus.gif"

  method position() = game.at(0,0)
}

object sombra inherits MenuBase(image="fSombra.png") {
  
    override method reiniciarAtributos() {}

    override method iniciarControles() {}
}

object fadeOut inherits MenuBase(image="fade1.png") {
    var frameActual = 1

    override method iniciar() {super() self.iniciarAnimacion()}

    method iniciarAnimacion() {
        game.onTick(250, "fadingIn", { => self.animar()})
    }

    method animar() {
        if(frameActual <= 4) {frameActual += 1} else {self.desactivar()}
    }

    override method image() = "fade" + frameActual.toString() + ".png"
  
    override method reiniciarAtributos() {game.removeTickEvent("fadingIn") frameActual = 1 }

    override method iniciarControles() {}
}

object fadeIn inherits MenuBase(image="fade4.png") {
    var frameActual = 4

    override method iniciar() {super() self.iniciarAnimacion()}

    method iniciarAnimacion() {
        game.onTick(250, "fadingOut", { => self.animar()})
    }

    method animar() {
        if(frameActual <= 8) {frameActual += 1} else {self.desactivar()}
    }

    override method image() = "fade" + frameActual.toString() + ".png"
  
    override method reiniciarAtributos() {game.removeTickEvent("fadingOut") frameActual = 4 }

    override method iniciarControles() {}
}