import wollok.game.*
import administracion.*
import objetos.*
import gestorSonido.*
import niveles.*


//*==========================| Clases de Entidades |==========================
class EntidadBasica { 
    var property position
    var property image
    var property esPisable
    
    method esMovible(direccion) = false

    method objetosDelanteHacia(direccion) = game.getObjectsIn(direccion.siguiente(position))

}

class EntidadQuePuedeEmpujar inherits EntidadBasica {
    method empujar(direccion) {
        game.getObjectsIn(position)
            .filter { objeto => objeto != self && objeto.esMovible(direccion)}
            .forEach { objMovible => objMovible.empujar(direccion)}
    }
    
    override method esMovible(direccion) = 
        tablero.estaDentroDelTablero(direccion.siguiente(position))
        &&
        self.objetosDelanteHacia(direccion).all {
            objeto => objeto.esMovible(direccion) || objeto.esPisable()
    }
}
class EntidadQueReacciona inherits EntidadBasica {
    method reaccionar()
}

//*==========================|Clases de Bloques|==========================
class Roca inherits EntidadQuePuedeEmpujar {
    var property puedeMoverse
    
    override method esMovible(direccion) =
        puedeMoverse && super(direccion)


    override method empujar(direccion) {
        position = direccion.siguiente(position)
        super(direccion)
    }
}

class Palabra inherits EntidadQueReacciona {
    const palabra
    
    override method reaccionar() {
        motorDeFrases.construirFrase(palabra)
        gestorSonido.sonidoBoton()
    }
}

class Muro inherits EntidadQueReacciona {
    override method reaccionar(){ }
}

class Puerta inherits EntidadQueReacciona {
    var property esAbierta = false

    override method reaccionar() {
        if(esAbierta){
        gestorNiveles.subirDeNivel()
        gestorSonido.sonidoCruzarPuerta()
        }
    }
}

class Agua inherits EntidadQueReacciona {
    var property esCaminable = false

    override method reaccionar() {
        if(not(esCaminable)){
        gestorNiveles.perder()
        }
    }

    method evaporar() {
      game.removeVisual(self)
    }
}
//*==========================| UI |==========================
class Mensaje {
	const property position = game.center()
	const property image
}