import juego.*
import Boxeadores.*
import imagenYSonido.*
//Pantallas
class Pantalla {
    method mostrar()
    method puedoTocarTeclaDeTransicion() = gestorPantallas.pantallaActual() == self && !gestorPantallas.transicionEnProgreso()
}

object pantallaCarga inherits Pantalla {
    override method mostrar() {
        gestorImagenes.mostrarPantallaCarga()

        keyboard.enter().onPressDo {
            if(!self.puedoTocarTeclaDeTransicion()) {self.error("") }
            gestorPantallas.transicionEnProgreso(true)
            gestorPantallas.mostrarPantalla(pantallaMenu)
        }
    }
}

object pantallaMenu inherits Pantalla {
    override method mostrar() {
        gestorImagenes.mostrarMenu()
        gestorSonidos.musicaMenu()

        //Controles de pantalla
        keyboard.enter().onPressDo {
            if(!self.puedoTocarTeclaDeTransicion()) {self.error("") }
            gestorPantallas.transicionEnProgreso(true)
            gestorSonidos.sonidoEnter()
            game.schedule(1200, {self.romperTitulo()})
        }
    }

    method romperTitulo() {
        gestorImagenes.mostrarMenu2()
        gestorSonidos.sonidoTituloRoto()
        game.schedule(2000, {
                gestorPantallas.mostrarPantalla(pantallaDificultad)
            })
    }
}

object pantallaDificultad inherits Pantalla {
    var nivelElegido = null

    method cargarNivel() {
        gestorSonidos.sonidoEnter()
        game.schedule(1000, {
            pantallaNivel.tipoNivel(nivelElegido)
            gestorPantallas.mostrarPantalla(pantallaNivel)
        })
    }
    override method mostrar() {
        gestorImagenes.mostrarMenuDificultad()
        gestorSonidos.musicaDificultad()

        //Controles de pantalla
        keyboard.num1().onPressDo ({
            if(!self.puedoTocarTeclaDeTransicion()) {self.error("") }
            gestorPantallas.transicionEnProgreso(true)
            nivelElegido = nivel1
            self.cargarNivel()
        })
        keyboard.num2().onPressDo ({
            if(!self.puedoTocarTeclaDeTransicion()) {self.error("") }
            gestorPantallas.transicionEnProgreso(true)
            nivelElegido = nivel2
            self.cargarNivel()
        })
        keyboard.num3().onPressDo ({
            if(!self.puedoTocarTeclaDeTransicion()) {self.error("") }
            gestorPantallas.transicionEnProgreso(true)
            nivelElegido = nivel3
            self.cargarNivel()
        })
    }
}

object pantallaVictoria inherits Pantalla {
    method todosLosNivelesGanados() = nivel1.estaGanado() && nivel2.estaGanado() && nivel3.estaGanado()

    override method mostrar() {
        gestorSonidos.musicaVictoria()

        if(self.todosLosNivelesGanados()) {
            gestorImagenes.mostrarPantallaVictoria2()
            game.schedule(4400, {gestorPantallas.mostrarPantalla(pantallaFinal)})
        } else{
            gestorImagenes.mostrarPantallaVictoria()
            game.schedule(4400, {gestorPantallas.mostrarPantalla(pantallaDificultad)})
        }
    }
}

object pantallaFinal inherits Pantalla {
    override method mostrar() {
        gestorImagenes.mostrarPantallaFinal()
        gestorSonidos.musicaFinal()

        game.schedule(9000, {
            gestorSonidos.pararMusica()
        })
    }
}

object pantallaDerrota inherits Pantalla {
    override method mostrar() {
        gestorImagenes.mostrarPantallaDerrota()
        gestorSonidos.musicaDerrota()
        game.schedule(5000, {
            gestorPantallas.mostrarPantalla(pantallaDificultad)
        })
    }
}

object pantallaNivel inherits Pantalla {
    var property tipoNivel = nivel1
    var property boxeadorRival = null
    const accionesRival = []
    var pantallaFinal = null
    var hayPermisoEspecial = false

