import src.Personajes.balas.*
import src.hud.*

import mapas.*
import elementos.*
import enemigo.*
import wollok.game.*
import Personajes.personaje.*
import Personajes.armas.*
import colisiones.*

object juego{
    var property gameOverActivo = false
    const enemigoC1 = new EnemigoCorredor(vida=3,objetivo=caja)

    method iniciar(){
        
        var activo = true
        game.addVisual(inicio)
        keyboard.space().onPressDo{if(activo){sector1.cargainicial() activo=false}} 
        

        // Dejo algunas armas en el mapa de ejemplo
        //armasMundo.dejarArmaEn(game.at(5, 5), new Escopeta())
        //armasMundo.dejarArmaEn(game.at(8, 8), new Ametralladora())
    }

    method estaAlLimite(posX,posY)=game.width()<posX || game.height()<posY|| posX<0 || posY<0 //si se pasa del tablero tanto negativo o fuera del rango
    
    method gameOver(){
        gameOverActivo = true

        game.clear()

        game.addVisual(objetoGameOver)
    }

    method gameOverBueno() {
        gameOverActivo = true
        
        game.clear()               // limpia la pantalla

        game.addVisual(finBueno)        

    }



    method generarObstaculos(){
        /*[9,10,11,12,13,14,15].forEach({ elemento=>
        //const obstaculoA_ = new Obstaculo()
        const obstaculoB_ = new Obstaculo()
        //obstaculoA_.position(game.at(elemento, 3))
        obstaculoB_.position(game.at(elemento, 9))
        game.addVisual(obstaculoB_)})
        
        [2,3,4,5].forEach({ elemento=>
        const obstaculov_ = new Obstaculo()
        obstaculov_.position(game.at(7, elemento))
        game.addVisual(obstaculov_)})*/
    }
}

/*
capacidades

object identificadroColision -> EN REVISION
object generador: sobreiviente y enemigos
*/
object buscadorRutas{
    var property openSet = [] //celdas a analizar: mis vecinos/celdas donde de todas ellas tomaremos el mejor
    var property closeSet =[] //celdas que hemos revisado
    //var posicionAnt=objetivo.position() //debe ser propio del personaje, cambiar despues
     //const posiciones = [game.at(1, 2),game.at(1, 3),game.at(1, 4),game.at(1, 5),game.at(1, 6),game.at(2, 6)]
    //method posicionDelMenor(personaje)=[personaje.position().x(),personaje.position().y()]
    //method posicionAnt(objetivo)=objetivo.position()

  
    method calcularDistanciaEuclidiana(destino,llegada){ //si ambos vecinos tienene f igual, elegimos la distancia euclidiana mas convenitne, xq no usar euclidiana en todas xq puede calcularse con el enemigo cerca y en si en poco practica porque puede haber un opbstaculo ahi y es mejor la distancia manhattan
        //armado de los vectores ó hipotenunsas, cada uno es una coordenada
        const abscisa=destino.x()-llegada.x()
        const coordenada=destino.y()-llegada.y()
        //calculo del modulo de ambos vector
        //console.println("De"+destino+" es : "+(abscisa**2+coordenada**2)**0.5)
        return (abscisa**2+coordenada**2)**0.5
        
    }
    

    method celdaLibre(posVecinoX,posVecinoY){
        const obstaculo=new Obstaculo()
        return !self.closeSet().contains([posVecinoX,posVecinoY]) && !obstaculo.estaEnCelda(posVecinoX,posVecinoY) && !juego.estaAlLimite(posVecinoX,posVecinoY) //celda libre significa que no fue revisado, que no esta al limite y que no tiene obstaculo
    }
    
    
    method agregarVecino(posVecinoX,posVecinoY){
        
        if(self.celdaLibre(posVecinoX,posVecinoY)) {
            openSet.add([posVecinoX,posVecinoY])
        }else{
            //console.println("No elegido: "+[posVecinoX, posVecinoY])
        }
        

    }
    method openSet(eneX,eneY){ //cargas celdas pretendientes
        /*digamos tengo la posicon (4,6)
        quiero las posiciones (analizando que no hayan sido analizados ó que no esté ahi obstaculos)*/
        /*
            (3,6)
        (4,5)     (4,7)
             (5,6)*/
       
    
        //closeSet.add(game.at(eneX,eneY))
        //closeSet.add([eneX,eneY]) //la posicion actual está siendo analizada por eso lo ponemos en closeSet - sirve esto xq si esta en closeSet significa que ya lo analice
        
        closeSet.add([eneX,eneY]) //agregamos la posicion inicial para que no sea evaluada
        // 9,5
        self.agregarVecino(eneX-1, eneY)  //(3,6)

        self.agregarVecino(eneX, eneY-1) //(4,5)
        
        self.agregarVecino(eneX, eneY+1)  //(4,7)
        
        self.agregarVecino(eneX+1, eneY) //(5,6)
        
    }

    method costoPor(posicion_,posActual)=(posActual.first()-posicion_.x()).abs()+(posActual.last()-posicion_.y()).abs()
    //obtenemos "h"
    
    method costoTotalF(posicionInicial,posicionObjetivo,posicionActual)=self.costoPor(posicionObjetivo,posicionActual)+self.costoPor(posicionInicial,posicionActual)
    
    method tomarLaMejorCelda(posicionEnemigo,posicionObjetivo){
        var elMenor=100 //por los valores dde la tabla nunca llegaremos a 100
        var posicionDelMenor//=[posicionEnemigo.x(),posicionEnemigo.y()]
        
        self.openSet(posicionEnemigo.x(),posicionEnemigo.y()) //cargar el openSet de celdas pretendientes
        
        //cada celda tiene un costoTotal desde donde estaMiEnemigo hasta llegar al objetivo ,desde la celda pretendiente
        openSet.forEach({posicion=> 
                    var f=0    
                    f=self.costoTotalF(posicionEnemigo, posicionObjetivo,posicion)
                    /*console.println("analizando: "+posicion)
                    console.println("f: "+f)*/
                    //console.println("Mensaje a mostrar en consola: "+vecino_.f())
                    //si son iguales elegir el menor de la distancia euclides
                    if(f<elMenor) {
                        elMenor=f/*;posicionDelMenor=vecino.position()*/
                        posicionDelMenor=game.at(posicion.first(),posicion.last())
                    }else if(f==elMenor){ //si son iguales elegimos el que tenga distancia menor euclideana
                        const dist_f=self.calcularDistanciaEuclidiana(game.at(posicion.first(),posicion.last()), posicionObjetivo)
                        const dist_elMenor=self.calcularDistanciaEuclidiana(posicionDelMenor, posicionObjetivo)
                        if(dist_f<dist_elMenor){
                            elMenor=f
                            posicionDelMenor=game.at(posicion.first(),posicion.last())
                        }
                        /*console.println("-ganador: "+posicionDelMenor)
                        console.println("-objetivo: "+posicionObjetivo)
                        console.println("-enemigo: "+ posicionEnemigo)*/
                    } 
                    
                })
                //nos interesa la posicion con el f menor de todos
                //self.openSet().add(posicionEnemigo) //lo añadimos adredre para que vaya al closeSet y no sea analizado 
                self.closeSet().addAll(self.openSet())
                self.openSet().clear()
                return posicionDelMenor           
    }

    method reiniciarAnalisis(){
        self.closeSet().clear()
        self.openSet().clear()
        //posicionDelMenor=[self.position().x(),self.position().y()]
        
    }

}
