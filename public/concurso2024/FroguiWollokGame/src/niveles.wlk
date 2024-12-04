import wollok.game.*
import rana.*
import objetosDeNiveles.*
import sonidos.*
import inicio.*


// objeto para configurar los niveles dados en la pantalla de seleccion
object nivel {
	const niveles = []
	var nivel = 0
	var property puntos = 0
	
	method nivel() = nivel
	
	method aumentarNivel(){
		if(nivel == 0){
			nivel += 1
			self.siguiente()
		} else{ pantallaWin.config() }
	}
	
	method nivelActual() = niveles.get(self.nivel())
	
	method siguiente(){
		const nivelSiguiente = niveles.get(self.nivel())
		nivelSiguiente.config()
	}
	
	method sumarPunto(cantidad){ puntos += cantidad}
	
	method configurarEscenarioDesierto(){
		niveles.add(nivelUnoDesierto)
		niveles.add(nivelDosDesierto)
	}
	
	method configurarEscenarioCiudad(){
		niveles.add(nivelUnoCiudad)
		niveles.add(nivelDosCiudad)
	}
	
}


// configuracion general de los niveles
class Niveles{
    var property llegadas = []
    var property autos = []
    var property bloqueadores = []
    var property vidas = new Vidas()
    var property fondo = 0
    var property puntos = 0
    var property metasAlcanzadas = 0
    const property totalMetas
    
    method config() {
		game.clear()
        fondos.setImage()
        game.addVisual(fondos)
        game.addVisual(contadorPuntos)
        
  		self.initialize()
  		self.configurarMeta()
        self.visualAdicional()
        
        game.addVisual(rana)
        game.addVisual(vidas)
        rana.initialize()
        vidas.initialize()
        estrella.agregarEstrella()
        
        // Añade los bloqueadores
        nivel.nivelActual().bloqueadores().forEach { obs => game.addVisual(obs) }
        
        // Añade los autos
        nivel.nivelActual().autos().forEach { auto => game.addVisual(auto) }
        
        // Añade las llegadas
        llegadas.forEach { llegada => game.addVisual(llegada) }
        
        // Mueve los autos constantemente
		nivel.nivelActual().autos().forEach{ auto =>
			game.onTick(300, "moverAuto", {auto.desplazarse()} )
		}
        
        // Comprueba si le ocurre algo a la rana
        game.onTick(100, "comprobarColisiones", {
        	self.verificarColisionesAdicionales()
    	})
    	
		// Configuración del teclado para mover la rana
		keyboard.up().onPressDo{moverArriba.mover()}
		keyboard.down().onPressDo{moverAbajo.mover()}
		keyboard.left().onPressDo{moverIzquierda.mover()}
		keyboard.right().onPressDo{moverDerecha.mover()}

		// Configurar según el nivel
        self.configurarAdicional()
        self.verificarColisionesYFilas()

    }
    
    method verificarColisionesYFilas() {
        game.whenCollideDo(rana, { x => x.colisionarConRana()})
    }
    
    method randomPosition() = (0..20).anyOne() 
    
	method configurarMeta(){ metasAlcanzadas = 0 }
	
	method configurarPuntos(){nivel.puntos(0)}
	
	method aumentarMetasAlcanzadas(){ metasAlcanzadas += 1 }
	
    method configurarAdicional(){}
    
    method visualAdicional(){}
    
    method verificarColisionesAdicionales() {}
    
    method initialize(){}
}

// configuracion específica de los niveles ciudad
class NivelesCiudad inherits Niveles{
	var property troncos = []
	var property nenufares = []
	
	override method visualAdicional(){
        troncos.forEach { tronco => game.addVisual(tronco) } // Añade los troncos
        nenufares.forEach { tronco => game.addVisual(tronco) } // Añade los troncos
	}
	
	override method configurarAdicional(){	
		// Mueve los troncos
		troncos.forEach{ tronco =>
			game.onTick(350, "moverTronco", {tronco.desplazarse()})
		}
	}
	
