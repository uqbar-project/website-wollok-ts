import protagonista.*
import enemigos.*
import visualesExtra.*
import escenariosManager.*
import gestores.*
import puertas.*

// ################################################################################################################# \\

// Los escenarios mapas sirven para poder dibujar en el tablero a los diferentes visuales en posiciones exactas, esto
// se determina en la posición que se ubique dicho visual en la "matriz" o "lista de listas".

// ################################################################################################################# \\

class Elemento{ 
    const visual // Representa al visual que tiene el elemento.

    method construir(position){
        // Construye al visual cargado en el elemento en la posición dada.
        visual.position(position)
    }
}

// ################################################################################################################# \\

class ElementoAgregado{
    const gestorAgregador // Representa el gestor que agrega los elementos al juego.

    method construir(posicion){
        // Crea el elemento en la posición dada para que el gestor lo agregue al juego.
        const elemento = self.crearElemento(posicion)
        game.addVisual(elemento)
        gestorAgregador.agregar(elemento)
    }

    method crearElemento(posicion) // Crea el elemento en la posición dada.
}

// ################################################################################################################# \\

class ElementoLobo inherits ElementoAgregado(gestorAgregador = gestorDeLobos){

    override method crearElemento(posicion){
        // Crea el elemento en la posición dada, en este caso es un lobo.
        return new Lobo(position = posicion)
    }
}

// ################################################################################################################# \\

class ElementoObstaculo inherits ElementoAgregado(gestorAgregador = gestorDeObstaculos){

    override method crearElemento(posicion){
        // Crea el elemento en la posición dada, en este caso es un obstáculo.
        return new Obstaculo(position = posicion)
    }
}
// ################################################################################################################# \\

class ElementoPared inherits ElementoObstaculo{

    override method crearElemento(posicion){
        // Crea el elemento en la posición dada, en este caso es una pared.
        return new ParedInvisible(position = posicion)
    }
}

// ################################################################################################################# \\

class ElementoLoboEspecial inherits ElementoLobo{

    override method construir(posicion){
        // Crea el elemento en la posición dada para que el gestor lo agregue al juego.
        super(posicion)
        puertaGranero.irHacia(entradaGranero)
    }

    override method crearElemento(posicion){
        // Crea el elemento en la posición dada, en este caso es un lobo especial.
        return new LoboEspecial(position = posicion)
    }
}
// ################################################################################################################# \\

object _ { //Representa la nada (ausencia de objetos) en un tablero en una posicion dada
    
    method construir(position){} // Método conservado solamente por polimorfismo.
}

// ############################################ ELEMENTOS PARA EL MAPA ############################################# \\

object o inherits ElementoObstaculo{}

object p inherits ElementoPared{}

object l inherits ElementoLobo{}

object j inherits ElementoLoboEspecial{}
   
object g inherits Elemento(visual = guardabosques){}

object z inherits Elemento(visual = protagonista){} 

object f inherits Elemento(visual = fogataOBJ){}

object v inherits Elemento(visual = carpa){}

object a inherits Elemento(visual = amiga){}

object n inherits Elemento(visual = nota){}

object x inherits Elemento(visual = cabañaOBJ){}

object q inherits Elemento(visual = graneroOBJ){}

object u inherits Elemento(visual = leña){}

object h inherits Elemento(visual = hacha){}

object m inherits Elemento(visual = manopla){}

object s inherits Elemento(visual = auto){}

object tr inherits Elemento(visual = tridente){}

object po inherits Elemento(visual = puertaOeste){}

object pn inherits Elemento(visual = puertaNorte){}

object pe inherits Elemento(visual = puertaEste){}

object ps inherits Elemento(visual = puertaSur){}

object pg inherits Elemento(visual = puertaEntradaCabaña){}

object pc inherits Elemento(visual = puertaEntradaCueva){}

object pq inherits Elemento(visual = puertaGranero){}

// ################################################################################################################# \\

const mapaComun = 
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]
    ].reverse()

// ################################################################################################################# \\

