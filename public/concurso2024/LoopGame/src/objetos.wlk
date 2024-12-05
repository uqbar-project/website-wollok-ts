import niveles.*
import juego.*
import wollok.game.*
//SUPERCLASSE QUE MODELA TODOS LOS OBJETOS DEL JUEGO

class ObjGral{
const casillerosQNoPuede = [game.at(1,6),game.at(2,6),game.at(12,6),game.at(13,6),game.at(8,5),game.at(9,5),
		game.at(9,5),game.at(10,5),game.at(7,3),game.at(2,2),game.at(5,3),game.at(6,3),game.at(14,4),game.at(14,2),game.at(1,2)] //casilleros del nivel que no se puede mover
		
var position//posicion pasada en el constructor
var imagen//imagen pasada en el constructor
method position()= position
method image()=imagen
method cambiarEstado()
method puedeTocarBoton()
method puedeTocarPuerta()

method nuevaPosicion(nueva){
	if (self.puedeMover(nueva))
	position=nueva
}
method animarDer()
method animarIzq()
method animarArriba()
method animarAbajo()
method puedeMover(posicion){
	return not casillerosQNoPuede.contains(posicion)
}
method resetear()
}




//CLASE DE PERSONAJE STANDARD

class PerGral inherits ObjGral{
	override method cambiarEstado(){}
	override method puedeTocarBoton()=true
	override method puedeTocarPuerta()=true
	override method animarDer(){imagen="tipitoDer.png"}
	override method  animarIzq(){imagen="tipitoIzq.png"}
	override method animarArriba(){imagen="tipitoVuel.png"}
	override method animarAbajo(){imagen="tipitoAbajo.png"}
	override method resetear(){
		position=game.at(2,1)
		imagen="tipitoDer.png"
	}
}

// PERSONAJES QUE SE VAN MODIFICANDO DE LA CLASE DE PERSONAJE STD
//Se Modifico las animaciones para que cuando el personaje se mueva se haga invisible y cuando se aprete la P diga donde esta.
class PerInvisble inherits PerGral{
	const invisible= "objInvisible.png"
	override method animarDer(){imagen=invisible}
	override method  animarIzq(){imagen=invisible}
	override method animarArriba(){imagen=invisible}
	override method animarAbajo(){imagen=invisible}
	method desahcerInv(){imagen="tipitoDer.png"}
	}

//CLASE DE BOTON STANDARD 
class BotGral inherits ObjGral{
	var   apretado=false
	
	override method cambiarEstado(){
		self.apretar()
		imagen ="boton1.png"
			}
	method apretar(){apretado=true}
	override method puedeTocarBoton()=false
	override method puedeTocarPuerta()=false
	override method animarDer(){}
	override method  animarIzq(){}
	override method animarArriba(){}
	override method animarAbajo(){}
 	override method resetear(){
 		apretado=false
 		imagen="boton0.png"
 	}
 }	
 
 // BOTONES QUE SE VAN MODIFICANDO DE LA CLASE DE PERSONAJE STD
 //Se Modifico el boton para que se vea invisible, aun cuando se lo aprete o se reinicie en nivel
 class BotonInvisible inherits BotGral{
	override method cambiarEstado(){
		self.apretar()
			}
	override method resetear(){
 		apretado=false
 	
 	}
}

//Se modifico el boton para que tenga aspecto de puerta
class BotonPuerta inherits BotGral{
	override method cambiarEstado(){
		imagen="puerta1.png"
		apretado=true
	}
	override method resetear(){
		apretado=false
		imagen="puerta0.png"
	}
}	


//CLASE DE PUERTA STANDARD

class PuertaGral inherits ObjGral{
	var  abierta=false
	override method cambiarEstado(){
		imagen="puerta1.png"
		abierta=true
	}
	
	method abierta()=abierta
	override method puedeTocarBoton()=false
	override method puedeTocarPuerta()=false
	override method animarDer(){}
	override method  animarIzq(){}
	override method animarArriba(){}
	override method animarAbajo(){}
	override method resetear(){
		abierta=false
		imagen="puerta0.png"
	}
}

 // PUERTAS QUE SE VAN MODIFICANDO DE LA CLASE DE PERSONAJE STD
 
 
  //Se Modifico la puerta para que se vea invisible, aun cuando se lo aprete al boton o se reinicie en nivel
 class PuertaInvisible inherits PuertaGral{
	override method cambiarEstado(){
		abierta=true
		
			}
	override method resetear(){
 		abierta=false
 	}
 	
}
 //Se Modifico la puerta para que ya este abierta y se cierre cuando se aprete el boton y se abra cuando se reinicie el nivel.
 class PuertaAbierta inherits PuertaGral{
	override method abierta()=not abierta
			override method cambiarEstado(){
		imagen="puerta0.png"
		abierta=true
	}
	override method resetear(){
		abierta=false
		imagen="puerta1.png"
	}
	}
