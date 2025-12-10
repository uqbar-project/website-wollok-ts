import wollok.vm.*
import modoDeJuego.*
import sonido.*

class ModoFacil inherits ModoDeJuego{

    const musica = new Sonido(cancion = "musicaFacil.mp3")

    override
    method mostrar(){        
        velocidadCaida = 1500
        cantidadLetras = 5
        velocidadAparacion = 1200
        
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
    method image() = "modoFacil2.png"    
    
    override
    method aumentarCantidadLetras(){
        cantidadLetras = cantidadLetras + 1;
    }

    override   
    method aumentarVelocidadCaida(){
        velocidadCaida = (velocidadCaida - 200).max(0)
    }
    
    override
    method aumentarVelocidadAparacion(){
        velocidadAparacion = (velocidadAparacion - 200).max(0)
    }

}