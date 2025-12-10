import wollok.game.*
import pantallas.*
import clases.*
import direcciones.*
import hechizos.*
import personajes.*

object juego {
    var enJuego = false
    var jugador = arquero
    const enemigos = []
    var aranias = 1
    var orcos = 2
    var enemigosPorGenerar = aranias + orcos
    var puedeAtacar = true

    method enJuego() = enJuego

    method puedeAtacar() = puedeAtacar

    method jugador() = jugador

    method cambiarJugador(nuevoJugador) {
        jugador = nuevoJugador
    }

    method generarArania() {
        const arania = new Arania(vida = 2, image= "arania.png")
        enemigos.add(arania)
        game.addVisualCharacter(arania)
        aranias = (aranias - 1).max(0)
    }

    method generarOrco() {
        const orco = new Orco(vida = 2, image= "orco.png")
        enemigos.add(orco)
        game.addVisualCharacter(orco)
        orcos = (orcos - 1).max(0)
    }

    method generarEnemigo() {
        if (enemigosPorGenerar > 0 and aranias > 0) {
            self.generarArania()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }else if(enemigosPorGenerar > 0 and orcos > 0){  
            self.generarOrco()
            enemigosPorGenerar = (enemigosPorGenerar - 1).max(0)
        }
    }

    method moverEnemigos() {
        enemigos.copy().forEach({ enemigo => enemigo.moverAleatoriamente() })
    }

    method atacarEnemigos() {
        enemigos.forEach({ enemigo =>
            const ataque = new Hechizo(esMalvado = true, image = enemigo.poder())
            ataque.lanzar(enemigo)
            game.onCollideDo(ataque, { victima => victima.recibirAtaque(ataque) })
        })
    }

    method atacarJefe() {
        if (jefe.estaVivo()) {
            const bolaDeFuegoVerde = new BolaDeFuegoVerde(esMalvado = true, image = jefe.poder())
            bolaDeFuegoVerde.lanzar(jefe)
            game.onCollideDo(bolaDeFuegoVerde, { victima => victima.recibirAtaque(bolaDeFuegoVerde) })
        }
    }

    method removerEnemigo(enemigo) {
        game.removeVisual(enemigo)
        enemigos.remove(enemigo)
        self.verificarPasoDeNivel()
    }

    method verificarPasoDeNivel() {
        const enemigosVivos = enemigos.filter({ e => e.estaVivo() })
        if (enemigosVivos.size() == 0) {
            game.schedule(3000, {self.pasarDeNivel()})
        }
    }

    method pasarDeNivel() {
        pantallas.barraDeVida().removerVisual()
        game.removeVisual(jugador)
        pantallas.juego().removerVisual()
        pantallas.nivel2().agregarVisual()
         keyboard.enter().onPressDo{
            pantallas.nivel2().removerVisual()
            pantallas.juego().agregarVisual()
            pantallas.barraDeVida().agregarVisual()
            game.addVisualCharacter(jugador)
            jugador.darVida()
            enemigos.clear()
            enemigos.add(jefe)
            game.addVisualCharacter(jefe)
            game.removeTickEvent("atacarEnemigos")
            game.onTick(2000, "atacarJefe", { self.atacarJefe() })
        }
    }

    method limpiarVisualesFinales() {
        game.clear() //limpia todo
        self.detenerEventos()
    }

    method detenerEventos() {
        enJuego = false
        game.removeTickEvent("generarEnemigo")
        game.removeTickEvent("moverEnemigos")
        game.removeTickEvent("atacarEnemigos")
    }

    method finDelJuego() {
        if (!jefe.estaVivo()) {
            self.detenerEventos()
            pantallas.nivel2().removerVisual()
            self.limpiarVisualesFinales()
            pantallas.victoria().agregarVisual()
            game.schedule(4000, {
                pantallas.victoria().removerVisual()
                pantallas.creditos().agregarVisual()
                game.schedule(4000, {
                    pantallas.creditos().removerVisual()
                    self.reiniciarJuego()
                })
            })
        }
    }

    method iniciarMenu() {
        pantallas.inicio().agregarVisual()

        keyboard.enter().onPressDo({
            if (pantallas.inicio().hasVisual()) {
                pantallas.inicio().removerVisual()
                pantallas.seleccion().agregarVisual()
            }
        })

        keyboard.u().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(arquero)
                self.mostrarInstrucciones()
            }
        })

        keyboard.i().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(barbaro)
                self.mostrarInstrucciones()
            }
        })

        keyboard.o().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(guerrero)
                self.mostrarInstrucciones()
            }
        })

        keyboard.p().onPressDo({
            if (pantallas.seleccion().hasVisual()) {
                self.cambiarJugador(mago)
                self.mostrarInstrucciones()
            }
        })

        keyboard.q().onPressDo({
            if (!pantallas.inicio().hasVisual()) {
                self.reiniciarJuego()
            }
        })
    }

    method iniciar() {
        game.clear()
        enJuego = true
        puedeAtacar = true
        pantallas.seleccion().removerVisual()
        pantallas.juego().agregarVisual()
        pantallas.barraDeVida().agregarVisual()
        game.addVisualCharacter(jugador)
        pantallas.barraDeVida().actualizarse(jugador)
       
        keyboard.w().onPressDo({ jugador.moverseHacia(norte) })
        keyboard.s().onPressDo({ jugador.moverseHacia(sur) })
        keyboard.a().onPressDo({ jugador.moverseHacia(oeste) })
        keyboard.d().onPressDo({ jugador.moverseHacia(este) })
        keyboard.i().onPressDo({ self.mostrarInstrucciones() })
        //Reinicar el juego, durante la batalla
        keyboard.q().onPressDo({ if (!pantallas.inicio().hasVisual()) { self.reiniciarJuego() } })
        keyboard.j().onPressDo({
            if (game.hasVisual(jugador) and self.puedeAtacar() and self.enJuego()) {
                puedeAtacar = false
                const poder = new Hechizo(esMalvado = false)
                poder.lanzar(jugador)
                game.onCollideDo(poder, { victima => victima.recibirAtaque(poder) })
                game.schedule(1000,{puedeAtacar = true})
            }
        })

        if (enemigosPorGenerar > 0) {
            game.onTick(1000, "generarEnemigo", { self.generarEnemigo() })
        }
        
        if(self.enJuego()) {
            game.onTick(1500, "moverEnemigos", { self.moverEnemigos() })
            game.onTick(3000, "atacarEnemigos", { self.atacarEnemigos() })
        }
        
    }

    method mostrarInstrucciones() {
        pantallas.instrucciones().agregarVisual()
        game.schedule(4000, {
            pantallas.instrucciones().removerVisual()
            self.iniciar()
        })
    }

    method gameOver() {
        self.detenerEventos()
        self.limpiarVisualesFinales()
            //jefe.removerVisual()
            pantallas.gameOver().agregarVisual()
            game.schedule(4000, {
                pantallas.gameOver().agregarVisual()
                pantallas.creditos().agregarVisual()
                game.schedule(4000, {
                    self.reiniciarJuego()
                })
            })
    }

    method reiniciarJuego() {
        self.detenerEventos()
        game.clear()
        jefe.restaurar()
        jugador.restaurar()
        enemigos.clear()
        aranias = 1
        orcos = 2
        enemigosPorGenerar = aranias + orcos
        self.iniciarMenu()
    }

}