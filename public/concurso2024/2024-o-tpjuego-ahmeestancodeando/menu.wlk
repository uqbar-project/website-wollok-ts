import administradorDeEnemigos.*


import administradorDeMagos.*
import magos.*
import cursor.*
import wollok.game.*
import pala.*
import administradorDeJuego.administradorDeJuego
import administradorDeJuego.pantalla

// ===============================
// Menú: Control y acciones del menú
// ===============================
object menu {
    // Propiedades y posición
    var position = new MutablePosition(x = -1, y = 5)

    // Métodos públicos
    method position() = position
    method image() = "marcosRojo.png"

    // Métodos de sonido
    method pop() = game.sound("m.pop.mp3")
    method pff() = game.sound("m.pff.mp3")


    // Acción del menú: Configura las teclas
    method accion() {
        keyboard.d().onPressDo({ if(!game.hasVisual(pantalla) && !administradorDeJuego.usuarioEnMenu()){self.moverseDerecha() }})
        keyboard.a().onPressDo({ if(!game.hasVisual(pantalla) && !administradorDeJuego.usuarioEnMenu()){self.moverseIzquierda()} })
        keyboard.enter().onPressDo({  if(!game.hasVisual(pantalla) && !administradorDeJuego.usuarioEnMenu()){self.seleccionarMenu()}})
        // cambiar aca para cambiar forma de generar enemigos
    }
    
    // Movimiento del menú
    method moverseDerecha() = if (self.position().x() < 6) position.goRight(1)
    method moverseIzquierda() = if (self.position().x() > 0) position.goLeft(1)

    // Detecta si se está seleccionando pala
    method seleccionandoPala() = self.position().x() == pala.position().x()

    // Generación y eliminación de magos
    method seleccionarMenu() {
        const magoAGenerar = game.colliders(self) // no usamos uniqueColliders porque tira error si no hay ninguna
        const objetoCelda = game.colliders(cursor)
        const posicionCelda = new MutablePosition(x = cursor.position().x(), y = cursor.position().y())

        if (!magoAGenerar.isEmpty() && objetoCelda.all({ objeto => objeto.sePuedeSuperponer() }) && !self.seleccionandoPala()) {
            self.generarMago(magoAGenerar.first(), posicionCelda)
      
        } 
        else if (self.seleccionandoPala()) {
            self.eliminarMago( objetoCelda.find({ objeto => not objeto.sePuedeSuperponer() }))
        }
    }

    method generarMago(magoSeleccionado,posicionCelda){
        administradorDeMagos.generarMago(magoSeleccionado, posicionCelda)
        self.pop().volume(0.2)
        self.pop().play()
    }

    method eliminarMago(magoSeleccionado){
        pala.eliminarMago(magoSeleccionado)
        self.pff().volume(0.2)
        self.pff().play()
    }

    // Tienda: Inicialización de los magos
    method iniciarTienda() {
        position= new MutablePosition(x = 0, y = 5)
        // Añadiendo los magos disponibles en la tienda
        game.addVisual(magoPiedraTienda)
        game.addVisual(magoFuegoTienda)
        game.addVisual(magoIrlandesTienda)
        game.addVisual(magoHieloTienda)
        game.addVisual(magoExplosivoTienda)
        game.addVisual(magoStopTienda)
        // Añadiendo la pala a la tienda
        game.addVisual(pala)
    }
    method finalizarTienda(){
        game.removeVisual(magoPiedraTienda)
        game.removeVisual(magoFuegoTienda)
        game.removeVisual(magoIrlandesTienda)
        game.removeVisual(magoHieloTienda)
        game.removeVisual(magoExplosivoTienda)
        game.removeVisual(magoStopTienda)
        // Añadiendo la pala a la tienda
        game.removeVisual(pala)
        position= new MutablePosition(x = -1, y = 5)
    }
}
