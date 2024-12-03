import objetos.*
import juego.*
import wollok.game.*
//CLASE NIVEL COMUN QUE SE UTILIZA PARA EL NIVEL NORMAL O COMO SUPERCLASE PARA NIVELES MODIFICADOS
class NivelComun {
	var perAct//personaje del nivel pasado por el constructor
	var botAct//boton del nivel pasado por el constructor
	var puertaAct//puerta del nivel pasado por el constructor
	const nivelID//Id del nivel pasado por el constructor
	const property teclas//clase Teclas para mover pasado por el constructor
	var cartelPistaAct //Cartel de la pista pasado por el constructor
	var puertaAnt//Puerta anterior pasada por el constrctor
	
method perAct()= perAct
method botAct()= botAct
method puertaAct()=puertaAct
method nivelID() = nivelID
method cartelPistaAct()=cartelPistaAct
method condicionesParaPasarDeNivel()= self.puertaAct().abierta()//and puertaAct.estoyEnPuerta()
method movimiento(obj){//Movimiento de objetos
		teclas.derecha().onPressDo({	
		obj.nuevaPosicion(game.at(tablero.anchoMax().min(obj.position().x()+1),obj.position().y()))
		obj.animarDer()	})
		teclas.izquierda().onPressDo({
		obj.nuevaPosicion(game.at(1.max(obj.position().x()-1),obj.position().y()))		
		obj.animarIzq()
		})
		teclas.arriba().onPressDo({
		obj.nuevaPosicion(game.at(obj.position().x(),tablero.altoMax().min(obj.position().y()+1)))		
		obj.animarArriba()
		})
		teclas.abajo().onPressDo({
		obj.nuevaPosicion(game.at(obj.position().x(),1.max(obj.position().y()-1)))	
		obj.animarAbajo()	})
		
			}

method agregarCajaEn(posicion) {//funcion que agrega una caja en un lugar determinado
		const caja = new Caja(position = posicion)
		game.addVisual(caja)
	}
method dibujarCajas(){//dibuja las cajas en las posiciones de la lista
	[game.at(1,6),game.at(2,6),game.at(12,6),game.at(13,6),game.at(8,5),game.at(9,5),
		game.at(9,5),game.at(10,5),game.at(7,3),game.at(2,2),game.at(5,3),game.at(6,3),game.at(14,4),game.at(14,2),game.at(1,2)].forEach{
			pos=>self.agregarCajaEn(pos)
		}
	
	
	}
method pista(){
	keyboard.p().onPressDo({if (not cartelPistaAct.pistaPedida()){contPistas.sumarPista()} cartelPistaAct.pedirPista() })
}//Si apretas p se pide la pista
method pasarDeNivel(){
game.whenCollideDo(puertaAct,{o=>if(o.puedeTocarPuerta()and self.condicionesParaPasarDeNivel()){juego.pasarSiguienteNivel()}})
}//cuando un objeto que puede pasar por la puerta colisiona con la misma y als condiciones para pasar de nivel estan dadas, se pasa de nivel
method resetNivel(){//se resetean los objetos del nivel
		perAct.resetear()
		botAct.resetear()
		puertaAct.resetear()
	}

method cambiarEstado(obj){obj.cambiarEstado()}//cambia el estado del objeto
method estructuraNivel(){//estructura del nivel
self.dibujarCajas()
self.movimiento(perAct)
self.pista()
game.whenCollideDo(self.botAct(),{o=>if(o.puedeTocarBoton()){self.botAct().cambiarEstado() self.puertaAct().cambiarEstado()}})
self.pasarDeNivel()
keyboard.r().onPressDo({self.resetNivel() contReset.sumarReset()})
}
method objetos()=[tablero,botAct,new CartelNivel(),puertaAct,puertaAnt,perAct,cartelPistaAct,tiempoU,tiempoC,tiempoD,tiempoM,cartelMute]//objetos que contiene el juego y se va a geregar	
}

//TIPOS DE NIVELES QUE HEREDAN DE LA SUPERCLASE NIVEL COMUN Y SE MODIFICAN LOS METODOS NECESARIOS


//Se modificó la estructura del nivel para que se muevan solo los objetos.
class NivelSeMuevenSoloObj inherits NivelComun{
override method estructuraNivel(){
self.dibujarCajas()
self.movimiento(botAct)
self.movimiento(puertaAct)
self.pista()
game.whenCollideDo(self.botAct(),{o=>if(o.puedeTocarBoton()){self.botAct().cambiarEstado() self.puertaAct().cambiarEstado()}})
self.pasarDeNivel()
keyboard.r().onPressDo({self.resetNivel()})
}}

//Se modificó los límites del movimiento hacia arrriba para poder ir más alto y apretar el botón.
class NivelAlto inherits NivelComun{
override method movimiento(obj){
		teclas.derecha().onPressDo({	
		obj.nuevaPosicion(game.at(tablero.anchoMax().min(obj.position().x()+1),obj.position().y()))
		obj.animarDer()	})
		teclas.izquierda().onPressDo({
		obj.nuevaPosicion(game.at(1.max(obj.position().x()-1),obj.position().y()))		
		obj.animarIzq()
		})
		teclas.arriba().onPressDo({
		obj.nuevaPosicion(game.at(obj.position().x(),obj.position().y()+1))		
		obj.animarArriba()
		})
		teclas.abajo().onPressDo({
		obj.nuevaPosicion(game.at(obj.position().x(),1.max(obj.position().y()-1)))	
		obj.animarAbajo()	})
		
			}
	
}
//Se modificó para que al pedir la pista la puerta cambie de estado.
class NivelPista inherits NivelComun{
	override method pista(){keyboard.p().onPressDo({cartelPistaAct.pedirPista() self.puertaAct().cambiarEstado() contPistas.sumarPista()})}
}

//Se modificó el orden de addVisuals de los objetos para que las cajas queden detrás del tablero y así dar una sensación de invisibilidad
class NivelCajasInvisibles inherits NivelComun{
override method objetos()=[tablero,new CartelNivel(),botAct,puertaAct,puertaAnt,perAct,cartelPistaAct,tiempoU,tiempoD,tiempoC,tiempoM,cartelMute]
override method estructuraNivel(){
self.movimiento(perAct)
self.pista()
game.whenCollideDo(self.botAct(),{o=>if(o.puedeTocarBoton()){self.botAct().cambiarEstado() self.puertaAct().cambiarEstado()}})
keyboard.r().onPressDo({self.resetNivel()})
self.pasarDeNivel()
}
}


class NivPerInvisible inherits NivelComun{
	override method estructuraNivel(){super() 
		keyboard.p().onPressDo{self.perAct().desahcerInv()}     //{game.say(self.perAct(),"Aca Estoy")}
	}
}

class NivSilencio inherits NivelComun{
	override method estructuraNivel(){  
		super()
		if(sonido.estaDetenida()){puertaAct.cambiarEstado()}
		keyboard.m().onPressDo({if(sonido.estaDetenida()){puertaAct.cambiarEstado()}else{puertaAct.resetear()}})}
}


