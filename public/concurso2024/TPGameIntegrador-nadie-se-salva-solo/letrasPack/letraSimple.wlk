import pantallas.*
import letraPadre.*
import sonido.*
class LetraSimple inherits LetraPadre{ 

    var posicionRotar = 0    

    override    
    method impactar(){  
        if(position.y() < 7){
            self.explotar("impacto.png", new Sonido(cancion = "explosion2.mp3"))                                               
        }    
    }

    override 
    method doComportamiento(posicionX,velocidadCaida){
        super(posicionX,velocidadCaida)
        posicionRotar = 0               
        image = letra+ posicionRotar +".png"
    }

    method doRotar(){
        game.onTick(500, "rotar"+letra, {self.rotar()})
    }

    method rotar(){ 
        image = letra + posicionRotar + ".png"
        posicionRotar += 1
        if(posicionRotar >3){
            posicionRotar = 0
        }
    }
    
    override
    method doExplosion(){
        self.explotar("explosion1.png", new Sonido(cancion="explosion2.mp3"))
    }
  
    
    
}