import wollok.game.*
import direcciones.*
import jugador.*
import administracion.*
import entidadBasicas.*
import niveles.*
import gestorSonido.*
//*=========================| Gestores de Reglas |==========================


object motorDeFrases {
    var property fraseHastaAhora = []


    method procesarFraseCuandoEsValida(frase) {
        if (gestorNiveles.frasesDelNivelActual().contains(frase)) {
            interprete.aplicarRegla(frase)
            gestorSonido.sonidoFraseFormada()

        }
        //podría hacer que pierda
    }

    method construirFrase(palabra) {
      fraseHastaAhora.add(palabra)
      self.procesarFraseCuandoEstaCompleta()
    }

    method procesarFraseCuandoEstaCompleta() {
        if (fraseHastaAhora.size() == 3) {
            const frase = fraseHastaAhora.join(" ")
            self.procesarFraseCuandoEsValida(frase)
            fraseHastaAhora.clear()
        }
    }

    method limpiarFraseHastaAHora() {
      fraseHastaAhora = []
    }
}
object interprete {
    const estados = #{puertaAbierta, muroPisable, rocaMovible, aguaEvaporar, muroSonPuertas,rocaSonPuertas,puertaSonMuros,puertaPisable,puertasSonRocas,puertaEsEmpujable,aguaSonPuertas,puertasSonAgua,aguaEsCaminable,murosSonRocas}
    
    method estadoDe(frase) = estados.find{ estado => frase == estado.frase() }

    method aplicarRegla(frase) {
      self.estadoDe(frase).ejecutar()
    } 
}
object visorDePlabras {

    const property position = game.at(5, 10) 

    method text() = "frase : " + motorDeFrases.fraseHastaAhora().join(" ")

    method textColor() = '#FFFFFF'
}

//*==========================| Estados para Cambios |==========================

object aguaSonPuertas {
    const property frase = "Water Is Door"
    method ejecutar() {
      registroDeObjetos.aguas().forEach({agua => const puerta = new Puerta(position = agua.position(), image = "puertaCerrada.png", esPisable = false) 
                                            registroDeObjetos.agregarPuerta(puerta)
                                            game.addVisual(puerta)
                                            registroDeObjetos.aguas().remove(agua)
                                            game.removeVisual(agua)
                                                    })
    }
  
}

object aguaEsCaminable {
    const property frase = "Water Is Walkable"
    method ejecutar() {
      registroDeObjetos.aguas().forEach({agua => agua.esCaminable(true)})
    }
  
}
object puertaEsEmpujable {
    const property frase = "Door Is Push"
    
    method ejecutar() {
      game.say(jugador, "No son empujables, pero las rocas si ;)")
    }
  
}
object aguaEsEmpujable {
    const property frase = "Water Is Push"
    
    method ejecutar() {
      game.say(jugador, "No es empujable, ¿como se empuja el agua?")
    }
  
}

object puertaPisable {
    const property frase = "Door Is Walkable"
    
    method ejecutar() {
      registroDeObjetos.puertas().forEach { puerta => puerta.esPisable(true)}
      jugador.recargar()
    }
  
}
object muroSonPuertas {
    const property frase = "Wall Is Door"

  method ejecutar() {
        
        registroDeObjetos.muros().forEach({muro => const puerta = new Puerta(position = muro.position(), image = "puertaCerrada.png", esPisable = false) 
                                            registroDeObjetos.agregarPuerta(puerta)
                                            game.addVisual(puerta)
                                            registroDeObjetos.muros().remove(muro)
                                            game.removeVisual(muro)
                                                    })
    }
}

object puertaSonMuros {
  const property frase = "Door Is Wall"

      method ejecutar() {
        
        registroDeObjetos.puertas().forEach({puerta => const muro = new Muro(position = puerta.position(), image = "murito.png", esPisable = false)
                                            registroDeObjetos.agregarMuro(muro)
                                            game.addVisual(muro)
                                            registroDeObjetos.puertas().remove(puerta)
                                            game.removeVisual(puerta)
                                                    })
    }
}



