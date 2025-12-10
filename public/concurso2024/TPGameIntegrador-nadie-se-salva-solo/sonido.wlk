class Sonido{
    const cancion
    const property sonido = game.sound(cancion)
    var sonando = false

    method reproducir(loop){
        if (!sonando){
            sonido.play()
            sonido.shouldLoop(loop)
        }
    }

    method parar(){
        sonido.stop() 
        sonando = false
    }
    method cambiarVolumen(unNumero){
        sonido.volume(unNumero)
    } 
}