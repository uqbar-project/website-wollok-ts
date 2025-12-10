import wollok.game.*
import administracion.*
import niveles.*
import gestorSonido.*

//pdoriamos hacer una clase menu, para tener el menu principal y el menu de juego, y dentro contiene los botones
object menu {

	
    method iniciar() {
	 game.addVisual(fondoMenu)
     game.addVisual(btnStart)
     game.addVisual(labelS)
     game.addVisual(btnExit)
     game.addVisual(labelE)
     game.addVisual(btnInstructtions)
     game.addVisual(labelI)
	 game.boardGround("fondito2.png")
	 
     self.movimientoBotones()
     gestorSonido.musicaMenu()
    }

    method movimientoBotones(){
        
        keyboard.s().onPressDo
        ({ 
        game.clear()
        gestorSonido.musicaMenuDetener()
        self.nivelArranque() 

        })		
        keyboard.i().onPressDo
        ({ 
        self.abrirMenuInstrucciones() 
        })		
        
        keyboard.e().onPressDo({ 
        self.salir() 
        })

    }

    method salir() {
      game.clear()
	  game.addVisual(gifExit)
    }

    method nivelArranque() {
		game.clear()
        gestorNiveles.inicializar()
    }

    
    method abrirMenuInstrucciones() {
        
		game.clear()
		game.addVisual(instruciones)
        game.addVisual(labelA)
        keyboard.left().onPressDo({ instruciones.anteriorInstruccion()})
        keyboard.right().onPressDo({ instruciones.siguienteInstruccion() })
 
		keyboard.a().onPressDo({
		game.clear()
		self.iniciar()
		 })
		 

    }  

    method irAMenu(){
        keyboard.m().onPressDo({game.clear() self.iniciar()})
    }
}



//objetos titulo y "Botones".
object btnStart {
   const property position = game.at(1,9)
   const property image = 'start.png'
}
object btnInstructtions {
  	const property position = game.at(6,9)
   	const property image = 'instructtions.png'
}
object btnExit {
  	const property position = game.at(11,9)
   	const property image = 'exit.png'
}

object  labelS {
    const property position = game.at(2,8)
     const property text = "(PRESS S)"
     const property  textColor = "FFFFFF"
  
}

object  labelI {
     const property position = game.at(7,8)
     const property text = "(PRESS I)"
     const property  textColor = "FFFFFF"
  
}

object  labelE {
    const property position = game.at(12,8)
     const property text = "(PRESS E)"
     const property  textColor = "FFFFFF"  
}

object  labelA {
     const property position = game.at(14,0)
     const property text = "(PRESS A BACK, → NEXT)"
     const property  textColor = "FFFFFF"
  
}

//fondos de menu

object gifExit {
  	const property position = game.at(6,2)
   	const property image = 'salir.gif'
}

object fondoMenu {
  	const property position = game.at(0,0)
   	const property image = 'welcomeAlanaa.png'
}

object fondoInstruccions{
const property position = game.at(2,0)
   	const property image = 'instrucciones2.png'

}


//*==========================|sub menu |==========================*//

object instruciones{

    const property position = game.at(0,0)
   	var property image = instruccioneslista.get(indice)
    const property instruccioneslista = ["instrucciones.png","instruciones3.gif"]
    var indice = 0

    method siguienteInstruccion() {
      self.sumarAlIndice()
      self.image(self.instrucionesEsperada(indice))
    }
    method anteriorInstruccion() {
      self.restarAlIndice()
      self.image(self.instrucionesEsperada(indice))
    }
    method instrucionesEsperada(indicador){return self.instruccioneslista().get(indicador) }
    
    method sumarAlIndice() {
     if (indice + 1 < instruccioneslista.size()) {
        indice = indice + 1
        } 
     else {
        indice = 0
    }
}
    method restarAlIndice(){
    if(indice - 1 >= 0){
        indice = indice - 1
    }
    else{
        indice = instruccioneslista.size() - 1
    }
}
    
}
