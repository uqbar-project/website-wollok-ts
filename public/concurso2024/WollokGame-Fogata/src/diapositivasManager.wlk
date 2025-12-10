import videojuego.*
import escenariosManager.*
import wollok.game.*
// ##################################################################################################################################################### \\

object gestorDeDiapositivas{ 
    var property peliculaAMostrar    = peliculaInicioJuego // Representa la pelicula con sus respectivas diapositivas a mostrar. 
    var property bloqueFinalizacion  = inicioJuegoD        // Representa el bloque que contiene lo que pasa al finalizar la última diapositiva de la escena.
    var property esHoraDeDiapositiva = true                // Representa el valor que indica si es momento de mostrar diapositivas en el juego o no.

    // ================================================================================================================================================= \\

    method interactuarDiapositivas(){
        // Gestiona el uso de las diapositivas (mostrandolas y finalizando su uso) dependiendo de si es momento o no de mostrarlas. 
        if(self.esHoraDeDiapositiva()){ 
           self.gestionarDiapositivas()
        }
    }

    method gestionarDiapositivas(){
        // Gestiona la pelicula cargada con sus respectivas diapositivas. Si puede procesa la película, sino borra las diapositivas y vuelve a su estado por defecto.
        if(peliculaAMostrar.esLaUltimaDiapositiva()){
            peliculaAMostrar.borrarDiapositivasDelTablero()
            self.culminarDiapositivasYContinuar()
        } else {
            peliculaAMostrar.procesarDiapositiva()
        }
    } 
   
    method configurarParaSiguiente(nuevaPelicula, nuevoBloque){
        // Configura el gestor para pasar a la siguiente película y el nuevo bloque de finalización.
        self.esHoraDeDiapositiva(false)
        self.peliculaAMostrar(nuevaPelicula)
        self.bloqueFinalizacion(nuevoBloque)
    }

    method configuracionFinal(){
        // Configura el gestor a su configuración final, haciendo que no pueda mostrar más diapositivas y además que no haya ninguna pelicula a procesar.
        self.esHoraDeDiapositiva(false)
        self.peliculaAMostrar(null)
    }

    method culminarDiapositivasYContinuar(){
        //Finaliza la escena de diapositivas y se vuelve al gameplay
        bloqueFinalizacion.apply(videojuego, self)
    }
}

// ##################################################################################################################################################### \\

const inicioJuegoD =         {v, g => g.configurarParaSiguiente(peliculaAmigaMuerta, despuesDeAmigaMuerta);
                                      v.cambiarEscenario(fogata)}
   
const despuesDeAmigaMuerta = {v, g => g.configurarParaSiguiente(peliculaGranero, despuesDeGranero);
                                      bifurcacion.configuradorTotal(bifurcacionConfgV4, bifurcacionCESv4);
                                      v.cambiarEscenario(bifurcacion)}

const despuesDeGranero =     {v, g => g.configurarParaSiguiente(peliculaPeleaFinal, despuesDePeleaFinal);
                                      v.cambiarEscenario(granero)}

const despuesDePeleaFinal =  {v, g => g.configuracionFinal();
                                      v.cambiarEscenario(peleaFinal)}

// ##################################################################################################################################################### \\

class Pelicula{
    const pelicula                           // Representa la secuencia completa de diapositivas que se utilizan en varios puntos del juego.
    const iteradorPelicula = pelicula.copy() // Es el iterador que se utiliza para la película, su funcionamiento es simliar a una Queue. 

    // ================================================================================================================================================= \\

    method diapositivaActual(){
        // Describe la diapositiva actual de la película.
        return iteradorPelicula.first()
    }

    method esLaUltimaDiapositiva(){
        // Indica si es la última diapositiva de la película.
        return iteradorPelicula.isEmpty()
    }

    method procesarDiapositiva(){
        // Procesa la diapositiva actual de la película.
        self.dibujarYActualizar(self.diapositivaActual())
    }

    method dibujarYActualizar(diapositiva){
        // Dibuja la diapositiva dada y además la elimina del iterador de la película.
        game.addVisual(diapositiva)
        iteradorPelicula.remove(diapositiva)
    }

