import src.hud.*
import src.Personajes.posiciones.*
import wollok.game.*
import elementos.*
import Personajes.personaje.*
import enemigo.*
import juego.*
import escenografia.*
import salida.*
import Personajes.armas.*
import colisiones.*

class Nivel{

}
class Sector{
    //var property duenio = enemigoHibrido
    var property esObstaculo=false //NUEVO - camila211125
    
    method generarPosicionLibreRandom(){
        var posicionesLibres = []
        var ocupadas = game.allVisuals().map({v => [v.position().x(), v.position().y()]})

            (1..10).forEach{x =>
                (1..10).forEach{y =>
                    if(not ocupadas.contains([x,y])){
                        posicionesLibres.add(game.at(x,y))
                    }
                }
            }
            
            return posicionesLibres.anyOne()
            /*var xs = [1,2,3,4,5,6,7,8,9,10]
            var ys = [1,2,3,4,5,6,7,8,9,10]

        xs.forEach{x =>
            ys.forEach{y =>
                const ocupado = game.allVisuals().any({
                    visual =>
                        visual.position().x() == x and
                        visual.position().y() == y
                })
                if(not ocupado){
                    posicionesLibres.add(game.at(x,y))
                }
            }
        }*/
        //return posicionesLibres.anyOne()
    }

    method generarArmas(){
        var cantidadArmas = [0,1,2]
        var tipoArma = ["escopeta", "ametralladora"]

        var cantArma = cantidadArmas.anyOne()

        cantArma.times({_ =>
            var tipo = tipoArma.anyOne()
            var arma = null

            if(tipo == "escopeta"){
                arma = new Escopeta()
            } else {
                arma = new Ametralladora()
            }

            var pos = self.generarPosicionLibreRandom()

            armasMundo.dejarArma(pos, arma)
        })
    }
    
    /*method generaritems(obj){
             
        }*/
    /*method reubicaritems(items){
        items.forEach{a=>a.cambioposicion(3, 1)}
    }*/
   method cargarEscena(){
    productorDeEscenas.renderizarEsquinas()
   }

   method limpiarSector(){
        //game.allVisuals().forEach({v => game.removeVisual(v)})
        game.clear()
        
        colisiones.limpiar()
        game.addVisual(hudVidas)
        game.addVisual(hudMunicion)
        game.addVisual(hudMejora)
   }

   method cargar(){
        self.limpiarSector()
        self.cargarEscena() 
        //duenio.generarManadas(self)
        //self.generarArmas()
        personaje.configTeclas()
        game.addVisual(personaje)
        self.generarArmas()
        //game.schedule(100,{duenio.generarManadas(self)})
   }
} 
object sector1 inherits Sector{
    method cargainicial() {
        self.limpiarSector()
        
        self.cargarEscena() 
        
        
        personaje.configTeclas()
        
        const enemigo_ = new EnemigoCorredor()
        game.addVisual(enemigo_)
        game.addVisual(personaje)
        colisiones.enemigos().add(enemigo_)
        
        self.generarArmas()
        //game.schedule(100,{duenio.generarManadas(self)})
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()})
        
        
    }
   /*override method cargar() {
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        game.addVisual(enemigo_)
   }*/
   override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector9,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector4,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector2,game.at(5,1))
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
   }
}
object sector2 inherits Sector{
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector8,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector3,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoArriba,sector10,game.at(5,1))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoAbajo,sector1,game.at(5,10))
   }
   override method cargar(){
    super()
    const enemigo1 = new EnemigoZangano()
    colisiones.enemigos().add(enemigo1)
    game.addVisual(enemigo1)
        game.onTick(enemigo1.velocidad(), "seguimiento", {enemigo1.perseguir()})
   }
}
object sector3 inherits Sector{
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector2,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoIzquierdo,sector5,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoArriba,null,null)
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
	
   }
   override method cargar(){
    super()
    const enemigo1 = new EnemigoZangano()
    const enemigo2 = new EnemigoZangano()
    colisiones.enemigos().add(enemigo1)
    colisiones.enemigos().add(enemigo2)

    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
        game.onTick(enemigo1.velocidad(), "seguimiento", {enemigo1.perseguir()})
        game.onTick(enemigo2.velocidad(), "seguimiento", {enemigo2.perseguir()})
   }
}
object sector4 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector1,game.at(1,5))
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoIzquierdo,sector6,game.at(10,5))
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoAbajo,sector7,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
	
   }
   override method cargar(){
    super()
    const enemigo1 = new EnemigoZangano()
    const enemigo2 = new EnemigoZangano()
    colisiones.enemigos().add(enemigo1)
    colisiones.enemigos().add(enemigo2)

    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
        game.onTick(enemigo1.velocidad(), "seguimiento", {enemigo1.perseguir()})
        game.onTick(enemigo2.velocidad(), "seguimiento", {enemigo2.perseguir()})
   }
}

object sector5 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector3,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
   override method cargar(){
        super()
        const superviviente=new Superviviente()
        game.addVisual(superviviente)
        colisiones.obstaculos().add(superviviente)
   }
}

object sector6 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector4,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
   override method cargar(){
        super()
        const superviviente=new Superviviente()
        game.addVisual(superviviente)
        colisiones.obstaculos().add(superviviente)
   }
}
       
object sector7 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoArriba,sector4,game.at(5,1))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
   override method cargar(){
        super()
        const superviviente=new Superviviente()
        game.addVisual(superviviente)
        colisiones.obstaculos().add(superviviente)
   }
}

object sector8 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector2,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
	
   }
    override method cargar(){
        super()
    const enemigo1 = new EnemigoZangano()
    const enemigo2 = new EnemigoZangano()
    const enemigo3 = new EnemigoCorredor()
    colisiones.enemigos().add(enemigo1)
    colisiones.enemigos().add(enemigo2)
    colisiones.enemigos().add(enemigo3)

    game.addVisual(enemigo1)
    game.addVisual(enemigo2)
    game.addVisual(enemigo3)
        game.onTick(enemigo1.velocidad(), "seguimiento", {enemigo1.perseguir()})
        game.onTick(enemigo2.velocidad(), "seguimiento", {enemigo2.perseguir()})
        game.onTick(enemigo3.velocidad(), "seguimiento", {enemigo3.perseguir()})
   }
}
object sector9 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarVertical(11,paredDer,(1..10))
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector1,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
	
   }
   override method cargar(){
    super()
    const enemigo1 = new EnemigoCorredor()
    colisiones.enemigos().add(enemigo1)
    game.addVisual(enemigo1)
        game.onTick(enemigo1.velocidad(), "seguimiento", {enemigo1.perseguir()})
   }
}


object sector10 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoAbajo,sector2,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
   }
   override method cargar(){
        super()
        const superviviente=new Superviviente()
        game.addVisual(superviviente)
        colisiones.obstaculos().add(superviviente)
   }
}

 
