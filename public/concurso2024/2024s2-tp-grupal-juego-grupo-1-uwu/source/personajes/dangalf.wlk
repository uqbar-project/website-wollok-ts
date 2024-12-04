import proyectiles.*
import wollok.game.*
import posiciones.*
import armas.*
import personaje.*

object dangalf inherits Personaje(arma=dosManoss, armas=[tresManoss,cuatroManoss]) {

//-------------items------------------------------------------

    override method cura(numero){
        return "cura" + numero + "-mago.png"
    }

    override method visualAmmo(){
        return "potion.png"
    }

//-----------ataque-movimiento--------------------------------

    

    override method imagenInicial(){
        return "dangalf-" + arma.toString() + "-normal-abajo.png"
    }

    override method imagenAtaque(dir) {
        return "dangalf-" + arma.toString() + "-ataque-" + dir.toString() + ".png"
    }

    override method imagenNormal(dir) {
        return "dangalf-" + arma.toString() + "-normal-" + dir.toString() + ".png"
    }

    method especial(){}

    override method sonidoAtaque(){
        game.sound("magia1.mp3").play()
    }

    method sonidoMuerte(){
        game.sound("wizard-death.mp3").play()
    }

    override method sonidoHerida(){
        game.sound("sonido-muerte-noel.mp3").play()
    }

//------------hud-------------------------------------------
    
    override method sinMunicion(){
        game.sound("mago-sin-municion.mp3").play()
    }

    method sonidoRecarga(){
        arma.sonidoRecarga()
    }

//-----------especial---------------------------------------

    override method lanzarEspecial() {
        self.sonidoEspecial()
        self.dispararEspecialHacia(abajo)
        self.dispararEspecialHacia(arriba)
        self.dispararEspecialHacia(derecha)
        self.dispararEspecialHacia(izquierda)
    }

    method dispararEspecialHacia(direccion) {
        const rayo = new BolaEnergia(position=direccion.siguientePosicion(position))
        game.addVisual(rayo)
        rayo.nuevoViaje(direccion)
    }

    override method sonidoEspecial() {
      game.sound("dangalf-Especial.mp3").play()
    }
}