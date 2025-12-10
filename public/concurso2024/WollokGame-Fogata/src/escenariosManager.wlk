import protagonista.*
import gestores.*
import visualesExtra.*
import enemigos.*
import escenariosMapas.*
import dialogosManager.* 
import eventos.*
import diapositivasManager.*
import puertas.*
import npcEstados.*

// ############################################################################################################################### \\

class Escenario{ 
    var property mapa      = mapaComun            // Representa el mapa que tiene el escenario.
    var property ost       = game.sound("")       // Representa a la música que tiene el escenario.
    var property configuradorActual    = {}       // Representa al configurador actual del escenario. 
    var property configuradorSiguiente = {}       // Representa las configuraciones de las salidas y del escenario siguiente.
    const visualesEnEscena = []                   // Representa a los visuales que hay en el escenario.
    const fondoEscenario   = ""                   // Representa al fondo que tiene el escenario.
    const eventos          = []                   // Representa a los eventos que tiene el escenario.
    const gestorObstaculos = gestorDeObstaculos   // Representa al gestor de obstaculos que utiliza el escenario.
    const gestorFondo      = gestorFondoEscenario // Representa al gestor de fondo que utiliza el escenario.
    const gestorLobos      = gestorDeLobos        // Representa al gestor de lobos que utiliza el escenario.
   
    // ================================================ INICIALIZACIÓN ESCENARIO ================================================ \\

    method puestaEnEscena(){ 
        // Aplica todas las configuraciones cargadas para poder poner en funcionamiento al escenario. 
        self.configurar()
        self.configurarEscenarioSiguiente()
        self.configurarSonido()
        gestorFondo.visualizarFondo(fondoEscenario)
        self.dibujarTablero()
        self.agregarVisualesEscena()
        self.gestionarInicioEventos()
    }

    method configurarSonido(){
        // Configura el sonido del escenario.
        ost.volume(0.5)
        ost.shouldLoop(true)
        ost.play()
    }
    
    method dibujarTablero(){
        // Dibuja el tablero con el mapa cargado en el escenario.
        (0 .. game.width() - 1).forEach({x =>  
            (0 .. game.height() - 1).forEach({y => 
                const constructor = mapa.get(y).get(x)
                constructor.construir(game.at(x, y))
            })
        })
    }

    method bajarVolumen(){ 
        // Cuando se mata al lobo jefe y al guardabosques la musica del escenario se baja dando lugar a otra.
        ost.volume(0)
    }

    // ================================================= GESTION CONFIGURADORES ================================================= \\

    method configuradorTotal(nuevoConfiguradorActual, nuevoConfiguradorSiguiente){
        // Redefine los nuevos configuradores de la escena, el nuevoConfiguradorActual y el nuevoConfiguradorSiguiente.
        self.configuradorActual(nuevoConfiguradorActual)
        self.configuradorSiguiente(nuevoConfiguradorSiguiente) 
    }

    method configurar(){
        // Aplica la configuración actual del escenario.
        configuradorActual.apply(self)
    }
 
    method configurarEscenarioSiguiente(){
        // Aplica la configuración siguiente del escenario.
        configuradorSiguiente.apply()
    }

    // =================================================== GESTION ESCENARIO ==================================================== \\

    method limpiar(){     
        // Limpia todo el escenario: borrando el fondo, la música, los visuales, eventos, obstaculos y lobos.
        gestorFondo.borrarFondo()
        ost.stop()
        self.borrarVisualesEscena()
        self.gestionarFinEventos()
        gestorObstaculos.limpiarObstaculos()
        gestorLobos.limpiarLobos()
    }
      
    // =================================================== GESTION DE EVENTOS =================================================== \\

    method gestionarInicioEventos(){
        // Inicia todos los eventos cargados en el escenario, salvo que no haya ningún evento para iniciar.
        if(not eventos.isEmpty()){
            eventos.forEach({evento => evento.iniciarEvento()})
        }
    }

    method gestionarFinEventos(){
        // Finaliza todos los eventos cargado en el escenario, salvo que no haya ningún evento para finalizar.
        if(not eventos.isEmpty()){ 
            eventos.forEach({evento => evento.finalizarEvento()})
            eventos.clear()
        }
    }