object puertasSonRocas {
    const property frase = "Door Is Rock"
    method ejecutar() {
        
        registroDeObjetos.puertas().forEach({puerta => const roca = new Roca(position = puerta.position(), image = "roca.png", esPisable = false, puedeMoverse = false) 
                                            registroDeObjetos.agregarRoca(roca)
                                            game.addVisual(roca)
                                            registroDeObjetos.puertas().remove(puerta)
                                            game.removeVisual(puerta)
                                                    })
    }
  
  
}

object murosSonRocas {
    const property frase = "Wall Is Rock"
    method ejecutar() {
        
        registroDeObjetos.muros().forEach({muro => const roca = new Roca(position = muro.position(), image = "roca.png", esPisable = false, puedeMoverse = false) 
                                            registroDeObjetos.agregarRoca(roca)
                                            game.addVisual(roca)
                                            registroDeObjetos.muros().remove(muro)
                                            game.removeVisual(muro)
                                                    })
    }
  
  
}

object puertasSonAgua {
    const property frase = "Door Is Water"
method ejecutar() {
        
        registroDeObjetos.puertas().forEach({puerta => const agua = new Agua(position = puerta.position(), image = "agua.png", esPisable = true) 
                                            registroDeObjetos.agregarAgua(agua)
                                            game.addVisual(agua)
                                            registroDeObjetos.puertas().remove(puerta)
                                            game.removeVisual(puerta)
                                                    })
    }
  
  
}

object rocaSonPuertas {
    const property frase = "Rock Is Door"
    method ejecutar() {
        
        registroDeObjetos.rocas().forEach({roca => const puerta = new Puerta(position = roca.position(), image = "puertaCerrada.png", esPisable = false) 
                                            registroDeObjetos.agregarPuerta(puerta)
                                            game.addVisual(puerta)
                                            registroDeObjetos.muros().remove(roca)
                                            game.removeVisual(roca)
                                                    })
    }
  
}

object puertaAbierta {
    const property frase = "Door Is Open"
    
    method ejecutar() {
        registroDeObjetos.puertas().forEach { puerta => puerta.esPisable(true)}
        registroDeObjetos.puertas().forEach { puerta => puerta.esAbierta (true)}
        registroDeObjetos.puertas().forEach { puerta => puerta.image("puertaAbierta.png")}
    }
}
object muroPisable {
    const property frase = "Wall Is Walkable"
    
    method ejecutar() {
        registroDeObjetos.muros().forEach { muro => muro.esPisable(true)}
        jugador.recargar()
    }
}

object rocaMovible {
  const property frase = "Rock Is Push"

  method ejecutar() {
    registroDeObjetos.rocas().forEach { roca => roca.puedeMoverse(true) }
  } 
}

object aguaEvaporar {
  const property frase = "Water Is Evapora"

  method ejecutar() {
    registroDeObjetos.aguas().forEach { agua => agua.evaporar()
                                                registroDeObjetos.aguas().remove(agua)
    }
    
  } 
}
//*==========================| Informacion Del Tablero |==========================
object registroDeObjetos {
    var   property puertas = #{}
    const property muros  = #{}
    const property rocas  = #{}
    const property aguas   = #{} 

    method agregarMuro(muro) {
        muros.add(muro)
    }

    method agregarRoca(roca) {
        rocas.add(roca)
    }

    method agregarAgua(agua) {
        aguas.add(agua)
    }
        method agregarPuerta(puerta) {
        puertas.add(puerta)
    }

    method limpiar() {
        muros.clear()
        rocas.clear()
        aguas.clear()
        puertas.clear()
    }
}

object tablero {
    method estaDentroDelTablero(pos) = self.direccionX(pos.x()) && self.direccionY(pos.y())

    method direccionX(x) = x.between(0, game.width()-1)

	method direccionY(y) = y.between(0, game.height()-2)

}
object tiempo {
    var property reloj = null
    const property position = game.at(1, 10) 

    method contadorReloj() {
            game.onTick(1000, "contadorReloj", { 

                if(not(gestorNiveles.seTermino())){
                    reloj = reloj - 1
                     
                }
                self.validarPerder()
            })
    }


    method validarPerder() {
        if(self.reloj() == 0 ){
            game.removeTickEvent("contadorReloj")
            gestorNiveles.perder()
        }
    }

    method text() = 'Tiempo: ' + reloj

    method textColor() = '#FFFFFF'

        method reiniciar() {
        reloj = 0
    }
}

