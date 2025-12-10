import juego.*
import vida.*
import puntuacion.*
import sonido.*
import pantallas.*

class Letras{    
    var property position = 0
    var property image
    const property letra 
    var property velocidadCaida = 0
    const property puntaje
    var property esVisible = false
    const explosion = new Sonido(cancion = "explosion2.mp3")
    const error = new Sonido(cancion = "error.mp3")
    const risa = new Sonido(cancion="perderVida.mp3")
    const aparicion = new Sonido(cancion = "aumentarCaida.mp3")
    const aumentar = new Sonido(cancion= "aumentarVida.mp3")
    const frenar = new Sonido(cancion="frenarCaida.mp3")
    var posicion = 1

    

    method caer(){ 
        /*
            hace que la letra caiga y que impacta en el submarino cuando la letra llega a la posicion Y = 7
        */
        if(esVisible){
            position = position.down(1)            
        }
        if (self.position().y() ==7){            
            self.impactar()           
        }
                     
    }

    method empezarARotar(){ 
        /*
            ejecuta el metodo rotar
        */
        game.onTick(500, "rotar"+letra, {self.rotar()})
    }

    method rotar(){ 
        /*
            hace que la letra rote 
        */
        image = letra + posicion + ".png"
        posicion += 1
        if(posicion >3){
            posicion = 0
        }
    }

    method cambiarPosicion(posicionX){ 
        /*
            ubica a la letra en la posicion:  
            X posicionX
            Y 36
        */
        position = game.at(posicionX, 36)
    }

    method impactar(){ 
        /*
            evento que se ejecuta cuando la letra llega a la posicion del submarino
        */
        if(esVisible ){
            barraDeVida.restarCantidad()        
            image = "impacto.png"
            self.explosion()
            juego.listaLetras().remove(self.letra())
            game.schedule(500, {self.removeVisual()})
            game.schedule(600,{self.cambiarPosicion(36)})
            self.ocultar()
        }
        
    }


    method ocultar(){ 
        /*
            je
        */
        esVisible = false
    }
   

    method destruir(){ 
         /*
            evento que se ejecuta cuando se apreta la tecla correspondiente a la letra
        */
        if(esVisible and juego.estaJugando()){
         juego.listaLetras().remove(self.letra())
         image = "explosion1.png"
         game.schedule(500, {self.removeVisual()})
         puntos.sumarPuntaje(puntaje)
         juego.dificultad().aumentarDificultad(puntos.numero(),controlPuntaje)
         self.explosion()
         self.ocultar()
         game.removeTickEvent("rotar"+letra)
        }   
    }

    method detener(){ 
        /*
            detiene la caida de la letra
        */
        position = position.down(0)
    }

    

    method iniciarCaida(tiempo){
        /*
            ejecuta el metodo caer, con el intervalo de tiempo *tiempo*
        */
        game.onTick(tiempo, "caida", {self.caer()})
        esVisible = true
    }

    method addVisual(){
        game.addVisual(self)        
    }

    method removeVisual(){
        game.removeVisual(self)
    }

    method explosion(){
        /*
            reproduce el sonido de explosion
        */
        explosion.cambiarVolumen(0.3)
        explosion.reproducir(false)
    }


}

class LetraNegra inherits Letras{
    override method impactar(){
            game.schedule(500, {self.removeVisual()})
            game.schedule(600,{self.cambiarPosicion(36)})
            self.ocultar()
             juego.listaLetras().remove(self.letra())
    }
    override method destruir(){
        if(esVisible and juego.estaJugando()){
            image = "perderVida1.png"
            game.schedule(1000, {self.removeVisual()})
            self.ocultar()
            risa.reproducir(false)
            risa.cambiarVolumen(0.3)
            barraDeVida.restarCantidad()
            puntos.sumarPuntaje(puntaje)
            juego.dificultad().aumentarDificultad(puntos.numero(),controlPuntaje)
            juego.listaLetras().remove(self.letra())
        }
    }
}

class LetraRoja inherits LetraNegra{
    override method destruir(){
        
        if(esVisible and juego.estaJugando()){
            image = "aumentarCaida3.png"
            game.schedule(1000, {self.removeVisual()})
            self.ocultar()
            aparicion.reproducir(false)
            aparicion.cambiarVolumen(1)
            juego.dificultad().atributos().get(2).aumentarValor()
            juego.listaLetras().remove(self.letra())
            puntos.sumarPuntaje(puntaje)                 
            juego.dificultad().aumentarDificultad(puntos.numero(),controlPuntaje)


        }
    }

}

class LetraVerde inherits LetraNegra{
    override method destruir(){
        if(esVisible and juego.estaJugando()){
            image = "aumentarVida1.png"
            game.schedule(1000, {self.removeVisual()})
            self.ocultar()
            aumentar.reproducir(false)
            aumentar.cambiarVolumen(0.5)
            barraDeVida.aumentarCantidad()
            juego.listaLetras().remove(self.letra())
            puntos.restarPuntaje(puntaje)
        }
    }
}

class LetraAmarilla inherits LetraNegra{
    override method destruir(){
        if(esVisible and juego.estaJugando()){
            image = "frenarCaida2.png"
            game.schedule(1000, {self.removeVisual()})
            self.ocultar()
            frenar.reproducir(false)
            frenar.cambiarVolumen(0.3)
            juego.dificultad().atributos().get(2).disminuirVelocidad()
            juego.listaLetras().remove(self.letra())
            puntos.restarPuntaje(puntaje)
        }
    }

    
}
