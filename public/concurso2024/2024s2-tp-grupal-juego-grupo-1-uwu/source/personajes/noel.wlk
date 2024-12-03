import personaje.*
import wollok.game.*
import posiciones.*
import armas.*
import proyectiles.*


object noel inherits Personaje(arma=pistola, armas = [doblePistolas,escop,escopetaPlateadas]) {
   
    var property ultimaDir = derecha

    override method mover(dir) {
        super(dir)
        ultimaDir = dir
    }

    override method ataque(dir) {
        super(dir)
        ultimaDir = dir
    }

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-noel.png"
    }

    override method visualAmmo(){
        return "variasBalas.png"
    }

//-----------ataque-movimiento--------------------------------

    override method imagenInicial(){
        return "noel-" + arma.toString() + "-normal-arriba.png"
    }
   
    override method imagenAtaque(direccion) {
        return "noel-" + arma.toString() + "-ataque-" + direccion.toString() + ".png"
    }

    override method imagenNormal(direccion) {
        return "noel-" + arma.toString() + "-normal-" + direccion.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("tiro1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("noel-muerte-sonido.mp3").play()
    }
    

    override method sonidoHerida(){
        game.sound("sonido-muerte-noel.mp3").play()
    }

//------------hud-------------------------------------------

        override method sinMunicion(){
        game.sound("sin-balas.mp3").play()
    }

    method sonidoRecarga(){
        arma.sonidoRecarga()
    }

//-------------------especial------------------------


    override method lanzarEspecial() {
        const baston = new Baston(position=self.ultimaDir().siguientePosicion(position), image="baston-"+self.ultimaDir()+".png")
        game.addVisual(baston)
        baston.nuevoViaje(ultimaDir)
        self.sonidoEspecial()
    }

    override method sonidoEspecial() {
      game.sound("noel-Especial.mp3").play()
    }
}




