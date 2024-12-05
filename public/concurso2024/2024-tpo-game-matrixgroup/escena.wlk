import jugador.*
import utiles.*
import elementos.*
import tienda.*
import cliente.*
import computadora.*
import constantes.*
import wollok.game.*
import paredes.*

class Escena {
  const property visuales = []
  const property onTicks = []
  const property celdasBloqueadas = []
  const property musica
  var property visible = false
  
  method cargarEscena() {
    visible = true
    visuales.forEach({ visual => game.addVisual(visual) }) // Carga visuales
    
    onTicks.forEach(
      { ontick => game.onTick(
          ontick.intervalo(),
          ontick.nombre(),
          ontick.accion()
        ) }
    ) // Carga onTicks
    
    celdasBloqueadas.forEach({ celda => celdasOcupadas.ocupar(celda) })
    
    self.play(musica) // Carga celdas bloqueadas
  }
  
  method eliminarEscena() {
    visible = false
    visuales.forEach({ visual => game.removeVisual(visual) })
    onTicks.forEach({ ontick => game.removeTickEvent(ontick.nombre()) })
    celdasBloqueadas.forEach({ celda => celdasOcupadas.desocupar(celda) })
  }
  
  method cambiarEscena(escenaNueva) {
    self.eliminarEscena()
    game.sound("click.mp3").play()
    escenaNueva.cargarEscena()
  }
  
  method play(sonido) {
    game.sound(sonido).play()
  }
}

class OnTick {
  const property intervalo
  const property nombre
  const property accion
}

const oficina = new Escena(
  visuales = [
    jugador,
    computadora,
    dinero,
    tiempo,
    mostradorU,
    cliente,
    tienda,
    entradaTienda,
    vida,
    sofa,
    pared,
    maquinaExpendedora,
    cafetera,
    pingpong
  ],
  onTicks = [
    new OnTick(
      intervalo = 500,
      nombre = "cliente",
      accion = { cliente.comprar() }
    ),
    new OnTick(
      intervalo = 5000,
      nombre = "Cobrar empleados",
      accion = { jugador.cobrarEmpleados() }
    ),
    new OnTick(
      intervalo = 5000,
      nombre = "corre el tiempo",
      accion = { tiempo.aumentar(1) }
    )
  ],
  celdasBloqueadas = [computadora.position(), tienda.position()],
  musica = "musica.mp3"
)

const portada = new Escena(visuales = [portadaG], musica = "nada")

const gameover = new Escena(
  visuales = [imagenGameover],
  musica = "gameover.mp3"
)