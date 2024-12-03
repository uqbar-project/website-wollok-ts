// ===============================
// Revisado
// ===============================
import game.*
import administradorDeMagos.*
import puntaje.*
import proyectil.*
import adminProyectiles.*
import administradorDeEnemigos.*
// ===============================
// Clase Base: Mago
// ===============================
class Mago {
  // Propiedades
  const position
  var property vida
  var property imagen

  // Métodos
  method frenarEnemigo() = true

  method enemigoEnSuFila() = administradorDeEnemigos.enemigos().any({enemigo => enemigo.position().y() == self.position().y()})

  method position() = position
  method image() = imagen

  method disparar() {}

  method recibeDanioEnemigo(_danio) { return false }
  
  method combinarProyectil(_tipo){return false}
  
  method recibeDanioMago(_danio) {
    self.vida(self.vida() - _danio)
    self.matar()
    return true
  }

  method sePuedeSuperponer() = false

  method valorAgregado() = 0

// agregar metodo
  method estaMuerto() {
    return self.vida() <= 0
  }

  method matar(){
    if (self.estaMuerto()) self.eliminar()
  }

  method eliminar() {
    game.removeVisual(self)
    administradorDeMagos.eliminarMago(self)
  }

  method matarSlime(){}
}

class MagoQueDispara inherits Mago{
  const proyectilBase
  var property tipoProyectil=proyectilBase
  override method disparar(){
    const posicionProyectil = new MutablePosition(x = self.position().x() + 1, y = self.position().y())
    if (self.enemigoEnSuFila()) {
      administradorDeProyectiles.generarProyectil(posicionProyectil, tipoProyectil)
    }
    tipoProyectil = proyectilBase
  }
  override method combinarProyectil(otroTipo){
        if (tipoProyectil.condicionParaCombinarse(otroTipo) && tipoProyectil.puedeCombinarse()){ 
            tipoProyectil = tipoProyectil.combinar()
            return true
            }
        return tipoProyectil.condicionParaCombinarse(otroTipo) && tipoProyectil.puedeCombinarse()
    }
}


// ===============================
// Subclases de Mago: Tipos de magos
// ===============================

// Mago de Fuego
class MagoFuego inherits MagoQueDispara(vida = 100, imagen = "magoFuego.png", proyectilBase = proyectilNormal){}

// Mago Irlandés (sanador)
class MagoIrlandes inherits Mago(vida = 100, imagen = "magoHealer.png") {
  override method valorAgregado() = 10
}

// Mago de Hielo
class MagoHielo inherits MagoQueDispara(vida = 100, imagen = "magoHielo.png", proyectilBase = proyectilPenetrante){}
class MagoStop inherits MagoQueDispara(vida = 100, imagen = "magoStop.png", proyectilBase = proyectilDeStop){}
// Mago de Piedra
class MagoPiedra inherits Mago(vida = 400, imagen = "magoPiedra.png") {}

// Mago Explosivo
class MagoExplosivo inherits Mago(vida = 10, imagen = "magoExplosivo.png") {
  const explosion = game.sound("m.explosion.mp3")

  override method matar() {
    if (self.estaMuerto()) {
      const posicionEnFrente = new MutablePosition(x = position.x() + 1, y = position.y())
      const enemigoEnFrente = game.getObjectsIn(posicionEnFrente)
      explosion.volume(0.1)
      explosion.play()
      enemigoEnFrente.forEach({ objeto => objeto.matarSlime() }) //Map devuelve lista, usar forEach
      self.eliminar()
    }
  }
}




// ===============================
// Tiendas de Magos: Creación de Magos desde la tienda
// ======r()=========================

class MagoTienda{
  const position
  const costo
  
  method position() = position

  method image() = ""

  method text() = costo.toString() + "$"

  method textColor() = "ffec00ff"

  method puedeGenerarMago(){
    if(puntaje.puntos() < costo){
     throw new DomainException(message="No hay suficiente dinero para comprar esta Mago")
    }
  }
  
  method magoQueGenera(posicionMago){return} 

  method generarMago(posicionMago){ 
    self.puedeGenerarMago()//Idem en todo mago
    puntaje.restarPuntos(costo)//Idem en todo mago
    const mago = self.magoQueGenera(posicionMago)
    return mago
    }
  method recibeDanioMago(danio){}
  method frenarEnemigo()= true
  // method efectoDeInvocacion(){} //esto estaba porque antes los magos irlandeses interactuaban directamente con el contador de puntos
}

// Mago de Piedra en Tienda
object magoPiedraTienda inherits MagoTienda(position = new MutablePosition(x = 0, y = 5), costo = 100) {
  
  override method magoQueGenera(posicionMago){return new MagoPiedra(position = posicionMago)}

  override method image() = "magoPiedra.png"
}

// Mago de Fuego en Tienda
object magoFuegoTienda inherits MagoTienda(position = new MutablePosition(x = 1, y = 5), costo = 100) {
  override method magoQueGenera(posicionMago){return new MagoFuego(position = posicionMago)}
  override method image() = "magoFuego.png"
}

// Mago Irlandés en Tienda
object magoIrlandesTienda inherits MagoTienda(position = new MutablePosition(x = 2, y = 5), costo = 75) {

override method magoQueGenera(posicionMago){return new MagoIrlandes(position = posicionMago)}
  
  override method image() = "magoHealer.png"
}

// Mago de Hielo en Tienda
object magoHieloTienda inherits MagoTienda(position = new MutablePosition(x = 3, y = 5), costo = 250) { //Nico: ver si 250 es una banda o no

  override method magoQueGenera(posicionMago){return new MagoHielo(position = posicionMago)}
  
  override method image() = "magoHielo.png"
}

// Mago Explosivo en Tienda
object magoExplosivoTienda inherits MagoTienda(position = new MutablePosition(x = 4, y = 5), costo = 400) {
override method magoQueGenera(posicionMago){return new MagoExplosivo(position = posicionMago)}

  override method image() = "magoExplosivo.png"
}

object magoStopTienda inherits MagoTienda(position = new MutablePosition(x = 5, y = 5), costo = 300) { //Nico: ver si 250 es una banda o no

  override method magoQueGenera(posicionMago){return new MagoStop(position = posicionMago)}
  
  override method image() = "magoStop.png"
}