	override method verificarColisionesAdicionales(){
		rana.comprobarFila(15, troncos) // Comprobar fila de troncos
	}
}

// configuracion específica de los niveles desierto
class NivelesDesierto inherits Niveles{
	var property trenes = []
    var property vagones = []
    var property cactus = []
    var property plantas = []
    
    override method visualAdicional(){	
		// Añade los cactus
		cactus.forEach {cacti => game.addVisual(cacti)}
		// Añade las plantas rodadoras
		plantas.forEach {planta => game.addVisual(planta)}
	}
  
}

object nivelUnoCiudad inherits NivelesCiudad(fondo = 0, totalMetas = 2 ){
	
	method initialize(){
		self.configurarPuntos()
		
		llegadas = [
			new Llegada(position = game.at(5,18)), 
			new Llegada(position = game.at(13,18))
		]
		
		troncos = [
	        new TroncoDerecha(position = game.at(2,15)),
	        new TroncoDerecha(position = game.at(8,15)),
	        new TroncoDerecha(position = game.at(14,15)),
	        new TroncoDerecha2(position = game.at(3,15)),
	        new TroncoDerecha2(position = game.at(9,15)),
	        new TroncoDerecha2(position = game.at(15,15))
		]

		autos = [ 
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoIzquierda(position = game.at(self.randomPosition(),4)),
			new AutoIzquierda(position = game.at(self.randomPosition(),4)),
			new AutoIzquierda(position = game.at(self.randomPosition(), 4)),
			new AutoDerecha(position = game.at(self.randomPosition(),6)),
			new AutoDerecha(position = game.at(self.randomPosition(),6)),
			new AutoIzquierda(position = game.at(self.randomPosition(),7)),
			new AutoIzquierda(position = game.at(self.randomPosition(), 7)),
			new AutoDerecha(position = game.at(self.randomPosition(),13)),
			new AutoDerecha(position = game.at(self.randomPosition(),13)),
			new AutoDerecha(position = game.at(self.randomPosition(),13)),
			new AutoIzquierda(position = game.at(self.randomPosition(),12)),
			new AutoIzquierda(position = game.at(self.randomPosition(),12))
			
		]
	
		bloqueadores = [
	        new CartelStop(position = game.at(14,2)),
	        new Valla(position = game.at(1,8)),
	        new Valla(position = game.at(2,8)),
	        new Valla(position = game.at(3,8)),
	        new Valla(position = game.at(4,8)),
	        new Valla(position = game.at(5,8)),
	        new Valla(position = game.at(6,8)),
	        new Valla(position = game.at(7,8)),
	        new Valla(position = game.at(11,8)),
	        new Valla(position = game.at(12,8)),
	        new Valla(position = game.at(13,8)),
	        new Valla(position = game.at(14,8)),
	        new Valla(position = game.at(15,8)),
	        new Valla(position = game.at(16,8)),
	        new Valla(position = game.at(17,8)),
	        new Valla(position = game.at(18,8))
		]
		
		nenufares = [
			new Nenufar(position = game.at(5,10)),
	    	new Nenufar(position = game.at(11,10)),
	    	new Nenufar(position = game.at(17,10))
		]
	}
	

	override method configurarAdicional(){
		super()
		
		nenufares.forEach{ nenufar =>
			game.onTick(3000, "nenufar", {nenufar.reaparecerEnFilaEspecifica(10)})
		}
	}
		
	override method verificarColisionesAdicionales() {
	    super()
	    rana.comprobarFila(10, nenufares)
	}
	
}


object nivelDosCiudad inherits NivelesCiudad(fondo = 1, totalMetas = 3){
	