    override method mostrar() {
        tipoNivel.mostrarPantallaVersus()
        gestorSonidos.musicaComienzaNivel()
        game.schedule(4000, {self.iniciarNivel()})
    }
    
    method iniciarNivel() {
        boxeadorRival = tipoNivel.rival()

        self.limpiarVisuales()
        boxeadorJugador.reiniciar()
        boxeadorRival.reiniciar()
        mario.reiniciar()

        tipoNivel.mostrarRing()
        game.addVisual(boxeadorRival)
        game.addVisual(boxeadorJugador)
        game.addVisual(vidaJugador)

        if(!mario.sePuedePelear() && boxeadorRival.vida() == 100 && boxeadorJugador.vida() == 100){
            game.addVisual(mario)
            game.schedule(1000, {mario.contar()})
        }

        vidaOponente.oponente(boxeadorRival)
        game.addVisual(vidaOponente)

        accionesRival.clear()
        accionesRival.addAll(tipoNivel.accionesRival())

        gestorSonidos.musicaPelea()

        // Establecer rival del jugador
        boxeadorJugador.rival(boxeadorRival)
        boxeadorJugador.poder(tipoNivel.poderJugador())

        //Inicia la IA del rival y permiso de ataque especial
        self.iniciarIARival()
        self.iniciarPermisoEspecial()

        //Controles de pantalla
        keyboard.z().onPressDo {  
            if(gestorPantallas.pantallaActual() != self || !mario.sePuedePelear() || !boxeadorJugador.estaQuieto()) {self.error("") }   
            
            const rivalSeCubre = (0.randomUpTo(3)).round()
            if(rivalSeCubre > 1) {boxeadorRival.cubrirse()}
            boxeadorJugador.atacar()
        }
        keyboard.x().onPressDo {
            if(gestorPantallas.pantallaActual() != self || !mario.sePuedePelear()) {self.error("") }
            boxeadorJugador.cubrirse()
        }
        keyboard.c().onPressDo {
            if(gestorPantallas.pantallaActual() != self || !mario.sePuedePelear() || !self.jugadoPuedeAtacarEspecial()) {self.error("") }
            boxeadorJugador.atacarEspecial()
        }
    }

    method iniciarPermisoEspecial(){
        game.onTick(4000, "permisoEspecial", {if(talvez.seaCierto(tipoNivel.probabilidadPermisoEspecial())) {self.darPermisoEspecial()}})
    }

    method darPermisoEspecial(){
        hayPermisoEspecial = true
        game.addVisual(imgAtaqueEspecial)
        gestorSonidos.sonidoAlertaEspecial()
        game.schedule(2000, {hayPermisoEspecial = false game.removeVisual(imgAtaqueEspecial)})
    }

    method jugadoPuedeAtacarEspecial() = hayPermisoEspecial && boxeadorJugador.estaQuieto()

    //IA del rival

    method iniciarIARival() {
        game.onTick(1000, "iaRival", {
            if (self.ambosConVida() && mario.sePuedePelear() && boxeadorRival.estaQuieto()) {
                self.decidirAccionDelRival()
            }
        })
    }


    method decidirAccionDelRival(){
        if(boxeadorRival.vida() <= 0) {boxeadorRival.estado(derrota) self.error("") } 
        accionesRival.findOrDefault({a => a.esEjecutable()}, accionDescansar).ejecutar(boxeadorRival)
    }

    // Método para verificar la vida de ambos boxeadores

    method ambosConVida() = boxeadorRival.vida() > 0 && boxeadorJugador.vida() > 0
    
    method verificarVida() {
        if (!self.ambosConVida()) {
            self.determinarGanador()
            gestorSonidos.sonidoCampana()
            game.removeTickEvent("permisoEspecial")
            game.onTick(500, "tribunaAlocada", {tribunaLoca.alocarse()})
            gestorSonidos.pararMusica()
            gestorSonidos.sonidoTribuna()

            game.schedule(4500,
               {self.reiniciarNivel()}
            )
        }
    }

