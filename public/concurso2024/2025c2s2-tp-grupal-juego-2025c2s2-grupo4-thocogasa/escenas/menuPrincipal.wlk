import escenas.ajedrez.*
import wollok.game.*
import rey.*
import enemigos.*
import aliados.*
import UI.*
import mecanicas.*
import oleadas.*
import leaderboard.*
import escenas.cambioDeEscena.*

object menuPrincipal inherits Escena{

    var property start = new TextoMenu(texto="Aprete enter para iniciar a jugar", position=game.at(3, 1))
    
    override method mostrar(){
        game.addVisual(menu)
        visuales.add(menu)
        game.addVisual(start)
        visuales.add(start)

        keyboard.enter().onPressDo({ if (managerEscena.escenaActual() == self) managerEscena.cargar(ajedrez) })
    }
}

class TextoMenu{
    var property texto = ""
    var property position = game.at(0, 0)

    method text()=self.texto()

    method textColor() = "FFFFFF"
}

object menu {
    var property image = "LPS-MainMenu.png"
    var property position = game.at(0, 0)

}

