import sistema1.*
import sistema2.*
import protagonista.*
import final.*

// CLASE VISUAL PARA TODOS LOS OBJETOS
class Visual{
    var property position = game.origin()
    var property img = ""

    method image() = img

    method interactuar() 

    method iniciar() {
      game.addVisual(self)
    }
}

// CLASE PANTALLA 
class Pantalla inherits Visual{
    method desaparecer(){
        game.removeVisual(self)
    }
    override method interactuar(){}
}

// CLASE ANTORCHA
class Antorcha inherits Visual{ 
  var prendida = false 

  override method image() = if (prendida) "antorchaPrendida.png" else "antorchaApagada.png"
  
  override method interactuar() {
    self.alternar()
    sistema.aparecerLLave()
  }

  method alternar() {
    prendida = !prendida
  }

  method estaPrendida() = prendida

  method reiniciar() {
    prendida = false
    }
}

class AntorchaMulticolor inherits Antorcha{
  
  var property contador = 0
  override method image() = if(contador==0) "zeus.png" else if(contador == 1) "poseidon.png" else if(contador==2) "hades.png" else if(contador==3) "ares.png" else if(contador==4)"ateneaD.png" else if(contador==5)"artemisaD.png" else if(contador == 6) "apoloD.png" else "hermesD.png"

  override method alternar(){
    if(contador == 7){
      contador = 0
    }
    else{
      contador = contador + 1
    }
  }

  override method interactuar(){
    self.alternar()
    sistema.aparecerLlaveD()
  }

  override method reiniciar() {
    contador = 0
  }
}

// CLASE LLAVE
class Llave inherits Visual{
    override method interactuar() {
      carlitos.recogerLLave()
      game.removeVisual(self)
      carlitos.recoger(self)
    }



}

// CLASE COFRE
class Cofre inherits Visual{
const contenido
var abierto = false
const decir 

  override method image() = if(self.estaAbierto()) 'cofreAbierto.png' else 'cofreCerrado.png'

  override method interactuar() {
    if(carlitos.tieneLlave()){
       self.abrir()
       carlitos.sacarLLave()
       game.say(self, decir.toString())
       carlitos.recoger(contenido)
    }
    else{
      game.say(self, "necesitas una llave")
    }
  }

  method abrir() {
    abierto = !abierto
  }

  method reiniciar() {
    abierto = false
  }

  method estaAbierto() = abierto
}

// CLASE PUERTA

class Puerta inherits Visual{
  var abierta = false
  const property puertaA = ""
  const property puertaC = ""
  const property llaveNecesaria 
  const llevaA      // aca poner el nombre del nivel a llevar por ejemplo Nivel2.iniciar()

 override method image() = if(self.estaAbierta()) puertaA else puertaC
  

  override method interactuar(){
   if(carlitos.inventario().contains(llaveNecesaria)){
      self.abrirPuerta()
      carlitos.vaciarInventario()}
    if(self.estaAbierta()){     
        self.proxNivel().iniciar()
    }
    else{
    game.say(self, "necesitas una llave")}
  }
  method abrirPuerta() { abierta = !abierta}
  method estaAbierta() = abierta
  method proxNivel() = llevaA

  method reiniciar() {
    abierta = false
  }
}

class Pistas inherits Visual{
    const property nota 

    override method interactuar(){
      nota.mostrar()
    }
    
}

class Nota inherits Visual{

    var property tiempoEnPantalla 


     method mostrar() {
      game.addVisual(self)
      game.schedule(tiempoEnPantalla, {game.removeVisual(self)})
    }

    override method interactuar(){}
}

class ImagenFinal inherits Visual {
  override method interactuar(){}
}
