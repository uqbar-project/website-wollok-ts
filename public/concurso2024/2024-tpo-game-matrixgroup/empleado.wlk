import jugador.*
import elementos.*
import npc.*

class Empleado inherits NPC (
  image = "empleado_atras.png",
  frente = "empleado_frente.png",
  atras = "empleado_atras.png",
  izquierda = "empleado_izquierda.png",
  derecha = "empleado_derecha.png"
) {
  method initialize() {
    
  }
  
  method cobrar() {
    dinero.aumentar(25)
  }
}