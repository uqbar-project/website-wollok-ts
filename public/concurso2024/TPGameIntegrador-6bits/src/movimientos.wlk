import wollok.game.*

class Movimiento {
    method siguiente(pos)
    method contrario()
    method siguienteCiclo()
    method imageMago()
    method imageMagoDaño()
    method imageAtaque()
    method imageGusano()
    method imageGusanoDaño()
    method imageCaracol()
    method imageCaracolDaño()
    method imageDemonio()
    method imageDemonioDaño()
}

object arriba inherits Movimiento {
    override method siguiente(pos) = pos.up(1) 
    override method contrario() = abajo
    override method siguienteCiclo() = derecha
    override method imageMago() = "magoReves.png"
    override method imageMagoDaño() = "magoRevesDaño.png"
    override method imageAtaque() = "magoRevesAtaque.png"
    override method imageGusano() = "gusanoDer.png"
    override method imageGusanoDaño() = "gusanoDerDaño.png"
    override method imageCaracol() = "caracolDer.png"
    override method imageCaracolDaño() = "caracolDerDaño.png"
    override method imageDemonio() = "demonioDer.png"
    override method imageDemonioDaño() = "demonioDerDaño.png"
}

object abajo inherits Movimiento {
    override method siguiente(pos) = pos.down(1) 
    override method contrario() = arriba
    override method siguienteCiclo() = izquierda
    override method imageMago() = "magoFrente.png"
    override method imageMagoDaño() = "magoFrenteDaño.png"
    override method imageAtaque() = "magoFrenteAtaque.png"
    override method imageGusano() = "gusanoIzq.png"
    override method imageGusanoDaño() = "gusanoIzqDaño.png"
    override method imageCaracol() = "caracolIzq.png"
    override method imageCaracolDaño() = "caracolIzqDaño.png"
    override method imageDemonio() = "demonioIzq.png"
    override method imageDemonioDaño() = "demonioIzqDaño.png"
}

object derecha inherits Movimiento {
    override method siguiente(pos) = pos.right(1)
    override method contrario() = izquierda
    override method siguienteCiclo() = abajo
    override method imageMago() = "magoDerecho.png"
    override method imageMagoDaño() = "magoDerechoDaño.png"
    override method imageAtaque() = "magoDerAtaque.png"
    override method imageGusano() = "gusanoDer.png"
    override method imageGusanoDaño() = "gusanoDerDaño.png"
    override method imageCaracol() = "caracolDer.png"
    override method imageCaracolDaño() = "caracolDerDaño.png"
    override method imageDemonio() = "demonioDer.png"
    override method imageDemonioDaño() = "demonioDerDaño.png"
}

object izquierda inherits Movimiento {
    override method siguiente(pos) = pos.left(1) 
    override method contrario() = derecha
    override method siguienteCiclo() = arriba
    override method imageMago() = "magoIzquierdo.png"
    override method imageMagoDaño() = "magoIzquierdoDaño.png"
    override method imageAtaque() = "magoIzqAtaque.png"
    override method imageGusano() = "gusanoIzq.png"
    override method imageGusanoDaño() = "gusanoIzqDaño.png"
    override method imageCaracol() = "caracolIzq.png"
    override method imageCaracolDaño() = "caracolIzqDaño.png"
    override method imageDemonio() = "demonioIzq.png"
    override method imageDemonioDaño() = "demonioIzqDaño.png"
}