	method initialize(){
		llegadas = [
			new Llegada(position = game.at(5,16)), 
			new Llegada(position = game.at(9,16)),
			new Llegada(position = game.at(13,16))
		]
		
		nenufares = [
	    	new Nenufar(position = game.at(5,15)),
	    	new Nenufar(position = game.at(9,15)),
	    	new Nenufar(position = game.at(13,15)),
	    	new Nenufar(position = game.at(2,12)),
	    	new Nenufar(position = game.at(9,12)),
	    	new Nenufar(position = game.at(16,12))
    	]
    
    	troncos = [
		    new TroncoDerecha(position = game.at(1,13)),
		    new TroncoDerecha2(position = game.at(2,13)),
		    new TroncoDerecha(position = game.at(7,13)),
		    new TroncoDerecha2(position = game.at(8,13)),
		 	new TroncoDerecha(position = game.at(13,13)),
		    new TroncoDerecha2(position = game.at(14,13))
		]
	    
		autos = [ 
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoDerecha(position = game.at(self.randomPosition(),5)),
			new AutoDerecha(position = game.at(self.randomPosition(),8)),
			new AutoDerecha(position = game.at(self.randomPosition(),8)),
			new AutoIzquierda(position = game.at(self.randomPosition(),7)),
			new AutoIzquierda(position = game.at(self.randomPosition(),4)),
			new AutoIzquierda(position = game.at(self.randomPosition(),4))
		]
		
		bloqueadores = [
	        new Valla(position = game.at(2,16)),
	        new Valla(position = game.at(3,16)),
	        new Valla(position = game.at(4,16)),
	        new Valla(position = game.at(6,16)),
	        new Valla(position = game.at(7,16)),
	        new Valla(position = game.at(8,16)),
			new Valla(position = game.at(10,16)),
			new Valla(position = game.at(11,16)),
			new Valla(position = game.at(12,16)),
			new Valla(position = game.at(14,16)),
			new Valla(position = game.at(15,16)),
			new Valla(position = game.at(16,16)),
			new Valla(position = game.at(17,16)),
			new Valla(position = game.at(18,16))
		]
	}
	
	override method configurarAdicional(){
		super()
		nenufares.forEach{ nenufar =>
        	game.onTick(2000, "alternarVisibilidad", { nenufar.alternarVisibilidad() })
    	}
	}
		
	override method verificarColisionesAdicionales() {
	    // Comprobar fila de nenúfares y troncos
	    rana.comprobarFila(15, nenufares)
		rana.comprobarFila(12, nenufares)
	    rana.comprobarFila(13, troncos)
	}
	
}


object nivelUnoDesierto inherits NivelesDesierto(fondo = 2, totalMetas = 2){
	
	method initialize(){
		self.configurarPuntos()
		
		llegadas = [
			new Llegada(position = game.at(5,18)), 
			new Llegada(position = game.at(13,18))
		]
		
		cactus = [ 
			new Cactus(position = game.at(2,6)),
			new Cactus(position = game.at(9,6)),
			new Cactus(position = game.at(17,6)),
			new Cactus(position = game.at(0,14)),
			new Cactus(position = game.at(13,14)),
			new Cactus(position = game.at(18,14)),
			new Cactus(position = game.at(7,12)),
			new Cactus(position = game.at(3,12)),
			new Cactus(position = game.at(14,12))
		]
	
		autos = [ 
			new AutoDerecha(position = game.at(0,3)),
			new AutoDerecha(position = game.at(self.randomPosition(),3)),
			new AutoIzquierda(position = game.at(20,4)),
			new AutoDerecha(position = game.at(0,10)),
			new AutoDerecha(position = game.at(self.randomPosition(),10)),
			new AutoDerecha(position = game.at(self.randomPosition(),10)),
			new AutoIzquierda(position = game.at(20,11)),
			new AutoIzquierda(position = game.at(self.randomPosition(),11)),
			new AutoIzquierda(position = game.at(0,9)),
			new AutoIzquierda(position = game.at(self.randomPosition(),9)),
			new AutoIzquierda(position = game.at(self.randomPosition(),9)),
			new AutoDerecha(position = game.at(0,8)),
			new AutoDerecha(position = game.at(self.randomPosition(),8)),
			new AutoIzquierda(position = game.at(20,15)),
			new AutoIzquierda(position = game.at(self.randomPosition(),15)),
			new AutoDerecha(position = game.at(0,16)),
			new AutoDerecha(position = game.at(9,16))
		]
		
		plantas = [
			new PlantaRodadora(position = game.at(20, 7)),
			new PlantaRodadora(position = game.at(15, 7)),
			new PlantaRodadora(position = game.at(10, 7)),
			new PlantaRodadora(position = game.at(5, 7)),
			new PlantaRodadora(position = game.at(20, 17)),
			new PlantaRodadora(position = game.at(15, 17)),
			new PlantaRodadora(position = game.at(10, 17)),
			new PlantaRodadora(position = game.at(5, 17))
		]
		
	}
	
