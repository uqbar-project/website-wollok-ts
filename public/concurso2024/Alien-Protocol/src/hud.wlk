import wollok.game.*
import Personajes.personaje.*

object hudVidas{
    var property imagenVida = "vida3.png"
    const property esObstaculo = false
    
    method image() = imagenVida
    method position() = game.at(1,1)

    method actualizar(vidas){
        if(vidas == 3) imagenVida = "vida3.png"
        if(vidas == 2) imagenVida = "vida2.png"
        if(vidas == 1) imagenVida = "vida1.png"
        if(vidas == 0) imagenVida = "vida0.png"
    }  
}

object hudMunicion{
    var property imagenMunicion = "infinito.png" 
    const property esObstaculo = false

    method image() = imagenMunicion
    method position() = game.at(1,2)

    method actualizar(arma){
        if(arma.esPistola()){
            imagenMunicion = "infinito.png"
        }else{
            imagenMunicion = arma.municion().toString()+".png"
        }
    }
}

object hudMejora{
    var property imagenMejora = null
    const property esObstaculo = false

    method image() = imagenMejora
    method position() = game.at(2,2)

    method actualizar(arma){
        if (arma.mejorada()){
            imagenMejora = "mejora.png"
        } else{
            imagenMejora = null
        }
    }
}

object objetoGameOver{
    var property image = "gameOver.png" 
    var property esObstaculo = false

    method position() = game.at(0,0)
    method isOverlay() = true
}

object finBueno{
    var property image = "victoria.png" 
    var property esObstaculo = false

    method position() = game.at(0,0)
    method isOverlay() = true
}

