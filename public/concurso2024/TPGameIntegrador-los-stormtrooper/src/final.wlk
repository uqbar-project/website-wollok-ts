import puertas.*
import objetos.*
import personaje.*
import textos.*
//import wollok.game.*
import tablero.*
import barraItems.*
import musicaSonido.*

object final {
  var property image = "fondoTunelSalidaV2.png" 
  var property position = game.origin()

  const musicaAmviente = salaJardin

  method reproducirMusica() {
    musicaAmviente.sonar()
    musicaAmviente.loop()
  }  

  method iniciar() {
    //------------------------------------------------------propiedades de tablero
    habitacion.iniciarHabitacion(self,ubicacionTunelSalida)
    self.reproducirMusica()
    game.removeTickEvent("fantasma")   
    game.removeTickEvent("fantasmaR") 
    
    //------------------------------------------------------estado del personaje
    personaje.inicioDePartida(false)
    //personaje.ubicacion(8)
    game.sound("xfxIntoDimension.mp3").play()
    //------------------------------------------------------ubicacion objetos
    //--puertas
    habitacion.ubicarEnTablero(puertaAJardin, 6, 9)

    //--Items

    //--textos
    habitacion.ubicarEnTablero(txtDerrumbe, 5, 5)

    //Items en Inventario
    barraItems.refreshListaDeItems()
    
    //Limites Tablero
    habitacion.ubicarEnTablero(topeArriba, 0, 10)//y max Arriba
    habitacion.ubicarEnTablero(topeAbajo, 0, 0)//y min Abajo
    habitacion.ubicarEnTablero(topeDer, 7, 0)//x max Derecha
    habitacion.ubicarEnTablero(topeIzq, 4, 0)//x min Izquierda

    //--personaje
    habitacion.ubicarPersonaje(5, 1)
  }
}