//Se Modifico la puerta para que siempre este abierta	
class PuertaSiempreAbierta inherits PuertaGral{
	override method abierta()=true
	override method resetear(){
	}
}
//Se modifico la puerta para que tenga aspecto de boton
class PuertaBoton inherits PuertaGral{
	override method cambiarEstado(){
		imagen="boton1.png"
		abierta=true
	}
	override method resetear(){
		abierta=false
		imagen="boton0.png"
	}	
}

//Se modifico la puerta para que se abra cuando se reinice el nivel
class PuertaReinicio inherits PuertaGral{
	override method resetear(){
		abierta=true
		imagen="puerta1.png"
	}
	override method cambiarEstado(){}
}	


//OTROS OBJETOS

//Objeto tablero del fondo, es siempre el mismo, con las mismas propiedades.
object tablero {
	
	
	const property position= game.at(1,1)
	const property alto = 9
	const property ancho = 16	
	const  imagen= "tablero.png"
	
	
	method altoMax()= alto-2
	method anchoMax()=ancho-2
	method image()= imagen
	method pasarPuerta(puerta){}
	method apretarBoton(bot){}
	method puedeTocarBoton()=false
	method puedeTocarPuerta()=false
}	

//Clase que contiene el esquema de los botones que se van a utilizar en el nivel.

class BotonesParaMover{
	
	const property izquierda
	const property derecha
	const property abajo
	const property arriba
}

//Clase caja que va ser utilizada para agregar las mismas:
class Caja{
	const property position
	const property image = "caja4.png"
}


//Cartel que contiene el titulo del nivel actual
class CartelNivel{
var property image = "cartelNivel"+juego.nivel()+".png"
const property position =game.at(1,9)	
}

//Cartel que contiene la pista y el metodo para pedir la misma
class CartelPista{
	var imagen="pistaSinPedir.png"
	var  pistaPedida=false
	
	const property position =game.at(11,9)
	
method pedirPista(){
	imagen="pista"+juego.nivel()+".png"
	pistaPedida = true
}
method pistaPedida()=pistaPedida
method image()=imagen
}

//La puerta que simula ser la del nivel anterior
class PuertaAnt{
	var position
	method position()=position
	method image()="puerta0.png"
	method puedeTocarBoton()=false
	method puedeTocarPuerta()=false
}

//ARQUITECTURA DEL SEGUNDERO

//Tiempo en Unidades
object tiempoU{
	var imagen="tiempoU0.png"
	method position()=game.at(8,9)
	method image()=imagen
	method newImagen(tiempo){
		imagen= "tiempoU"+ tiempo + ".png"
	}
}
//Tiempo en Decenas
object tiempoD{
	var imagen="tiempoD0.png"
	method position()=game.at(8,9)
	method image()=imagen
	method newImagen(tiempo){
		imagen= "tiempoD"+ tiempo + ".png"
	}
}
//Tiempo en Centenas
object tiempoC{
	var imagen="tiempoC0.png"
	method position()=game.at(8,9)
	method image()=imagen
	method newImagen(tiempo){
		imagen= "tiempoC"+ tiempo+ ".png"
	}
}
//Tiempo en Miles
object tiempoM{
	var imagen="tiempoM0.png"
	method position()=game.at(8,9)
	method image()=imagen
	method newImagen(tiempo){
		imagen= "tiempoM"+ tiempo + ".png"
	}
}

//Cada 1 seg se refrescan todas las cifras

object segundero{
	var segundos=0
	
	method comenzarSegundero(){
	
	game.onTick(1000,"pasarSegundo",{
		segundos=segundos+1
		tiempoU.newImagen(segundos%10)
		tiempoD.newImagen(((segundos/10)%10).truncate(0))
		tiempoC.newImagen(((segundos/100)%10).truncate(0))
		tiempoM.newImagen(((segundos/1000)%10).truncate(0))

		
		})}
	method segundos()=segundos	
	method reiniciar(){segundos=0}
	}

 //PANTALLA DE INICIO
 //El Personaje va cambiando de imagen dando efecto de animacion
 object pantallaInicio{
	var property position= game.at(0,0)
	var imagen=0	
	
method image()= "inicio" + imagen +".png"
method newImagen(nueva){
	imagen=nueva % 10
}}
//Imagen de press start
object start{
	var imagen=0		
method position()= game.at(5,2)
method image()= "start" + imagen +".png"
method newImagen(nueva){
	imagen=nueva % 10
}
}
//Fondo de inicio
object fondoInicio{
method position()= game.at(0,0)
method image()= "fondoIncio.png"
}
//La Informacion de las teclas
object teclasInicio{
method position()= game.at(0,0)
method image()= "teclas.png"
}


object contPistas{
	var cantPistas=0
	method sumarPista(){cantPistas+=1}
	method pistasTotales() = cantPistas
	method reiniciar(){cantPistas=0}
}	
object contReset{
	var cantReset=0
	method sumarReset(){cantReset+=1}
	method resetTotales() = cantReset
	method reiniciar(){cantReset=0}
}	



object final{
	const medallas =[new MedallaTiempo(tiempo=segundero.segundos()),new MedallaResets(resets=contReset.resetTotales()),new MedallaPistas(pistas=contPistas.pistasTotales())]
	
