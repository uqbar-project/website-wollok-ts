
import modoDeJuego.*
import sonido.*

class ModoDificil inherits ModoDeJuego {

    const musica = new Sonido(cancion = "musicaDificil.mp3")

    override
    method mostrar(){          
        velocidadCaida = 1200
        cantidadLetras = 8
        velocidadAparacion = 1200
        self.playMusica()
        super()                     
    }

    method playMusica(){
        musica.reproducir(true)
        musica.cambiarVolumen(0.2)
    }

    override 
    method ocultar(){
        musica.parar()
        super()     
    }
    
    
    override
    method image() = "modoDificil2.png"  
    
    override
    method aumentarCantidadLetras(){
        cantidadLetras = cantidadLetras + 2;
    }

    override   
    method aumentarVelocidadCaida(){
        velocidadCaida = (velocidadCaida - 100).max(0)
    }
    
    override
    method aumentarVelocidadAparacion(){
        velocidadAparacion = (velocidadAparacion - 100).max(0)
    }

    
    
}