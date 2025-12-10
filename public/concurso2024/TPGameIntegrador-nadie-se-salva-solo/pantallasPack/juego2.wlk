import pantallasPack.menu.Menu
object juego2{
    var escena = new Menu()

    method iniciar(){
        game.cellSize(15)
		game.width(40)
		game.height(40)	
  		game.title("bombardeo de letras")
        escena.mostrar()
        game.start()
    }

    method cambiarEscena(unaEscena){
        escena = unaEscena
        escena.mostrar()
        console.println(escena)
    }
}