import wollok.game.*
import menus.*
import obstaculos.*
import personaje.*
import niveles.*
import hud.*

object partida {

  var nivelActual = 0
  var nroNivelActual = 0
  var property pausaActiva = false
  var property final = false
  
  const sonido = game.sound("sonido_partida.mp3")

  const sonidoFinal = game.sound("winner_finish_sound.mp3")
  
  method crearNiveles() = [ new Nivel1(), new Nivel2(), new Nivel3(), new FinDelJuego() ]
  
  method nivelActual() = nivelActual

  method prepararPersonaje() {
    personaje.setPosition(nivelActual.posxPlayer(),nivelActual.posyPlayer())
    personaje.configurarTeclas()
    personaje.reiniciarPedidosEntregados()
    nivelActual.setDinInicial(personaje) //Setea el valor del dinero dado por el nivel 
    personaje.cambiarVehiculo(nivelActual.vehiculoDelNivel())
    game.say(personaje, "Necesito ganar unos mangos mas")
  }

  method sonidoOn() {
    sonido.play()
    sonido.shouldLoop(true)
  }
  
  method sonidoOff() {
    sonido.stop()
  }

  method sonidoFinalOn() {
    sonidoFinal.play()
  }

  method sonidoFinalOff() {
    sonidoFinal.stop()
  }

  method mutearSonido() {
    sonido.volume(0)
  }

  method desmutearSonido() {
    sonido.volume(1)
  }

  method iniciar() {
    nroNivelActual = 0
    self.cargarNivel()
    self.prepararPersonaje()
    self.sonidoOn()
    // enviamos la vida inicial del nivel, su vida maxima (la misma cantidad), y las monedas iniciales
    partidaHud.inicializarHud(nivelActual.vidaNivel(),nivelActual.vidaNivel(), nivelActual.dineroNivel())
    menuPausa.actualizarImgActual(nivelActual.imagenMenuPausa())
    self.cargarTicks()
    self.configurarTeclas()
    
  }

  method cargarNivel() {
    const niveles = self.crearNiveles()
    nivelActual = niveles.get(nroNivelActual)
    nivelActual.renderizarObjetos()
    nivelActual.sincronizarPedidosConClientes()
  }

  method cargarTicks() {
    game.onTick(9500,"obstaculosMovimiento",{nivelActual.obstaculos().forEach({o => o.movimientoAleatorio()})})
    game.onTick(nivelActual.tickVehiculos(), "movimientoVehiculo",{nivelActual.vehiculos().forEach({v => v.movimientoAleatorio()}) nivelActual.transparentes().forEach({t => t.moverseConSuPadre()})})
    game.onTick(1500, "movimientocliente",{nivelActual.clientes().forEach({v => v.movimientoAleatorio()}) })
  }

  method limpiarTicks() {
    game.removeTickEvent("obstaculosMovimiento")
    game.removeTickEvent("movimientoVehiculo")
    game.removeTickEvent("movimientocliente")
  }

  method pasarSiguienteNivel() {
    nivelActual.removerObjetos()
    nroNivelActual += 1
    self.cargarNivel()

    if (nroNivelActual+1 != self.crearNiveles().size()) {
      personaje.reiniciarPedidosEntregados()
      personaje.updatePosition(nivelActual.posxPlayer(),nivelActual.posyPlayer())
      personaje.cambiarVehiculo(nivelActual.vehiculoDelNivel())
      self.limpiarTicks()
      self.cargarTicks()
      menuPausa.actualizarImgActual(nivelActual.imagenMenuPausa())
      partidaHud.actualizarHudVida(nivelActual.vehiculoDelNivel().vida(), nivelActual.vehiculoDelNivel().vida())
      partidaHud.sincronizarIconosPedidos(personaje.pedidos())
      partidaHud.actualizarHudDinero(personaje.monedas())
      game.addVisual(nivelActual)
      game.schedule(3000, {game.removeVisual(nivelActual)} )
    } else {
      self.fin()
    }
  }

  method gameOver() {
    self.sonidoOff()
    partidaHud.limpiarIconosDinero()
    game.clear()
    menuGameOver.iniciar()
    nroNivelActual = 0
  }

  method fin() {
    self.pausaActiva(true)
    self.final(true)
    self.sonidoOff()
    self.sonidoFinalOn()
    game.addVisual(nivelActual)
    game.addVisual(personajeCreditos)
    game.onTick(200,"movimientoMoto",{ if (!personajeCreditos.estaEnPosicion()) personajeCreditos.llegarAPosicion() })
    game.schedule(3500, {personajeCreditos.hablar()} )
    game.schedule(8000, {game.addVisual(botonSalir)} )

  }

  method puedePasarDeNivel(pedidosEntregados){
    if(nivelActual.cumpleLosPedidosEntregados(pedidosEntregados)){
      self.pasarSiguienteNivel()
    }
  }
  
  method configurarTeclas() {
    keyboard.space().onPressDo({ if (!pausaActiva) menuPausa.iniciar() })
    keyboard.p().onPressDo({ if (final) { self.sonidoFinalOff() game.schedule(150, { botonSalir.realizarAccion(self) }) } }) 
  }

}

