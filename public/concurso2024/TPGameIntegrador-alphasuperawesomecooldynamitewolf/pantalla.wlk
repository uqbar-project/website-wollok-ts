
class Pantalla{
    const imagen 
    var property position =game.at(0,0)
    method image() =imagen

    method iniciar() {
        if(! game.hasVisual(self)){
            game.addVisual(self)
        }
    }
    method eliminar(){
    	if (game.hasVisual(self)){
    		game.removeVisual(self)
    	}
    }

    method iniciarSiNoEliminar(){
        if(! game.hasVisual(self)){
            self.iniciar()
        }else{
            self.eliminar()
        }
    }
}
