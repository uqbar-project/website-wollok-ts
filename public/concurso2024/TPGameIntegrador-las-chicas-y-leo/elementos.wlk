import wollok.game.*
import clientes.*

// este script contiene TODOS los elementos visuales que aparecerán en nuestro videojuego

// DEFINICION DE CLASES PARA LOS OBJETOS A UTILIZAR

class SillaIzq {

    const property position

    method estaOcupada() {
        return cliente.fantasmasVisibles().any({f => f.position() == self.position()})
    }

    method orientacion() = "izquierda"

    method image() = "restauranteSillaIzquierda.png"
}
class SillaDer {

    const property position
    
    method estaOcupada() {
        return cliente.fantasmasVisibles().any({f => f.position() == self.position()})
    }

    method orientacion() = "derecha"

    method image() = "restauranteSillaDerecha.png"
}
class MesaIzq { 
    const property position
    method image() = "restauranteMesaIzq.png"
}

class MesaDer {
    const property position
    method image() = "restauranteMesaDer.png"
}

object barra {
    method position() = game.at(1, 9)

    method posiciones() = [game.at(2, 9), game.at(3, 9), game.at(4, 9), game.at(5, 9), game.at(6, 9), game.at(7, 9), game.at(8, 9), game.at(9, 9)]

    method image() = "unaBarra.png"

    method hayBarra(unaPosicion) {
        return self.posiciones().any({p => p == unaPosicion})
    }

    method posicionOcupada(unaPosicion) {
        return not game.getObjectsIn(unaPosicion).isEmpty()
    }
}

class Antorcha {

    const property position

     method image() = "laAntorcha.gif"

}

object elementoSolido {
    // CREACIÓN DE LOS OBJETOS A UTILIZAR

    const property todosLosElementosSolidos = [sillaDer1, sillaIzq1, mesaIzq1, mesaDer1, sillaDer2, sillaIzq2, mesaIzq2, mesaDer2, sillaDer3, sillaIzq3, mesaIzq3,mesaDer3,
                                    sillaDer4, sillaIzq4, mesaDer4, mesaIzq4, sillaDer5, sillaIzq5, mesaIzq5, mesaDer5, barra, antorcha1, antorcha2, antorcha3, antorcha4]
    // esta lista contendrá TODOS los objetos que añadiremos VISUALMENTE a la escena

    // lista posiciones sillas
    const property posicionesSillas = todasLasSillas.map({s => s.position()})

    const property todasLasSillas = [sillaDer1, sillaIzq1, sillaDer2, sillaIzq2,
    sillaDer3, sillaIzq3, sillaDer4, sillaIzq4,
    sillaDer5, sillaIzq5]

    // MESA 1
    const sillaDer1 = new SillaIzq(position = game.at(3,3))
    const sillaIzq1 = new SillaDer(position = game.at(6,3))
    const mesaIzq1 = new MesaIzq(position = game.at(4,3))
    const mesaDer1 = new MesaDer(position = game.at(5,3))

    // MESA 2
    const sillaDer2 = new SillaIzq(position = game.at(11,3))
    const sillaIzq2 = new SillaDer(position = game.at(14,3))
    const mesaIzq2 = new MesaIzq(position = game.at(12,3))
    const mesaDer2 = new MesaDer(position = game.at(13,3))

    // MESA 3
    const sillaDer3 = new SillaIzq(position = game.at(7,5))
    const sillaIzq3 = new SillaDer(position = game.at(10,5))
    const mesaIzq3 = new MesaIzq(position = game.at(8,5))
    const mesaDer3 = new MesaDer(position = game.at(9,5))

    // MESA 4
    const sillaDer4 = new SillaIzq(position = game.at(3,7))
    const sillaIzq4 = new SillaDer(position = game.at(6,7))
    const mesaIzq4 = new MesaIzq(position = game.at(4,7))
    const mesaDer4 = new MesaDer(position = game.at(5,7))

    // MESA 5
    const sillaDer5 = new SillaIzq(position = game.at(11,7))
    const sillaIzq5 = new SillaDer(position = game.at(14,7))
    const mesaIzq5 = new MesaIzq(position = game.at(12,7))
    const mesaDer5 = new MesaDer(position = game.at(13,7))

    const antorcha1 = new Antorcha(position = game.at(0,3))
    const antorcha2 = new Antorcha(position = game.at(0,7))
    const antorcha3 = new Antorcha(position = game.at(17,3))
    const antorcha4 = new Antorcha(position = game.at(17,7))
}