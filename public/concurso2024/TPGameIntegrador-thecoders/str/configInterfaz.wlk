import instrucciones.*
import config.*
import interfazJuego.*
import enemigo.*
object configInterfaz {
  var dificultadSeleccionada = false

  method reiniciar(){
    dificultadSeleccionada = false
  }
  method seleccionarDificultad(){
      keyboard.d().onPressDo({
        self.ponerDificultad(7,10)
      })
      keyboard.f().onPressDo({
        self.ponerDificultad(5,5)
      })
  }
  
  method ponerDificultad(cantEnemigos,cantAliados){
    if(!dificultadSeleccionada){
      interfaz.cerrarInterfaz()
      dificultadSeleccionada = true
      config.maximoTropas(cantAliados)
      enemigo.maximoTropasEnemigo(cantEnemigos)
    }
  }
}