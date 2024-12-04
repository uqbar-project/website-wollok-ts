import elementos.*
object pedido {
    const property miPedidoDeBarra = new PedidoDeBarra(position = game.origin())
}

class PedidoFantasma {
    const property fantasmaAsignado

    const property image = "pedidoCafe.png"

    var property position = game.at(self.position().x()+1,self.position().y()+1)

    method reiniciarPosicion() {
        position = game.at(fantasmaAsignado.position().x()+1, fantasmaAsignado.position().y()+1)
    }
}

class PedidoDeBarra {
    const property image = "tazaDeBarra.png"
    
    var property position

    method encontrarLugarLibreEnBarra() {
        return barra.posiciones().find({p => not barra.posicionOcupada(p)})
    }
}

class TazaMesa {
    const property image = "tazaMesa.png"
    
    var property position
}