    method actualizarEventos(listaEventos){
        // Actualiza los eventos que hay en el escenario por los dados por parámetro.
        const reemplazo = listaEventos
        eventos.clear()
        reemplazo.forEach({evento => eventos.add(evento)})
    }

    // =================================================== GESTION DE VISUALES ================================================== \\

    method agregarVisualesEscena(){
        // Agrega al juego cada visual cargado en los visuales del escenario.
        visualesEnEscena.forEach({visual => game.addVisual(visual)})
    }

    method borrarVisualesEscena(){
        // Borra los visuales que hay cargados en el escenario.
        visualesEnEscena.forEach({visual => game.removeVisual(visual)})
        visualesEnEscena.clear()
    }

    method actualizarVisuales(listaVisuales){
        // Actualiza los visuales del escenario con los visuales dados por parámetro.
        const reemplazo = listaVisuales
        visualesEnEscena.clear()
        reemplazo.forEach({visual => visualesEnEscena.add(visual)})
    }

    // ========================================================================================================================== \\

    method removerSiEsta(visual){ 
        // Remueve al visual dado en caso que exista en el escenario actual. Se usa en los escenarios con diapositivas.
        if(game.hasVisual(visual)){ 
            game.removeVisual(visual)
        }
    }

    // ========================================================================================================================== \\

    method eventos(){
        // Describe los eventos que hay actualmente en el escenario.
        return eventos
    }

    method visualesEnEscena(){
        // Describe los visuales que hay actualmente en el escenario.
        return visualesEnEscena
    }

    method fondoEscenario(){
        // Describe el fondo del escenario actual en el escenario.
        return fondoEscenario
    }
} 

// ############################################################################################################################## \\

object constructorEscenario{

    method construir (configuradorEscenario, configuradorEscenarioSiguiente, fondoDelEscenario){
        // Construye un escenario mediante su configuración actual (con la que inicia), una configuración siguiente y un fondo.
        return new Escenario(configuradorActual    = configuradorEscenario,
                             configuradorSiguiente = configuradorEscenarioSiguiente,
                             fondoEscenario        = fondoDelEscenario)
    }
}

// ######################################################### ESCENARIOS ######################################################### \\

// Los escenarios representan la escena actual. Estan  compuestos por dos configuradores: uno actual, y el siguiente; además de
// los visuales, la música, los eventos, el fondo, y un mapa que sirve para dibujar en las posiciones dadas en el mismo los
// diferentes visuales.

// ############################################################################################################################## \\

const inicio = constructorEscenario.construir(inicioConfgV1, {}, "inicio.png")

const fogata = constructorEscenario.construir(fogataConfgV1, fogataCESv1, "fondo-norte.png")

const bifurcacion      = constructorEscenario.construir(bifurcacionConfgV1, bifurcacionCESv1, "fondo-camino-bifurcacion.png")

const entradaCabaña    = constructorEscenario.construir(entradaCabañaConfgV1, entradaCabañaCESv1, "fondo-camino-oeste-norte.png" )

const cabaña           = constructorEscenario.construir(cabañaConfgV1, cabañaCESv1, "cabaña.png")   

const entradaCueva     = constructorEscenario.construir(entradaCuevaConfgV1, entradaCuevaCESv1, "fondo-entrada-cueva.png")

const cueva            = constructorEscenario.construir(cuevaConfgV1, cuevaCESv1, "fondo-cueva.png")

const entradaGranero   = constructorEscenario.construir(entradaGraneroConfgV1, entradaGraneroCESv1, "fondo-sur.png")

const granero          = constructorEscenario.construir(graneroConfgV1, graneroCESv1, "fondo-granero.png")

const peleaFinal       = constructorEscenario.construir(peleaFinalConfgV1, peleaFinalCESv1, "fondo-cueva.png")

const estacionamiento  = constructorEscenario.construir(estacionamientoConfgV1, {}, "fondo-escenario-final.png")

// ######################################## ESCENARIOS EXCLUSIVOS PARA LAS DIAPOSITIVAS ######################################### \\

const diapoGranero     = constructorEscenario.construir(diapoGraneroConfgV1, {}, "diapo-granero-1.png") 

