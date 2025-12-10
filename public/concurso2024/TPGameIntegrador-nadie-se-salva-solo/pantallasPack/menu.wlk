import pantallasPack.juego2.*
import modoDeJuego.modoDificil.*
import pantalla.*
import modoDeJuego.modoFacil.*
import sonido.*


class Menu inherits Pantallas{

    const musica = new Sonido(cancion = "musicaMenu2.mp3")
    const f =  new ModoFacil()
    const d =  new ModoDificil() 

    override
    method image() = "menuInicial3.png"

    override
    method mostrar(){
        self.playMusica()
        super()
    }

    method playMusica() {
        musica.reproducir(true)
        musica.cambiarVolumen(0.2)      
    }

    override
    method ocultar(){
        musica.parar()
        super()
    }
        
    override
    method comportamiento(){             
        keyboard.num1().onPressDo({ self.iniciarModoFacil() })
        keyboard.num2().onPressDo({self.iniciarModoDificil()})
        keyboard.shift().onPressDo({self.mostrarComoJugar()})        
    }      

    method iniciarModoFacil(){
        
        self.ocultar()
        juego2.cambiarEscena(f)
    }

    method iniciarModoDificil(){        
        self.ocultar()
        juego2.cambiarEscena(d)
    }

    method mostrarComoJugar(){
        console.println("todavia no esta hecho jeje")
    }

    

    
}