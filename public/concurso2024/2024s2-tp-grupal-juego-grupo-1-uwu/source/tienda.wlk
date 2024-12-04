import wollok.game.*
import juego.*
import stats.*
import pantallas.*
import estadosJuego.*

object tienda{
    
    var property oro = 0
    const property ost = game.sound("sonido-tienda.mp3")
    const property image = "nueva-tienda.png" 
    var property position = game.at(0,0)

    method oroActual() {
        return oro.min(999)
    }

    method obtenerOro(valor) {
        game.sound("agarrar-oro.mp3").play()
        oro += valor
    }

    method restarOro(valor) {
        oro -= valor
    }

    method position() {
            return game.at(0,0)
    }

    method inicializar() {
        ost.play()
        mercadoVisible.dibujar()
        juego.estado(enTienda)
    }

    //Letra J
    method mejorarVida() { //Si Ya esta mejorado al maximo muestra fuera de stock en la tienda
        self.validarSiAlcanzaOro(50)
        self.validarSiVidaEstaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        puntosDeVida.subirMaximo()
        mejoraDeVida.animacionCompra()
        mejoraDeVida.actualizarSiLlegaAlMax()
        self.restarOro(50)  
    }

    //Letra L
    method mejorarEnergia() { //Si Ya esta mejorado al maximo muestra fuera de stock en la tienda
        self.validarSiAlcanzaOro(50)
        self.validarSiEnergiaEstaAlMax()
        barraDeEnergia.subirMaximo(3)
        barraDeEnergia.recargarMax()
        mejoraDeEnergia.animacionCompra()
        mejoraDeEnergia.actualizarSiLlegaAlMax()
        game.sound("mejora.mp3").play()
        game.sound("thank-you.mp3").play()
        self.restarOro(50)   
    }

    //letra K
    method mejorarArma() { //Si Ya esta mejorado al maximo muestra poner fuera de stock en la tienda
        self.validarSiArmaEstaAlMax()
        self.validarSiAlcanzaOro(80)
        juego.jugador().mejorarArma()
        game.sound("mejora.mp3").play()
        game.sound("good-choice.mp3").play()
        self.restarOro(80)
        mejoraDeArma.animacionCompra()   
    }

    //Validaciones
    method validarSiAlcanzaOro(precio) {
        if(oro < precio){
            game.sound("not-enough-cash.mp3").play()
            self.error("")} //No alcanza el oro
    }

    method validarSiVidaEstaAlMax() {
        if(puntosDeVida.vidaMax() == 100){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La vida esta al maximo
    }

    method validarSiEnergiaEstaAlMax() {
        if(barraDeEnergia.energiaMaxima() == 20){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //La energia esta al maximo
    }

    method validarSiArmaEstaAlMax() {
        if(not juego.jugador().quedanArmasPorMejorar()){
            game.sound("No-puede-comprar.mp3").play()
            self.error("")} //No quedan armas por mejorar
    }
}

class MejoraDeStat {
    var property image
    var property position = game.at(0,0)

    method actualizarSiLlegaAlMax()
    method animacionCompra()
}

object mejoraDeVida inherits MejoraDeStat(image = "VidaUpp.png") {

    override method actualizarSiLlegaAlMax(){
        if(puntosDeVida.vidaMax()== 100){
            game.schedule(500,{image = "VidaUpp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "VidaUpp-compra.png"
        game.schedule(500,{image = "VidaUpp.png" }) 
    }
}

object mejoraDeEnergia inherits MejoraDeStat(image = "EnergiaUpp.png") {

    override method actualizarSiLlegaAlMax(){
        if(barraDeEnergia.energiaMaxima() == 20){
            game.schedule(500,{image = "EnergiaUpp-agotado.png"}) 
        }
    }

    override method animacionCompra(){
        image = "EnergiaUpp-compra.png"
        game.schedule(500,{image = "EnergiaUpp.png" }) 
    }
}

object mejoraDeArma {
    var property image = ""
    var property position = game.at(0,0)

    method animacionCompra() {
        if (!juego.jugador().quedanArmasPorMejorar()) {
            image = juego.jugador().arma().toString() + "-compra.png"
            game.schedule(500,{image = juego.jugador().arma().toString() + "-agotado.png"})
        }
        else {
            image = juego.jugador().arma().toString() + "-compra.png"
            game.schedule(500,{image = juego.jugador().sigArma().toString() + ".png"})
        }
        
    }
}

object billetera {
    method valor() {
        return tienda.oro()
    }
    var property position = game.at(0,0)

    method visualizarCantOro() {
        game.addVisual(new Unidad(num=self))
        game.addVisual(new Decena(num=self))
        game.addVisual(new Centena(num=self))
    } 
}

class Digito {
    var property num 
    method position() {return num.position()}
    method image() 
    method digito() {return self.extraer(num.valor().toString())}
    method extraer(string) 
}

class Unidad inherits Digito() {
    override method image() {
        return "oro-der-" + self.digito() + ".png"
    }

    override method extraer(string) {
        return if(string.size() == 3) {
            string.charAt(2)
        }
        else if(string.size() == 2) {
            string.charAt(1)
        }
        else {string.charAt(0)}
    }
}   

class Decena inherits Digito() {
    override method image() {
        return "oro-med-" + self.digito() + ".png"
    }

    override method extraer(string) {
        return if(string.size() == 3) {
            string.charAt(1)
        }
        else if(string.size() == 2) {
            string.charAt(0)
        }
        else {"0"}
    }
}

class Centena inherits Digito() { 
    override method image() {
        return "oro-izq-" + self.digito() + ".png"
    }

    override method extraer(string) {
        return if(string.size() == 3) {
            string.charAt(0)
        }
        else {"0"}
    }
}