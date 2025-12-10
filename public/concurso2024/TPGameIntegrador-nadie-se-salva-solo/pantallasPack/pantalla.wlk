import sonido.*
class Pantallas{
    
    
    method position() = game.origin()

    method mostrar(){
        game.addVisual(self)
        self.comportamiento()        
    }

    method ocultar(){
        game.removeVisual(self)        
    }    

    method comportamiento()
    
    method image()
    
    
    
}