object zonaNoJugable {

  const posiciones = [
    // BORDES SUPERIOR E IZQUIERDO
    "0,0","0,1","0,2","0,3","0,4","0,5","0,6","0,7","0,8","0,9","0,10","0,11","0,12","0,13","0,14",
    "1,0","2,0","3,0","4,0","5,0","6,0","7,0","8,0","9,0","10,0","11,0","12,0","13,0","14,0","15,0",
    "16,0","17,0","18,0","19,0","20,0","21,0","22,0","23,0","24,0","25,0","26,0","27,0","28,0","29,0",

    // BORDES DERECHO E INFERIOR
    "29,14","29,13","29,12","29,11","29,10","29,9","29,8","29,7","29,6","29,5","29,4","29,3","29,2","29,1",
    "1,14","2,14","3,14","4,14","5,14","6,14","7,14","8,14","9,14","10,14","11,14","12,14","13,14","14,14",
    "15,14","16,14","17,14","18,14","19,14","20,14","21,14","22,14","23,14","24,14","25,14","26,14","27,14","28,14",

    // INTERIORES
    "2,3","2,4","2,5","2,7","2,9","2,10","2,11","2,12",
    "3,3","3,4","3,5","3,7","3,9","3,10","3,11","3,12",
    "4,3","4,4","4,5","4,7","4,9","4,10","4,11","4,12",
    "5,3","5,4","5,5","5,7",
    "6,3","6,4","6,5","6,7","6,8","6,9","6,10","6,11","6,12",
    "7,3","7,4","7,5","7,8","7,10","7,11","7,12",
    "8,3","8,4","8,5","8,6","8,8","8,10","8,11","8,12",
    "9,3","9,4","9,5","9,6","9,8","9,10","9,11","9,12",
    "10,3","10,4","10,5","10,6","10,8","10,10","10,11","10,12",
    "11,3","11,4","11,5","11,6","11,8","11,10","11,11","11,12",
    "12,3","12,4","12,5","12,12",
    "13,7","13,8","13,9","13,10",
    "14,3","14,4","14,5","14,6","14,7","14,8","14,9","14,10","14,11","14,12","14,13",
    "15,3","15,4","15,5","15,6","15,7","15,8","15,9","15,10","15,11","15,12","15,13",
    "16,7","16,8","16,9","16,10",
    "17,3","17,4","17,5","17,12",
    "18,3","18,4","18,5","18,6","18,8","18,9","18,10","18,11","18,12",
    "19,3","19,4","19,5","19,6","19,8","19,9","19,10","19,11","19,12",
    "20,3","20,4","20,5","20,6","20,8","20,9","20,10","20,11","20,12",
    "21,3","21,4","21,5","21,6","21,8","21,9","21,10","21,11","21,12",
    "22,3","22,4","22,5","22,6","22,8","22,9","22,10","22,11","22,12",
    "23,3","23,4","23,5","23,6","23,8","23,9","23,10","23,11","23,12",
    "24,3","24,4","24,5","24,6","24,8","24,9","24,10","24,11","24,12",
    "25,3",
    "26,3","26,5","26,6","26,7","26,9","26,10","26,11","26,12",
    "27,3","27,5","27,6","27,7","27,9","27,10","27,11","27,12"
  ]

  method existeLaPosicion(unaPosicion) {
    const clave = unaPosicion.x().toString() + "," + unaPosicion.y().toString()
    return posiciones.contains(clave)
  }

  method caeEnBordeOeste(unaPosicion) {
    const clave = unaPosicion.x().toString() + "," + unaPosicion.y().toString()
    return clave == "0,1" || clave == "0,2"
  }

}

object zonaSpawn {
  const property position = game.at(7,9)
}

object zonaClientes {
  const property edificioDerechaSup = game.at(27, 9)
  const property edificioDerechaInf = game.at(27, 5)
  const property edificioAvenida1 = game.at(3, 3)
  const property edificioAvenida2 = game.at(5, 3)
  const property edificioAvenida3 = game.at(7, 3)
  const property edificioAvenida4 = game.at(21, 3)
  const property edificioAvenida5 = game.at(23, 3)
  const property plaza1 = game.at(20, 8)
  const property obelisco1 = game.at(13, 7)

  const ubClientes = [edificioDerechaSup,edificioDerechaInf,edificioAvenida1,edificioAvenida1,edificioAvenida2,edificioAvenida3,edificioAvenida4,edificioAvenida5,plaza1,obelisco1]

  method existeLaPosicion(unaPosicion) = ubClientes.any({c => c == unaPosicion})
  
}

object zonaPedidos {
  const property mcdonalds = game.at(8, 10)
  const property kiosco = game.at(3, 9)
  const property kiosco2 = game.at(4, 9)
  const property mercado = game.at(9, 3)
  const property mercado2 = game.at(10, 3)

  const ubPedidos = []
  method existeLaPosicion(unaPosicion) = ubPedidos.any({p => p == unaPosicion})

}