	method mostrarTiempo(){
		game.addVisual(new FinalTiempU(tiem=segundero.segundos()))
		game.addVisual(new FinalTiempD(tiem=segundero.segundos()))
		game.addVisual(new FinalTiempC(tiem=segundero.segundos()))
		game.addVisual(new FinalTiempM(tiem=segundero.segundos()))
		//game.addVisual(new MedallaTiempo(tiempo=segundero.segundos()))
	}
	method mostrarReset(){
		game.addVisual(new FinalResetsU(resets=contReset.resetTotales()))
		game.addVisual(new FinalResetsD(resets=contReset.resetTotales()))
		//game.addVisual(new MedallaResets(resets=contReset.resetTotales()))
	}
	method mostrarPistas() {
		game.addVisual(new FinalPistasU(pistas=contPistas.pistasTotales()))
		game.addVisual(new FinalPistasD(pistas=contPistas.pistasTotales()))
		//game.addVisual(new MedallaPistas(pistas=contPistas.pistasTotales()))
	}
	method agregarMedallas(){medallas.forEach{m=>game.addVisual(m)}}
	method agregarPantallaFinal(){
		var fotograma=0
		const trofeo = medallas.sum{m=>m.color()}
		var pantallaFinal=new PantallaFinal(fotog=fotograma,trof=trofeo)
		game.addVisual(	pantallaFinal)
		game.onTick(100,"animarFinal",{
			fotograma=fotograma+1
			pantallaFinal.newImagen(fotograma)
		})
		
	}
}


class FinalTiempU{
	var tiem
	const property position=game.at(0,0)
	const property image="finalTiempoU"+ tiem%10 + ".png"
}

class FinalTiempD{
	var tiem
	const property position=game.at(0,0)
	const property image="finalTiempoD"+ ((tiem/10)%10).truncate(0) + ".png"
}	
class FinalTiempC{
	var tiem
	const property position=game.at(0,0)
	const property image="finalTiempoC"+ ((tiem/100)%10).truncate(0) + ".png"
}

class FinalTiempM{
	var tiem
	const property position=game.at(0,0)
	const property image="finalTiempoM"+ ((tiem/1000)%10).truncate(0) + ".png"
}		
class FinalPistasU{
	var pistas
	const property position=game.at(0,0)
	const property image="finalPistasU"+ pistas%10 + ".png"
}

class FinalPistasD{
	var pistas
	const property position=game.at(0,0)
	const property image="finalPistasD"+ ((pistas/10)%10).truncate(0) + ".png"
}

class FinalResetsU{
	var resets
	const property position=game.at(0,0)
	const property image="finalResetU"+ resets%10 + ".png"
}


class FinalResetsD{
	var resets
	const property position=game.at(0,0)
	const property image="finalResetD"+ ((resets/10)%10).truncate(0) + ".png"
}

class PantallaFinal{
	const fotog
	const trof
	var property imagen= "final"+fotog%6+"trofeo"+self.trofeo()+".png"
	
	
	const property position=game.at(0,0)
	
	method newImagen(nueva){imagen ="final"+nueva%6+"trofeo"+self.trofeo()+".png"}
	method image()=imagen
	method trofeo(){
		if (trof>7){return 3}
		if (trof>4){return 2}
		return 1
	}
	 
}


class MedallaTiempo{
	var tiempo
	const property image= "MedallaTiempo"+self.color()+".png"
	const property position=game.at(0,0)
	
	method color(){
		if (tiempo<1500){return 1}
		if (tiempo<5000){return 2}
		return 3 
	}
}

class MedallaPistas{
	var pistas
	const property image= "MedallaPistas"+self.color()+".png"
	const property position=game.at(0,0)
	
	method color(){
		if (pistas<5){return 1}
		if (pistas<8){return 2}
		return 3 
	}
}

class MedallaResets{
	var resets
	const property image= "MedallaResets"+self.color()+".png"
	const property position=game.at(0,0)
	
	method color(){
		if (resets<4){return 1}
		if (resets<8){return 2}
		return 3 
	}
}


object sonido{
	const musica = game.sound("musica.mp3")
	var detenida= false
	var primeraVez=true
	method iniciar(){
	musica.shouldLoop(true)
	musica.volume(0.2)
	if(primeraVez){
		game.schedule(500, { musica.play()}) primeraVez=false self.controlesPausa()
		}else{self.controlesPausa()}}
	method detener(){musica.pause() detenida = true}
	method reanudar(){musica.resume() detenida = false}
	method musicaDetenida()= detenida
	method controlesPausa(){
		keyboard.m().onPressDo({if(detenida){self.reanudar()}else{self.detener()}})
	}
	method estaDetenida()=detenida
}


object cartelMute{
	const property position= game.at(0,0)
	const property image= "mute.png"
	}
object cartelExit{
	const property position= game.at(0,0)
	const property image= "exit.png"
}
object cartelReinicio{
	const property position= game.at(0,0)
	const property image= "cartelReinicio.png"
}

object cartelTutorial{
	const property position= game.at(0,0)
	const property image= "explicacion.png"
}