const mapaEscenarioInicialV1 = 
    [
        [ p , p , p , p , p , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , p , p , p , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , p , p , p , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , _ , _ , _ , _ , _ , a , z , _ , f , v , p , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV1 =
    [
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , o , o , _ , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , z , _ , _ , _ , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV2 =     
    [
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , z , _ ],
        [ _ , _ , _ , o , o , l , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , l , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , l , _ , p , p , p , p ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV3 =
    [
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ z , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , o , o , _ , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV4 = 
    [
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , o , o , _ , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , z , _ , _ , _ , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV5 =    
    [
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , z , _ ],
        [ _ , _ , _ , o , o , l , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , l , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , l , _ , p , p , p , p ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEscenarioBifurcacionV6 =
    [
        [ p , p , p , p , _ , _ , pn, _ , _ , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , o , o , _ , _ , _ , _ , _ , _ , _ , p ],
        [ z , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , o , o , _ , _ , _ , o , o , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEntradaCabañaV1 = 
    [
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , _ , _ , _ , _ , _ , p , p , p , _ , _ , p , _ ],
        [ _ , z , _ , _ , _ , x ,pg , p , p , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEntradaCabañaV2 = 
    [
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , _ , _ , _ , _ , _ , p , p , p , _ , _ , p , _ ],
        [ po , _ , _ , _ , z , x ,p , p , p , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEntradaCabañaV3 = 
    [
        [ p , p , p , _ , g , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , _ , _ , _ , _ , _ , p , p , p , _ , _ , p , _ ],
        [ _ , _ , _ , _ , z , x , p , p , p , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ]
    ].reverse() 

// ################################################################################################################# \\

const mapaEntradaCabañaV4 =   
    [
        [ p , p , p , _ , _ , _ , z , _ , p , p , p , p , _ ],
        [ p , p , p , _ , _ , _ , _ , _ , p , p , p , p , _ ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , _ , _ , _ , _ , _ , p , p , p , _ , _ , p , _ ],
        [ _ , _ , _ , _ , _ , x ,pg , p , p , _ , _ , _ , p ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , _ ]
    ].reverse() 

// ################################################################################################################# \\

const mapaCabañaInicialV1 = 
    [
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , p , p , p , p , p , p , p , p , p , _ , _ , _ ],
        [ _ , p , p , u , _ , _ , p , p , _ , p , _ , _ , _ ],
        [ _ , p , p , p , p , _ , _ , _ , _ , _ , p , _ , _ ],
        [ _ , p , pg, z , _ , _ , _ , _ , g , _ , p , _ , _ ],
        [ _ , p , p , p , _ , _ , _ , _ , _ , _ , p , _ , _ ],
        [ _ , p , p , p , p , p , p , p , p , p , p , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]
    ].reverse()   

// ################################################################################################################# \\

const mapaCabañaInicialV2 = 
    [
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , p , p , p , p , p , p , p , p , p , _ , _ , _ ],
        [ _ , p , p , u , _ , _ , p , p , _ , p , _ , _ , _ ],
        [ _ , p , p , p , p , _ , _ , _ , _ , l , p , _ , _ ],
        [ _ , p , pg, z , _ , _ , _ , n , _ , l , p , _ , _ ],
        [ _ , p , p , p , _ , _ , _ , _ , _ , _ , p , _ , _ ],
        [ _ , p , p , p , p , p , p , p , p , p , p , _ , _ ],
        [ _ , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ]
    ].reverse()   
  
// ################################################################################################################# \\

const mapaEntradaCuevaV1 =
    [
        [ _ , _ , p , p , p , p , p , p , p , p , _ , p , p ],
        [ _ , _ , p , _ , _ , _ , p , _ , _ , _ , p , p , p ],
        [ _ , p , p , p , p , p , p , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , pc, _ , _ , l , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , z , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , l , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaEntradaCuevaV2 = 
    [
        [ _ , _ , p , p , p , p , p , p , p , p , _ , p , p ],
        [ _ , _ , p , _ , _ , _ , p , _ , _ , _ , p , p , p ],
        [ _ , p , p , p , p , p , p , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , z , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaEntradaCuevaV3 =
    [
        [ _ , _ , p , p , p , p , p , p , p , p , _ , p , p ],
        [ _ , _ , p , _ , _ , _ , p , _ , _ , _ , p , p , p ],
        [ _ , p , p , p , p , p , p , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , pc, _ , l , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , z , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , l , _ , _ , _ , _ , _ ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaCuevaV1 =
    [
        [ _ , _ , _ , _ , _ , _ , pc, _ , _ , _ , _ , _ , _ ],
        [ o , o , o , _ , o , _ , o , o , o , o , _ , o , _ ],
        [ _ , l , _ , _ , o , _ , _ , _ , l , _ , _ , _ , _ ],
        [ _ , o , o , _ , o , _ , o , o , _ , o , _ , o , _ ],
        [ _ , o , _ , _ , _ , _ , _ , o , _ , _ , _ , o , _ ],
        [ _ , o , _ , o , o , o , _ , o , o , o , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , l , _ , _ , _ , _ , o , _ ],
        [ o , _ , o , o , _ , o , o , o , o , o , o , o , _ ],
        [ _ , _ , _ , _ , _ , _ , z , _ , _ , _ , _ , _ , _ ]     
    ].reverse()

// ################################################################################################################# \\

const mapaCuevaV2 =
    [
        [ _ , o , _ , _ , _ , o , _ , _ , _ , _ , _ , o , _ ],
        [ _ , o , l , o , _ , o , _ , o , o , o , _ , o , _ ],
        [ _ , _ , _ , o , _ , _ , _ , _ , _ , l , _ , _ , _ ],
        [ o , o , _ , o , o , _ , o , o , _ , o , o , o , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o , pc],
        [ _ , o , o , o , o , l , _ , o , o , o , _ , o , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , o , _ , o , _ ],
        [ o , o , o , _ , o , o , o , o , _ , o , _ , o , _ ],
        [ _ , z , _ , _ , _ , _ , _ , _ , _ , o , _ , _ , _ ]
    ].reverse() 

// ################################################################################################################# \\

const mapaCuevaV3 =
    [
        [ z , _ , _ , o , _ , _ , _ , _ , _ , o , _ , _ , _ ],
        [ o , o , _ , o , o , o , o , _ , o , o , _ , o , _ ],
        [ _ , _ , _ , _ , _ , _ , o , _ , _ , _ , _ , o , _ ],
        [ o , o , _ , o , o , _ , o , l , o , o , _ , o , _ ],
        [ _ , _ , _ , _ , l , _ , o , _ , _ , _ , _ , o , _ ],
        [ _ , o , _ , o , o , o , o , _ , o , o , _ , o , _ ],
        [ l , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o , _ ],
        [ o , o , _ , _ , o , o , o , _ , o , o , o , o , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , o , pc, _ , _ ]
    ].reverse()   

// ################################################################################################################# \\

const mapaCuevaV4 =
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o , z , _ ],
        [ _ , o , o , o , o , _ , o , _ , o , o , o , _ , _ ],
        [ _ , _ , l , _ , o , _ , o , _ , _ , _ , _ , _ , _ ],
        [ o , o , _ , o , o , _ , o , _ , o , _ , o , o , _ ],
        [ _ , _ , _ , o , _ , _ , _ , l , o , _ , _ , o , _ ],
        [ _ , o , o , o , _ , o , o , o , o , _ , o , o , o ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , l , _ ],
        [ _ , _ , _ , o , o , o , o , o , o , _ , o , o , _ ],
        [ _ , _ , _ , _ , _ , _ , pc, o , _ , _ , _ , _ , _ ]
    ].reverse()  
   
// ################################################################################################################# \\

const mapaCuevaV5 =
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o , z , _ ],
        [ _ , o , o , o , o , _ , o , _ , o , o , o , _ , _ ],
        [ _ , _ , _ , _ , o , _ , o , _ , _ , _ , _ , _ , _ ],
        [ o , o , _ , o , o , _ , o , _ , o , _ , o , o , _ ],
        [ pc, _ , _ , o , _ , _ , _ , l , o , _ , _ , o , _ ],
        [ _ , o , o , o , _ , o , o , o , o , _ , o , o , o ],
        [ _ , _ , _ , l , _ , _ , _ , _ , _ , _ , _ , l , _ ],
        [ _ , _ , _ , o , o , o , o , o , o , _ , o , o , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , o , _ , _ , _ , _ , _ ]
    ].reverse()  

// ################################################################################################################# \\

const mapaEntradaGraneroV1 = 
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ],
        [ p , _ , _ , _ , _ , p , p , p , p , _ , _ , p , p ],
        [ p , _ , _ , _ , _ , q , pq, _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , _ , g , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , p , p , _ , _ , _ , z , _ , _ , _ , p , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaEntradaGraneroV2 =    
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ p , p , p , p , p , p , p , p , p , p , p , p , p ],
        [ p , _ , _ , _ , _ , p , p , p , p , _ , _ , p , p ],
        [ p , _ , _ , _ , _ , q , pq, _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , _ , _ , _ , z , _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , p , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , p , p , _ , _ , _ , _ , _ , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\

const mapaPeleaGranero = 
    [
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , tr, _ , _ , m , _ , _ , h , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , l , _ , l , _ , _ , _ , l , _ , l , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , j , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _ , z , _ , _ , _ , _ , _ , _ ],
        [ _ , _ , _ , _ , _ , _, pq , _ , _ , _ , _ , _ , _ ]
    ].reverse()

// ################################################################################################################# \\

const mapaFinalJuego =
    [
        [ o , o , o , o , o , o , o , o , o , o , o , o , o ],
        [ o , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , l , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , _ , _ , _ , g , _ , _ , _ , _ , _ , z , pc, o ],
        [ o , l , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , o ],
        [ o , o , o , o , o , o , o , o , o , o , o , o , o ]
    ].reverse()

// ################################################################################################################# \\

const mapaEstacionamientoV1 = 
    [
        [ p , p , p , p , _ , _ , _ , _ , p , p , p , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , p , p , p , p ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , p , _ , _ , _ , _ , p , p , _ , _ , p ],
        [ p , _ , _ , s , _ , _ , _ , _ , _ , _ , _ , _ , p ],
        [ p , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , p , p ],
        [ p , p , p , _ , _ , _ , _ , _ , _ , _ , p , p , p ],
        [ p , p , p , p , _ , _ , z , _ , p , p , p , p , p ]
    ].reverse()

// ################################################################################################################# \\