const diapoAmigaMuerta = constructorEscenario.construir(diapoAmigaMuertaConfgV1, {}, "diapo-amiga-muerta1.png")

const diapoPeleaFinal  = constructorEscenario.construir(diapoPeleaFinalConfgV1, {}, "diapo-pelea-final1.png")

// ################################################ CONFIGURADORES DE ESCENARIOS ################################################ \\

// Los configuradores de escenarios modifican el estado de distintas variables del escenario de acorde a lo requerido en la escena actual.
// Comunican a otros objetos distintas ordenes requeridas para la escena actual.

// ############################################################################################################################## \\

const inicioConfgV1 = {e => e.ost(trackInicio)}

const fogataConfgV1 = {e => gestorDeDialogo.esMomentoDeDialogar(true);
                            e.mapa(mapaEscenarioInicialV1);
                            e.actualizarVisuales([amiga, carpa, fogataOBJ, protagonista]);
                            e.ost(trackFogata)}

// ############################################ CONFIGURADORES ESCENARIO BIFURCACION ############################################# \\

const bifurcacionConfgV1 = {e => game.removeVisual(puertaNorte);
                                 e.mapa(mapaEscenarioBifurcacionV1);
                                 e.actualizarVisuales([puertaEste, protagonista]);
                                 e.ost(trackFogata)}
      
const bifurcacionConfgV2 = {e => e.mapa(mapaEscenarioBifurcacionV2);
                                 e.actualizarVisuales([protagonista, puertaOeste]);
                                 e.ost(trackAtaqueLobos);
                                 e.actualizarEventos([hablarProta4])}

const bifurcacionConfgV3 = {e => e.mapa(mapaEscenarioBifurcacionV3);
                                 e.actualizarVisuales([protagonista, puertaSur]);
                                 e.ost(trackSuspence);
                                 e.actualizarEventos([hablarProta2])}

const bifurcacionConfgV4 = {e => e.actualizarVisuales([protagonista, puertaEste]);
                                 e.mapa(mapaEscenarioBifurcacionV4);
                                 e.ost(trackTramoACabaña);
                                 e.actualizarEventos([hablarProta])}

const bifurcacionConfgV5 = {e => e.actualizarVisuales([protagonista, puertaOeste]);
                                 e.mapa(mapaEscenarioBifurcacionV5);
                                 e.ost(trackAtaqueLobos);
                                 e.actualizarEventos([hablarProta7])}

const bifurcacionConfgV6 = {e => e.mapa(mapaEscenarioBifurcacionV6);
                                 e.actualizarVisuales([protagonista, puertaNorte]);
                                 e.ost(trackTramoFinal)}          

// ################################################ CONFIGURADORES ENTRADA CABAÑA ################################################ \\

const entradaCabañaConfgV1 = {e => e.mapa(mapaEntradaCabañaV1);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                   e.ost(trackFogata)}

const entradaCabañaConfgV2 = {e => game.removeVisual(puertaEntradaCabaña);
                                   e.mapa(mapaEntradaCabañaV2);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaOeste] );
                                   e.ost(trackSuspence);
                                   e.actualizarEventos([escucharLobos])}

const entradaCabañaConfgV3 = {e => e.mapa(mapaEntradaCabañaV1);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                   e.ost(trackTramoACabaña)}

const entradaCabañaConfgV4 = {e => game.removeVisual(puertaEntradaCabaña);
                                   guardabosques.image("guardabosques-desarmado-abajo.png");
                                   e.mapa(mapaEntradaCabañaV3);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaNorte, guardabosques]);
                                   e.ost(trackSuspence);
                                   e.actualizarEventos([guardabosquesHabla])}

const entradaCabañaConfgV5 = {e => e.mapa(mapaEntradaCabañaV4);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaEntradaCabaña]);
                                   e.ost(trackSuspence)}

const entradaCabañaConfgV6 = {e => game.removeVisual(puertaEntradaCabaña);
                                   e.mapa(mapaEntradaCabañaV3);
                                   e.actualizarVisuales([cabañaOBJ, protagonista, puertaOeste]);
                                   e.ost(trackSuspence)}

// #################################################### CONFIGURADORES GRANERO #################################################### \\

