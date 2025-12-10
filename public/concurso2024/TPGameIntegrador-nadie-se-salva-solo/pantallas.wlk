import letras.*
import puntuacion.*
import juego.*
import vida.*
import sonido.*


object menu {
  method image() = "menuInicial4.png"
  method position() = game.origin()
}

object comoJugar{
   method image() = "comoJugar2.png"
  method position() = game.origin()
}

object gameOver{
   const property musica = new Sonido(cancion = "perdiste.mp3")
   method image() = "gameOver2.png"
   method position() = game.origin()
   

   method configuracion(){
      if(juego.estaJugando()){
         juego.estaJugando(false)
         juego.perdio(true)
         game.removeVisual(juego.dificultad())
         game.addVisual(self)
         puntos.removeVisual()                
         puntos.reubicar()                      
         juego.listaLetras().clear()
         juego.letrasNoEnPantalla().clear()         
			barraDeVida.removeVisual()
			barraDeVida.reiniciar()
         juego.dificultad().resetearVelocidades()         
         game.removeTickEvent("letra")
			game.removeTickEvent("caida")
         game.removeTickEvent("musica")
         game.removeTickEvent("colores")
         juego.dificultad().pararMusica()
         musica.reproducir(true)       
         keyboard.m().onPressDo({juego.reiniciar()})           
      }  
   }

   
}

class Dificultad{
   var vel 
   var cant
   const velCaida = new Velocidad(valorInicial = vel)
   const cantLetras = new Cantidad(valorInicial = cant)
   const velAparicion =  new Velocidad(valorInicial = vel)
   const property atributos=[velCaida,cantLetras,velAparicion]  
   const property image
   method position() = game.origin()
   const property musica
   var posicion = 0 



   method configuracion(){
      if(juego.estaEnMenu()){
         juego.estaEnMenu(false)
         juego.musica().parar()
         juego.cambiarDificultad(self)
         juego.estaJugando(true)         
         game.removeVisual(menu)
         game.addVisual(self)
         self.empezar()
         barraDeVida.addVisual()
         puntos.addVisual()
         puntos.ubicar()
         keyboard.enter().onPressDo({juego.rendirse()})
         musica.reproducir(true)
         musica.cambiarVolumen(0.2)
         

         

      }
   }

   method pararMusica() {
      musica.parar()
   }

   method empezar(){
      game.onTick(atributos.get(0).valorInicial(), "letra", {juego.agregarLetraSiEsPosible(atributos.get(1).valorInicial(),atributos.get(2).valorInicial())})
            
   }
   method disminuirVelociad(){
      vel = vel + 300
   }  
   
   method aumentarDificultad(puntajeActual,ultimoPuntaje){            
      self.masRapidoYmasCantidad(puntajeActual, ultimoPuntaje)
      self.generarMasLetras(puntajeActual,ultimoPuntaje)
      self.generarLetrasColor(puntajeActual,ultimoPuntaje)            
   }

   method checkRotar(unaLetra){
      if(puntos.numero() > 200){
         unaLetra.empezarARotar()
      }
   }
// puntaje actual 251 
   method masRapidoYmasCantidad(puntajeActual,ultimoPuntaje){
      if(puntajeActual - ultimoPuntaje.ultimoPuntaje() >= 20){
         atributos.get(posicion).aumentarValor()
         ultimoPuntaje.actualizarUltimoPuntaje()
         posicion = posicion + 1
         if(posicion > 2){
            posicion = 0
         }                
      }    
   }

   method generarMasLetras(puntajeActual,ultimoPuntaje){
      if(puntajeActual >= ultimoPuntaje.limiteMasLetras()){
         game.onTick(600, "letra", {juego.agregarLetraSiEsPosible(atributos.get(1).valorInicial(),atributos.get(2).valorInicial())})        
         juego.agregarLetraSiEsPosible(27,200)
         ultimoPuntaje.actualizarLimiteMasLetras()
      }      
   }

   method generarLetrasColor(puntajeActual,ultimoPuntaje){
      if(puntajeActual >= ultimoPuntaje.limiteColores()){
         game.onTick(5000, "colores", {self.generarLetraDeColor()})
         ultimoPuntaje.actualizarLimiteColores()
      }
   }

