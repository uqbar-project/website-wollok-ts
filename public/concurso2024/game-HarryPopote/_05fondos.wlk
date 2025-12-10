import _03niveles.*


class Fondo {
  	var property position = game.origin()

    method image() //metodo abstracto
	method serEncontrada(){}
	method perderVida(){}

	method colisionarConHarry() {}
  	method colisionarConHechizo() {}

}
object fondo1 inherits Fondo {
	override method image()= "fondoNivel1.png" //700x450
}

object fondo2 inherits Fondo {
	override method image()= "menu2.png" 
}

object perdiste inherits Fondo {
	override method image()= "perdiste.png" 
}


object pasasteAlDos inherits Fondo {
	override method image()= "nivel2.png" 
}

object instrucciones1 inherits Fondo {
	override method image()= "instrucciones1.png" 
}

object fondoNivel2 inherits Fondo {
  override method image() = "fondoNivel2.jpg"  
}

object instrucciones2 inherits Fondo {
	override method image()= "instrucciones2.png" 
}


object instrucciones3 inherits Fondo {
	override method image()= "preFin.png"
}

object fondoFin inherits Fondo {
  override method image() = "hallHogwarts.jpg" 
}


object fondoFinal inherits Fondo {
  override method image() = "fin.jpg"    
}

