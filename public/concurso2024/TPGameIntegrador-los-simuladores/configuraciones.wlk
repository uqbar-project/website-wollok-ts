import paloma.*
import muros.*
import juego.*
object facil{
    method hacerMuro() {
        juego.agregarMuro(new Muro(color = natural))
        juego.mostrarMuros()
    }
    method configurarTeclas() {
        paloma.teclasMovimiento()
    }
}
object dificil {
    const colores = [azul,rojo,verde,amarillo]
    method hacerMuro() {
        juego.agregarMuro(new Muro(color = self.colorRandom()))
        juego.mostrarMuros()
    }

    method colorRandom() = colores.anyOne()
    method configurarTeclas() {
        paloma.teclasMovimiento()
        paloma.teclasColor()
  }
}

object natural {
  method color() = "Natural"
}

object azul {
  method color() = "Azul"
}

object verde {
  method color() = "Verde"
}

object rojo {
  method color() = "Rojo"
}

object amarillo {
  method color() = "Amarillo"
}

object vuelo1 {
  method version() = "V1"
  
  method siguiente() = vuelo2
}

object vuelo2 {
  method version() = "V2"
  
  method siguiente() = vuelo1
}