    method determinarGanador() {
        if (boxeadorRival.vida() <= 0) {
            boxeadorJugador.estado(victoria)
            boxeadorRival.estado(derrota)
            boxeadorRival.position(game.at(6,5))
            pantallaFinal = pantallaVictoria
            tipoNivel.estaGanado(true)
        } else if (boxeadorJugador.vida() <= 0) {
            boxeadorJugador.estado(derrota)
            boxeadorRival.estado(victoria)
            pantallaFinal = pantallaDerrota
        }
    }

    method reiniciarNivel(){
        if(gestorPantallas.pantallaActual() != self || !mario.sePuedePelear()) {self.error("") } 
        game.removeTickEvent("iaRival")
        game.removeTickEvent("tribunaAlocada")
        game.removeTickEvent("permisoEspecial")
        mario.reiniciar()
        self.limpiarVisuales()
        gestorPantallas.mostrarPantalla(pantallaFinal)
    }

    method limpiarVisuales() {
        game.removeVisual(boxeadorJugador)
        game.removeVisual(boxeadorRival)
        game.removeVisual(vidaJugador)
        game.removeVisual(vidaOponente)
        game.removeVisual(tribunaLoca)
    }
}

object nivel1{
    var property estaGanado = false
    method rival() = joe
    method mostrarPantallaVersus() {gestorImagenes.mostrarVersusJoe()}
    method accionesRival() = [new AccionAtacar(probabilidad=35), new AccionCubrirse(probabilidad=25)]
    method mostrarRing() {gestorImagenes.mostrarRing1()}
    method poderJugador() = 20
    method probabilidadPermisoEspecial() = 30
}

object nivel2 {
    var property estaGanado = false
    method rival() = rocky
    method mostrarPantallaVersus() {gestorImagenes.mostrarVersusRocky()}
    method accionesRival() = [new AccionAtacar(probabilidad=45), new AccionCubrirse(probabilidad=25), new AccionAtacarEspecial(probabilidad=5)]
    method mostrarRing() {gestorImagenes.mostrarRing2()}
    method poderJugador() = 10
    method probabilidadPermisoEspecial() = 28
}

object nivel3 {
    var property estaGanado = false
    method rival() = tyson
    method mostrarPantallaVersus() {gestorImagenes.mostrarVersusTyson()}
    method accionesRival() = [new AccionAtacar(probabilidad=80), new AccionCubrirse(probabilidad=5), new AccionAtacarEspecial(probabilidad=30)]
    method mostrarRing() {gestorImagenes.mostrarRing3()}
    method poderJugador() = 5
    method probabilidadPermisoEspecial() = 20
}

object talvez {
    method seaCierto(porcentaje) = (0.randomUpTo(1) * 100) < porcentaje
}

//Acciones del rival para la IA
class AccionRival {
    var probabilidad

    method ejecutar(boxeadorRival)

    method esEjecutable() = talvez.seaCierto(probabilidad)
}

class AccionAtacar inherits AccionRival {
    override method ejecutar(boxeadorRival) {
        boxeadorRival.prepararGolpe(1)
    }
}

class AccionAtacarEspecial inherits AccionRival {
    override method ejecutar(boxeadorRival) {
        boxeadorRival.prepararGolpe(2)
    }
}


class AccionCubrirse inherits AccionRival {
    override method ejecutar(boxeadorRival) {
        boxeadorRival.cubrirse()
    }
}

object accionDescansar inherits AccionRival {
    method initialize(){
        probabilidad = 100
    }

    override method ejecutar(boxeadorRival) {
        boxeadorRival.descansar()
    }
}

//Vidas

object vidaJugador {
  method position() = game.at(2, 13)
  method image() = "vida" + boxeadorJugador.vida() + ".png"
}

object vidaOponente {
    var property oponente = joe
    method position() = game.at(13, 13)
    method image() = "vida" + self.oponente().vida() + ".png"
}