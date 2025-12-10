import sonido.*
import vida.*

class LetraPadre{

    const property letra   
    const property puntaje
     
    var esVisible = false
    var property image = ""      
    var property position = game.at(15, 15)
    

    method doComportamiento(posicionX, velocidadCaida){             
        self.aparecer(posicionX)        
        self.doCaer(velocidadCaida)
        image = letra+ ".png"                         
    }

    method aparecer(posicionX){
        position = game.at(posicionX, 36)
        game.addVisual(self) 
    }

    method doCaer(velocidadCaida){
        esVisible = true
        game.onTick(velocidadCaida, "caer"+letra, {self.caer()})        
    }   

    method caer(){
        if(esVisible){
            position = position.down(1)            
        }
        self.impactar()
                                       
    }

    method impactar(){  
        if(position.y() < 7){
            game.removeVisual(self)                                               
        }    
    }

    method doExplosion()

    method explotar(unaImagen,unSonido){
        image = unaImagen
        game.removeTickEvent("caer"+letra)
        game.removeTickEvent("rotar"+letra)        
        self.reproducirSonido(unSonido)        
        game.schedule(500, {game.removeVisual(self)})
    }    
  
    method reproducirSonido(unSonido){        
        unSonido.reproducir(false)
        unSonido.cambiarVolumen(0.5)
        game.schedule(1500, {unSonido.parar()})
    }

    method ocultar(){
        game.removeVisual(self)
    }

           
     
}