const entradaGraneroConfgV1 = {e => e.mapa(mapaEntradaGraneroV1);
                                    e.actualizarVisuales([graneroOBJ, protagonista, guardabosques, puertaGranero]);
                                    e.ost(trackSuspence);
                                    e.actualizarEventos([guardabosquesHabla2])}

const graneroConfgV1 = {e => e.mapa(mapaPeleaGranero);
                             e.actualizarVisuales([protagonista,manopla,hacha,tridente]); 
                             e.ost(trackPeleaGranero)}

const entradaGraneroConfgV2 = {e => game.removeVisual(puertaGranero);
                                    e.mapa(mapaEntradaGraneroV2);
                                    e.actualizarVisuales([graneroOBJ, protagonista, puertaSur]);
                                    e.ost(trackSuspence);
                                    e.actualizarEventos([hablarProta3])}

// #################################################### CONFIGURADORES CABAÑA #################################################### \\

const  cabañaConfgV1 = {e => gestorDeDialogo.esMomentoDeDialogar(true);
                             e.mapa(mapaCabañaInicialV1);
                             e.actualizarVisuales([guardabosques, protagonista]);
                             e.ost(trackCabaña)}

const cabañaConfgV2 = {e => gestorDeDialogo.esMomentoDeDialogar(true);
                            e.mapa(mapaCabañaInicialV1);
                            e.actualizarVisuales([guardabosques, protagonista]);
                            e.ost(trackSuspence)}
                       
const cabañaConfgV3 = {e => e.mapa(mapaCabañaInicialV2);
                            e.actualizarVisuales([protagonista, nota]);
                            e.ost(trackSuspence)}                      

// ################################################## CONFIGURADORES ZONA CUEVA ################################################## \\

const entradaCuevaConfgV1 = {e => e.mapa(mapaEntradaCuevaV1);
                                  e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                                  e.ost(trackAtaqueLobos);
                                  e.actualizarEventos([hablarProta5])}    

const entradaCuevaConfgV2 = {e => e.mapa(mapaEntradaCuevaV2);
                                  e.actualizarVisuales([protagonista, puertaEste]);
                                  e.ost(trackSuspence)} 

const entradaCuevaConfgV3 = {e => e.mapa(mapaEntradaCuevaV3);
                                  e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                                  e.ost(trackAtaqueLobos)}  

const entradaCuevaConfgV4 = {e => protagonista.estadoCombate(pasivoProtagonista);
                                  protagonista.image("prota-desarmado-abajo.png");
                                  game.removeVisual(puertaEntradaCueva);
                                  e.mapa(mapaEntradaCuevaV2);
                                  e.actualizarVisuales([protagonista, puertaEste]);
                                  e.ost(trackTramoFinal)}

const cuevaConfgV1 = {e => e.mapa(mapaCuevaV1);
                           e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                           e.ost(trackCueva);
                           e.actualizarEventos([hablarProta6])}

const cuevaConfgV2 = {e => e.mapa(mapaCuevaV2);
                           e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                           e.ost(trackCueva)}

const cuevaConfgV3 = {e => e.mapa(mapaCuevaV3);
                           e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                           e.ost(trackCueva)}

const cuevaConfgV4 = {e => e.mapa(mapaCuevaV4);
                           e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                           e.ost(trackCueva)}      
                                       
const cuevaConfgV5 = {e => e.mapa(mapaCuevaV5);
                           e.actualizarVisuales([protagonista, puertaEntradaCueva]);
                           e.ost(trackCueva)}  

// ################################################# CONFIGURADORES PELEA FINAL ################################################## \\

const peleaFinalConfgV1 = {e => e.removerSiEsta(protagonista);
                                protagonista.estadoCombate(protagonista.estadoCombateElegido());      
                                guardabosques.cambiarAAtravesable();                  
                                guardabosques.estadoCombate(agresivoGuardabosques);
                                guardabosques.image("guardabosques-escopeta-derecha.png");
                                e.mapa(mapaFinalJuego);
                                e.actualizarVisuales([protagonista, guardabosques]);
                                e.ost(trackPeleaFinal);
                                e.actualizarEventos([hablarProta9, ataqueGuardabosques, ataqueEscopetaGuardabosques])} 