	override method configurarAdicional(){
		// Mueve las plantas
		game.onTick(200, "moverPlantas", {
			plantas.forEach{planta => planta.desplazarse()}
		})
	}
	
}


object nivelDosDesierto inherits NivelesDesierto(fondo = 3, totalMetas = 3){

	method initialize(){
		llegadas = [
			new Llegada(position = game.at(5,17)), 
			new Llegada(position = game.at(9,17)),
			new Llegada(position = game.at(13,17))
		]
		
		trenes = [
			new Locomotora(position = game.at(0,3)),
			new Vagon(position = game.at(-1,3)),
			new Vagon(position = game.at(-2,3)),
			new Vagon(position = game.at(-3,3)),
			new Vagon(position = game.at(-4,3)),
			new Vagon(position = game.at(-5,3)),
			new Vagon(position = game.at(-6,3)),
			new Vagon(position = game.at(-7,3)),
			new Locomotora(position = game.at(0,16)),
			new Vagon(position = game.at(-1,16)),
			new Vagon(position = game.at(-2,16)),
			new Vagon(position = game.at(-3,16)),
			new Vagon(position = game.at(-4,16)),
			new Vagon(position = game.at(-5,16)),
			new Vagon(position = game.at(-6,16)),
			new Vagon(position = game.at(-7,16))
		]

		cactus = [ 
			new Cactus(position = game.at(2,6)),
			new Cactus(position = game.at(9,6)),
			new Cactus(position = game.at(17,6)),
			new Cactus(position = game.at(0,10)),
			new Cactus(position = game.at(13,10)),
			new Cactus(position = game.at(18,10)),
			new Cactus(position = game.at(7,12)),
			new Cactus(position = game.at(3,12)),
			new Cactus(position = game.at(14,12)),
			new Cactus(position = game.at(5,15)),
			new Cactus(position = game.at(9,15)),
			new Cactus(position = game.at(13,15))
		]
		
		bloqueadores = [
			new Valla(position = game.at(2,17)),
			new Valla(position = game.at(3,17)),
			new Valla(position = game.at(4,17)),
			new Valla(position = game.at(6,17)),
			new Valla(position = game.at(7,17)),
			new Valla(position = game.at(8,17)),
			new Valla(position = game.at(10,17)),
			new Valla(position = game.at(11,17)),
			new Valla(position = game.at(12,17)),
			new Valla(position = game.at(14,17)),
			new Valla(position = game.at(15,17)),
			new Valla(position = game.at(16,17)),
			new Valla(position = game.at(17,17))
		]
		
		plantas = [
			new PlantaRodadora(position = game.at(20, 4)),
			new PlantaRodadora(position = game.at(10, 4)),
			new PlantaRodadora(position = game.at(20, 11)),
			new PlantaRodadora(position = game.at(15, 7))
		]	
	
		autos = [
			new AutoDerecha(position = game.at(0,8)),
			new AutoIzquierda(position = game.at(20,9)),
			new AutoDerecha(position = game.at(0,14)),
			new AutoIzquierda(position = game.at(20,13))
		]
	
	}
		
	override method visualAdicional(){	
		super()
		// Añade los trenes
		trenes.forEach {tren => game.addVisual(tren)}
	}
	
	override method configurarAdicional(){
		// Mueve los trenes y plantas
		game.onTick(100, "moverObjetos", {
			plantas.forEach{planta => planta.desplazarse()}
			trenes.forEach{tren => tren.desplazarse()}
		})
	}
}