   method generarLetraDeColor(){
      const letra = self.LetrasColores().anyOne()

         letra.cambiarPosicion(juego.algunaPosicion())
			letra.addVisual()
			letra.iniciarCaida(500)			
			juego.listaLetras().add(letra)
			
   }

   method LetrasColores(){
      const bN = new LetraNegra(image = "Bn.png", letra = "B", puntaje = 100)
      const cN = new LetraNegra(image = "Cn2.png", letra = "C", puntaje =100)
      const pN = new LetraNegra(image = "Pn2.png", letra = "P", puntaje = 100)
      const rN = new LetraNegra(image = "Rn.png", letra = "R", puntaje = 100)
      const aN = new LetraNegra(image = "An2.png", letra = "A", puntaje =100)
      const bV = new LetraVerde(image = "Bv.png", letra = "B", puntaje = 50)
      const pV = new LetraVerde(image = "Pv.png", letra = "P", puntaje = 50)
      const dR = new LetraRoja(image = "Dr.png", letra = "D", puntaje = 25)
      const gR = new LetraRoja(image = "Gr.png", letra = "G", puntaje = 25)
      const jR = new LetraRoja(image = "Jr.png", letra = "J", puntaje = 25)
      const mR = new LetraRoja(image = "Mr.png", letra = "M", puntaje = 25)
      const nR = new LetraRoja(image = "Nr.png", letra = "N", puntaje = 25)
      const tR = new LetraRoja(image = "Tr.png", letra = "T", puntaje = 25)
      const xR = new LetraRoja(image = "Xr2.png", letra = "X", puntaje =25)
      const yR = new LetraRoja(image = "Yr.png", letra = "Y", puntaje = 25)
      const fA = new LetraAmarilla(image = "Fa.png", letra = "F",puntaje = 25)
      const oA = new LetraAmarilla(image = "Oa.png", letra = "O",puntaje = 25)
      const wA = new LetraAmarilla(image = "Wa.png", letra = "W",puntaje = 25)
      const zA = new LetraAmarilla(image = "Za.png", letra = "Z",puntaje = 25)
      const lista =[bN,cN,pN,rN,aN,bV,pV,dR,gR,jR,mR,nR,tR,xR,yR,fA,oA,wA,zA]
      return lista      
   }


    method resetearVelocidades(){
      
   }
}

class Facil inherits Dificultad{
   
   override method resetearVelocidades(){
      vel = 1500
      cant = 24
   }   
}

class Dificil inherits Dificultad{
   override method resetearVelocidades(){
      vel = 1000
      cant = 24
   }
}


object controlPuntaje{
   var ultimoPuntaje = puntos.numero()
   var limiteMasLetras = 250
   var limiteColores = 150

   method ultimoPuntaje(){
      return ultimoPuntaje
   }

   method resetarControlPuntaje(){
      ultimoPuntaje = 0
   }

   method actualizarUltimoPuntaje(){
      ultimoPuntaje = puntos.numero()
   }

   method limiteMasLetras(){
      return limiteMasLetras
   }

   method actualizarLimiteMasLetras(){
      limiteMasLetras += 100
   }

   method resetearLimiteMasLetras(){
      limiteMasLetras = 150
   }

   method limiteColores(){
      return limiteColores
   }

   method actualizarLimiteColores(){
      limiteColores = 99999999
   }

   method resetearLimiteColores(){
      limiteColores = 150
   }
   
}
class Atributo{
   var valorInicial  

   method valorInicial(){
      return valorInicial
   }
   method aumentarValor(){
      
   }
   method cambiarValor(unValor){
      valorInicial = unValor
   }  
}

class Velocidad inherits Atributo{
   override method aumentarValor(){
      valorInicial = (valorInicial - 100).max(10)
   }

   method disminuirVelocidad(){
      valorInicial = valorInicial + 200
   }
}

class Cantidad inherits Atributo{
   override method aumentarValor(){
      valorInicial += 1
   }
}