const estacionamientoConfgV1 = {e => e.mapa(mapaEstacionamientoV1);
                                     e.actualizarVisuales([protagonista, auto]);
                                     e.ost(trackTramoFinal);
                                     e.actualizarEventos([hablarProta8])}

// ########################################## CONFIGURADORES ESCENARIOS CON DIAPOSITIVAS ######################################### \\

const diapoAmigaMuertaConfgV1 = {e => e.removerSiEsta(protagonista);
                                      gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                      e.ost(trackAmigaMuerta)}

const diapoPeleaFinalConfgV1 =  {e => e.removerSiEsta(protagonista);
                                      gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                      protagonista.estadoCombate(pasivoProtagonista);
                                      e.ost(trackGuardabosquesCueva)}

const diapoGraneroConfgV1 =     {e => e.removerSiEsta(protagonista);
                                      gestorDeDiapositivas.esHoraDeDiapositiva(true);
                                      game.removeVisual(puertaGranero);
                                      e.ost(traicionGranero)}

// ########################################### CONFIGURADORES DE ESCENARIOS SIGUIENTES ########################################### \\

// Los configuradores de escenarios siguientes modifican el estado de las puertas y modifican el estado de los escenarios
// siguientes dependiendo la escena actual. Es decir, los escenarios a los que se va luego de interactuar con dichas puertas.

// ############################################################################################################################### \\

const fogataCESv1 = {puertaNorte.irHacia(bifurcacion)}

const bifurcacionCESv1   = {puertaEste.irHacia(entradaCabaña)}

const bifurcacionCESv2   = {puertaOeste.irHacia(entradaCueva)}

const entradaCabañaCESv1 = {puertaEntradaCabaña.irHacia(cabaña)}

const entradaCabañaCESv2 = {game.removeVisual(puertaEntradaCabaña); 
                            puertaOeste.irHacia(bifurcacion);
                            bifurcacion.configuradorTotal(bifurcacionConfgV2, bifurcacionCESv2)}
                                                
const cabañaCESv1 = {puertaOeste.irHacia(entradaCabaña);
                     entradaCabaña.configuradorTotal(entradaCabañaConfgV2, entradaCabañaCESv2)}
                                               
const entradaCuevaCESv1 = {puertaEntradaCueva.irHacia(cueva)}       

const cuevaCESv1 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV2, cuevaCESv2)}
                          
const cuevaCESv2 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV3, cuevaCESv3)}

const cuevaCESv3 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV4, cuevaCESv4)}

const cuevaCESv4 = {puertaEntradaCueva.irHacia(entradaCueva);
                    entradaCueva.configuradorTotal(entradaCuevaConfgV2, entradaCuevaCESv2)}

const entradaCuevaCESv2  = {puertaEste.irHacia(bifurcacion);
                            bifurcacion.configuradorTotal(bifurcacionConfgV3, bifurcacionCESv3)}

const bifurcacionCESv3   = {puertaSur.irHacia(diapoAmigaMuerta)}

const bifurcacionCESv4   = {puertaEste.irHacia(entradaCabaña);
                            entradaCabaña.configuradorTotal(entradaCabañaConfgV3, entradaCabañaCESv3)}
                                         
const entradaCabañaCESv3 = {puertaEntradaCabaña.irHacia(cabaña);
                            cabaña.configuradorTotal(cabañaConfgV2, cabañaCESv2)}

const cabañaCESv2 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                     entradaCabaña.configuradorTotal(entradaCabañaConfgV4, entradaCabañaCESv4)}
                                             
const entradaCabañaCESv4  = {puertaNorte.irHacia(entradaGranero)}

const entradaGraneroCESv1 = {puertaGranero.irHacia(diapoGranero)}

const graneroCESv1 = {puertaGranero.irHacia(entradaGranero);
                      entradaGranero.configuradorTotal(entradaGraneroConfgV2, entradaGraneroCESv2)}
                                        
const entradaGraneroCESv2 = {puertaSur.irHacia(entradaCabaña);
                             entradaCabaña.configuradorTotal(entradaCabañaConfgV5, entradaCabañaCESv5)}
                                                       
const entradaCabañaCESv5  = {puertaEntradaCabaña.irHacia(cabaña);
                             cabaña.configuradorTotal(cabañaConfgV3, cabañaCESv3)}
                                                      
