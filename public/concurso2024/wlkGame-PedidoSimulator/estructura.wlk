import wollok.game.*
import menus.*

object compilador {
    method iniciar() {
        game.title("Pedido Simulator")
        self.prepararDimensionesTablero()
        game.boardGround("map_final5.png")
        menu.iniciar()
        game.start()
    }
    method prepararDimensionesTablero() {
        game.width(30)
	    game.height(15)
	    game.cellSize(50)
    }

}