    method borrarDiapositivasDelTablero(){
        // Borra cada diapositiva de la película del juego y además elimina la película.
        pelicula.forEach({diapositiva => diapositiva.borrar()})
        pelicula.clear()
    }
}

// ##################################################################################################################################################### \\

const peliculaInicioJuego = new Pelicula(pelicula = [d0, d1, d2, d3, d4, d5, d6, d7, d8, d9])  // Representa una película con sus respectivas diapositivas.
const peliculaGranero     = new Pelicula(pelicula = [dg0, dg1, dg2])     // Representa una película con sus respectivas diapositivas.
const peliculaAmigaMuerta = new Pelicula(pelicula = [dam1, dam2, dam3])  // Representa una película con sus respectivas diapositivas.
const peliculaPeleaFinal  = new Pelicula(pelicula = [dpf1, dpf2, dpf3])  // Representa una película con sus respectivas diapositivas.

// ##################################################################################################################################################### \\

class Diapositiva{
    const position = game.at(0,0) // Representa la posición de la diapositiva.
    const image                   // Representa la imagen de la diapositiva.
    
    // ================================================================================================================================================= \\

    method esAtravesable(){
        // Describe si la diapositiva es atravesable o no por cualquier objeto, en este caso si.
        return true
    }
    
    method borrar(){
        // La diapositiva se borra a si misma del juego.
        return game.removeVisual(self)
    }

    method atacadoPor(visual){} // Método conservado por polimorfismo, no tiene una utilidad real en la diapositiva.

    // ================================================================================================================================================= \\

    method position(){
        // Describe la posición actual de la diapositiva. Aunque en realidad, solo se conserva por polimorfismo.
        return position
    }

    method image(){
        // Describe la imagen actual de la diapositiva.
        return image
    }
}

// ##################################################################################################################################################### \\
          
const dpf1 = new Diapositiva(image = "diapo-pelea-final2.png")  // Es una diapositiva con su respectiva imagen.
const dpf2 = new Diapositiva(image = "diapo-pelea-final3.png")  // Es una diapositiva con su respectiva imagen.
const dpf3 = new Diapositiva(image = "diapo-pelea-final4.png")  // Es una diapositiva con su respectiva imagen.

const dam1 = new Diapositiva(image = "diapo-amiga-muerta2.png") // Es una diapositiva con su respectiva imagen.
const dam2 = new Diapositiva(image = "diapo-amiga-muerta3.png") // Es una diapositiva con su respectiva imagen.
const dam3 = new Diapositiva(image = "diapo-amiga-muerta4.png") // Es una diapositiva con su respectiva imagen.

const d0  = new Diapositiva(image = "diapo-1.png")              // Es una diapositiva con su respectiva imagen.
const d1  = new Diapositiva(image = "diapo-2.png")              // Es una diapositiva con su respectiva imagen.
const d2  = new Diapositiva(image = "diapo-3.png")              // Es una diapositiva con su respectiva imagen.
const d3  = new Diapositiva(image = "diapo-4.png")              // Es una diapositiva con su respectiva imagen.
const d4  = new Diapositiva(image = "diapo-5.png")              // Es una diapositiva con su respectiva imagen.
const d5  = new Diapositiva(image = "diapo-6.png")              // Es una diapositiva con su respectiva imagen.
const d6  = new Diapositiva(image = "diapo-7.png")              // Es una diapositiva con su respectiva imagen.
const d7  = new Diapositiva(image = "diapo-8.png")              // Es una diapositiva con su respectiva imagen.
const d8  = new Diapositiva(image = "diapo-9.png")              // Es una diapositiva con su respectiva imagen.
const d9  = new Diapositiva(image = "diapo-10.png")             // Es una diapositiva con su respectiva imagen.
const dg0 = new Diapositiva(image = "diapo-granero-2.png")      // Es una diapositiva con su respectiva imagen.
const dg1 = new Diapositiva(image = "diapo-granero-3.png")      // Es una diapositiva con su respectiva imagen.
const dg2 = new Diapositiva(image = "diapo-granero-4.png")      // Es una diapositiva con su respectiva imagen.

// ##################################################################################################################################################### \\