const cabañaCESv3 = {puertaEntradaCabaña.irHacia(entradaCabaña);
                     entradaCabaña.configuradorTotal(entradaCabañaConfgV6, entradaCabañaCESv6)}
                                           
const entradaCabañaCESv6 = {puertaOeste.irHacia(bifurcacion);
                            bifurcacion.configuradorTotal(bifurcacionConfgV5, bifurcacionCESv5)}
                                               
const bifurcacionCESv5   = {puertaOeste.irHacia(entradaCueva);
                            entradaCueva.configuradorTotal(entradaCuevaConfgV3, entradaCuevaCESv3)}

const entradaCuevaCESv3  = {puertaEntradaCueva.irHacia(cueva);
                            cueva.configuradorTotal(cuevaConfgV1, cuevaCESv6)}

const cuevaCESv6 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV2, cuevaCESv7)}

const cuevaCESv7 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV3, cuevaCESv8)}                                     

const cuevaCESv8 = {puertaEntradaCueva.irHacia(cueva);
                    cueva.configuradorTotal(cuevaConfgV5, cuevaCESv9)}
                                                                       
const cuevaCESv9 = {puertaEntradaCueva.irHacia(diapoPeleaFinal)}

const peleaFinalCESv1   = {puertaEntradaCueva.irHacia(entradaCueva);
                           entradaCueva.configuradorTotal(entradaCuevaConfgV4, entradaCuevaCESv4)}         

const entradaCuevaCESv4 = {puertaEste.irHacia(bifurcacion);
                           bifurcacion.configuradorTotal(bifurcacionConfgV6, bifurcacionCESv6)}         

const bifurcacionCESv6  = {puertaNorte.irHacia(estacionamiento)}       

// ############################################################ MUSICA ########################################################### \\

// Representa la musica utilizada en distintos puntos del juego, distinguida en su nombre por el momento en el que se utiliza.

// ############################################################################################################################### \\

const trackFogata       = game.sound("musica-escenarioInicial-v1.mp3")

const trackAtaqueLobos  = game.sound("lobos-atacan.mp3")

const trackSuspence     = game.sound("suspenso.mp3")

const trackCueva        = game.sound("cueva.mp3")

const trackPeleaFinal   = game.sound("pelea-final.mp3")

const trackCabaña       = game.sound("cabaña.mp3")

const trackTramoACabaña = game.sound("tramo-a-cabaña.mp3")

const trackPeleaGranero = game.sound("pelea-granero.mp3")

const trackTramoFinal   = game.sound("tramo-final.mp3")

// #################################################### MUSICA DIAPOSITIVAS ###################################################### \\

const trackInicio       = game.sound("inicio_v1.mp3")

const trackAmigaMuerta  = game.sound("terror-amiga-muerta.mp3")

const traicionGranero   = game.sound("traicion-guardabosques.mp3")

const trackGuardabosquesCueva = game.sound("guardabosques-cueva.mp3")

// ######################################################## MUSICA EVENTOS ####################################################### \\

const trackProtaPreocupado = "lobos-amiga.mp3"

const trackManada          = "manada-lobo.mp3"

const trackGameOver        = "gameover.mp3"

const trackWin             = "game-win.mp3"

const trackGuardabosquesDerrotado = "victoria-guardabosques.mp3"

const trackLoboJefeDerrotado      = "victoria-lobo.mp3"

// ####################################################### SONIDOS ENEMIGOS ###################################################### \\ 

// Representa los sonidos utilizados en distintos puntos del juego, distinguido en su nombre por el sonido que representa.

// ############################################################################################################################### \\

const trackGuardabosquesMuerte = "muerte-guardabosques.mp3"

const trackLoboMuerto1  = "muerte-perro-normal.mp3"

const trackLoboMuerto2  = "muerte-perro-normal2.mp3"

const trackLoboMuerto3  = "muerte-perro-normal3.mp3"

const trackLoboMuerto4  = "muerte-perro-normal4.mp3"

const sonidosMuerteLobo = [trackLoboMuerto1, trackLoboMuerto2, trackLoboMuerto3, trackLoboMuerto4]

const trackLoboEnojado  = "lobo-enojado.mp3"

// ############################################################################################################################### \\