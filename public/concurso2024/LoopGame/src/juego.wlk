import wollok.game.*
import niveles.*
import objetos.*



//OBJETO QUE CONTIENE EL JUEGO Y SUS ESTRUCTURAS
object juego {
	
	const property niveles=[]//Lista con todos los niveles
	var nivel=0	//Numero de nivel actual
	var inicie = false//Bandera utilizada para saber si ya inicé el juego o no
	var estoyEnFinal= false //Bandera utilizada para saber si estoy en el final del juego
	
	method nivelAct()= niveles.find{n=>n.nivelID()==nivel}//Retorna el nivel actual
	method pasarSiguienteNivel(){ //Saca el nivel actual y pone el siguiente y si no hay siguiente finaliza el juego			
			nivel+=1
			game.clear()
			sonido.iniciar()	
			if(nivel== niveles.size()){self.finalizar()}else{self.ponerNivel(niveles.find{n=>n.nivelID()==nivel})}
			}
	method nivel()=nivel
	method finalizar(){
		game.clear()
		sonido.iniciar()
		game.addVisual(tablero)
		game.addVisual(cartelExit)
		game.addVisual(cartelReinicio)	
		final.mostrarTiempo()
		final.mostrarPistas()
		final.mostrarReset()
		final.agregarMedallas()
		final.agregarPantallaFinal()
		estoyEnFinal=true
		nivel=0
		keyboard.q().onPressDo{game.stop()}
		keyboard.enter().onPressDo{self.reiniciarJuego()}
		
	}//Finaliza el juego *TERMINAR*
	method ponerNivel(niv){ //Pone el nivel en pantalla que se le pase por parametro
		
		niv.objetos().forEach{o=>game.addVisual(o)}//Se agregan los objetos del nivel
		self.nivelAct().estructuraNivel()//Se define la estructura del nivel actual
		segundero.comenzarSegundero()//se agrega y comienza el segundero
		if (niv.nivelID()==0){segundero.reiniciar()}
	}

	
	method agregarNivel(nuevoNivel){ // Agrega el nivel pasado por parámetro a la lista de niveles
		niveles.add(nuevoNivel)
	}
	
	
	
	//LISTO: NIVEL COMUN
	method nivel0()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 0,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		
		//LISTO:NIVEL COMUN, PERO LOS MOVIMIENTOS SON CON LAS FLECHAS
		method nivel1()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral(imagen="boton0.png",position =game.at(1,7)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 1,
		teclas=new BotonesParaMover(izquierda=keyboard.left(),derecha=keyboard.right(),arriba=keyboard.up(),abajo=keyboard.down())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO:NIVEL CON LOS OBJETOS INVISIBLES
	method nivel2()= new NivelCajasInvisibles(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotonInvisible(imagen="objInvisible.png",position =game.at(1,7)),
		puertaAct=new PuertaInvisible(imagen="objInvisible.png", position=game.at(14,3)),
		nivelID= 2,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO: NIVEL QUE SE MUEVEN LA PUERTA Y EL BOTON
	method nivel3()= new NivelSeMuevenSoloObj(perAct= new PerInvisble(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 3,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO: NIVEL CON LA PUERTA ABIERTA QUE SE CIERRA SI LO APRETAS
		method nivel4()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaAbierta(imagen="puerta1.png", position=game.at(14,3)),
		nivelID= 4,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO NIVEL CON LAS TECLAS Y LOS APSECTOS DE LOS OBJETOS CAMBIADOS
		method nivel5()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotonPuerta( imagen="puerta0.png", position =game.at(14,3)),
		puertaAct=new PuertaBoton(imagen="boton0.png", position=game.at(1,7)),
		nivelID= 5,
		teclas=new BotonesParaMover(izquierda=keyboard.d(),derecha=keyboard.a(),arriba=keyboard.s(),abajo=keyboard.w())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO: NIVEL QUE SE DEBE PASAR POR LA PUERTA ANTERIOR
		method nivel7()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaSiempreAbierta(imagen="puerta1.png", position=game.at(1,1)),
		nivelID= 7,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(14,3)))
		//LISTO: NIVEL PERSONAJE INVISIBLE
	method nivel6()= new NivPerInvisible(perAct= new PerInvisble(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 6,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO: NIVEL QUE SE PASA REINICIANDO EL NIVEL
		method nivel8()= new NivelComun(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(1,7)),
		puertaAct=new PuertaReinicio(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 8,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO NIVEL QUE SE PASA TOCANDO EL BOTON DEL CARTEL
		method nivel9()=new NivelAlto(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(6,10)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 9,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		//LISTO: NIVEL  QUE SE PASA PIDIENDO PISTA
		method nivel10()=new NivelPista(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(6,10)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 10,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
		method nivel11()=new NivSilencio(perAct= new PerGral(imagen="tipitoDer.png",position=game.at(2,1)),
		botAct=new BotGral( imagen="boton0.png", position =game.at(6,10)),
		puertaAct=new PuertaGral(imagen="puerta0.png", position=game.at(14,3)),
		nivelID= 11,
		teclas=new BotonesParaMover(izquierda=keyboard.a(),derecha=keyboard.d(),arriba=keyboard.w(),abajo=keyboard.s())
		,cartelPistaAct=new CartelPista()
		,puertaAnt=new PuertaAnt(position=game.at(1,1)))
	
	method agregarNiveles(){//Se agregan los niveles a la lista de niveles
		self.agregarNivel(self.nivel0())
		self.agregarNivel(self.nivel1())
		self.agregarNivel(self.nivel2())
		self.agregarNivel(self.nivel3())
		self.agregarNivel(self.nivel4())
		self.agregarNivel(self.nivel5())
		self.agregarNivel(self.nivel6())
		self.agregarNivel(self.nivel7())
		self.agregarNivel(self.nivel8())
		self.agregarNivel(self.nivel9())
		self.agregarNivel(self.nivel10()) 
		self.agregarNivel(self.nivel11()) 
	}
	
	method tutorial(){
		game.clear()
		game.addVisual(cartelTutorial)
		keyboard.enter().onPressDo{self.jugar()}	
	}
	
	method inicio(){ //Estructura de la pantalla de inicio
		//var primerEnter=true
		keyboard.q().onPressDo{game.stop()}
		game.addVisual(fondoInicio)
		game.addVisual(cartelExit)
		var fotograma=0
		keyboard.enter().onPressDo{self.tutorial()}	
		game.addVisual(pantallaInicio)
		game.onTick(200,"cambioInicio",{
			fotograma +=1
			
			pantallaInicio.newImagen(fotograma)
			})
			
			var fotogramaStart=0
			game.addVisual(start)
			game.onTick(125,"cambioStart",{
				//game.removeVisual(start)
				fotogramaStart+=1
				start.newImagen(fotogramaStart)
				//game.addVisual(start)
				})
			
			}
		method reiniciarJuego(){
			game.clear()
			inicie=false 
			estoyEnFinal=false
			self.niveles().clear()
			contPistas.reiniciar()
			contReset.reiniciar()
			self.inicio()
			}
		method iniciar(){
		
		self.inicio()
		sonido.iniciar()
		}//Se inicia el juego si se apreta enter por primera vez	
		method jugar(){
		self.agregarNiveles()	
		inicie=true
		game.clear() 
		sonido.iniciar()	
		//sonido.iniciar()	
		//Se agregan los niveles
		self.ponerNivel(self.nivelAct())//Se pone el primer nivel
		if (self.nivelAct().condicionesParaPasarDeNivel()){self.pasarSiguienteNivel()}
		}}	//Si estan las condiciones para pasar de nivel se pasa al siguiente
		
		
		
	

