import magos.*
import administradorDeOleadas.*
import adminProyectiles.*
import administradorDeMagos.*
import wollok.game.*
import cursor.*
import slime.*
import menu.*
import administradorDeEnemigos.*
import puntaje.*
import pala.*
import casa.casa
import proyectil.*


// =======================================
// Administrador de Juego: Control central del juego, reseteo y fin del juego
// =======================================

class MyException inherits wollok.lang.Exception {}
object administradorDeJuego {
    var property pausado = false
    var property usuarioEnMenu = true
   
  
  
  // Método para finalizar el juego y resetear el estado
  method terminarJuego() {
    usuarioEnMenu = true
    puntaje.reset()
    game.addVisual(pantalla)
    self.resetGame()
  }


  // Método para resetear todos los administradores y configuraciones del juego
  method resetGame() {
    configuracion.resetTicks()
    administradorDeEnemigos.reset()
    administradorDeMagos.reset()
    administradorDeProyectiles.reset()
    casa.reset()
    fondo.reset()
    puntaje.reset()
    administradorDeOleadas.reset()
    configuracion.quitarVisuals()
  }

    method pausar(){
        if (!usuarioEnMenu){
            if (!pausado){
                configuracion.frenarTicks()
                pausado = true
                pantalla.estado(pausa)
                game.addVisual(pantalla)
                return pausado
            } else {
                configuracion.crearTicks()
                game.removeVisual(pantalla)
                
        
                pausado = false
                return pausado
            }
        }
    }
    method mostrarMenuInicial(){
        try {self.resetGame() game.removeVisual(administradorDeOleadas) game.schedule(10, {configuracion.frenarTicks()
        game.removeVisual(pantalla)})}
        catch e "no hay ticks"
        game.schedule(1000, {usuarioEnMenu=true})
        menuInicial.quitarBotones()
        menuInicial.imagen("MenuInicial.png")
        menuInicial.botones(menuInicial.botonesIniciales())
        try game.addVisual(menuInicial) catch e "ya se esta mostrando el menu"
        menuInicial.iniciarMenu()
    }
}

// =======================================
// Pantallas de Estado del Juego (Derrota y Victoria)
// =======================================
object derrota {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "fin.jpg"
    method sonido() = game.sound("m.deathScreen.mp3")
    
}
object victoria {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "victoria.png"
    method sonido() = game.sound("victory.mp3")
}
object portada {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "portada.png"
    method sonido() = game.sound("m.inicio.mp3")
}
object finDeNivel {
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "finNivel.png"
    method sonido() = game.sound("m.deathScreen.mp3")
}

object pausa{
    method position() = new MutablePosition(x = 0, y = 0)
    method imagen() = "pantallaPausa.png"
    method sonido() = game.sound("")
}

// =======================================
// Pantalla de Estado Actual del Juego
// =======================================
object pantalla {
    method position() = new MutablePosition(x = 0, y = 0)
    method image() = estado.imagen()
    
    var  property estado = portada
    var sonido = estado.sonido()
    method estado()=estado

    method reproducirSonido(){
        if(!botonMutearMusica.muteada()){estado.sonido().volume(0.7)
        estado.sonido().play()}
    }
    method detenerSonido(){
        if(!botonMutearMusica.muteada()){estado.sonido().stop()}
    }
    method nuevoEstado(estadoNuevo) {
        estado=estadoNuevo
        
        self.reproducirSonido()  
    }
    method frenarEnemigo()= true
}

object fondo{
    var imagen = "fondo1.jpg"
    method position() = new MutablePosition(x = 0, y = 0)
    method image() = imagen

    method cambiarFondo(fondoNuevo){
        imagen = fondoNuevo
    }

    method reset(){
        imagen = "fondo1.jpg"
    }
    method frenarEnemigo() = false
}

// =======================================
// Configuración del Juego: Música, Visuales y Eventos
// =======================================

object sonidoPartida{
    var property sonido = "pvz8bit.mp3"
    var sonidoFinal="TEARS.mp3"
    var musicaActual=musica1
    const musica1 = game.sound(sonido)
    const musica2 = game.sound(sonidoFinal)
    var musicaEsDelFinal=false
    method ponerMusicaNormal(){
         if(!botonMutearMusica.muteada()){
        self.detenerMusica()
        musicaActual=musica1
        musicaEsDelFinal=false 
        self.iniciarMusica()
        }
    }
    method switchearMusica(){
        if(!botonMutearMusica.muteada()){
        self.detenerMusica()
        if (!musicaEsDelFinal){
            musicaActual.volume(0.5)
            musicaActual=musica2
            musicaEsDelFinal=true
        }
        else {
            musicaActual=musica1
            musicaEsDelFinal=false
        }
        self.iniciarMusica()
        }
        }
    method iniciarMusica() {
        musicaActual.shouldLoop(true)
        game.schedule(1500, { musicaActual.play() })
        musicaActual.volume(1)
    }
    method detenerMusica(){
        musicaActual.stop()
    }
}
object configuracion {
    const tiemposProyectiles = 600
    const tiempoDisparo = 3000
    const tiempoDinero = 750
    const tiempoMuerte = 1000
    const tiempoMoverEnemigo = 1000

    //ticks que usa el juego
    const tickParaMoverEnemigos = game.tick(tiempoMoverEnemigo,{administradorDeEnemigos.moverEnemigos()},false)
    const tickParaAumentarDinero = game.tick(tiempoDinero, { puntaje.sumarPuntos() },false)
    const tickParaDisparar= game.tick(tiempoDisparo,  { administradorDeMagos.disparar()},false)
    const tickParaMoverYColisionarDisparos= game.tick(tiemposProyectiles,  { administradorDeProyectiles.moverProyectiles() administradorDeProyectiles.impactarProyectiles() },false)
    const tickParaCambiarFrames= game.tick((tiemposProyectiles/3)-5, {administradorDeProyectiles.cambiarFrame()},false)
    const tickParaCambiarFramesEnemigos= game.tick((tiempoMoverEnemigo/3)-5, {administradorDeEnemigos.cambiarFrame()},false)


    var property sonido = "pvz8bit.mp3"
    var musica = game.sound(self.sonido()) // El reproductor de música es constante; solo cambia el archivo de sonido
    method iniciarMusica() {sonidoPartida.iniciarMusica()} 
    // Método para detener la música de fondo
    method detenerMusica() {
        try sonidoPartida.detenerMusica() catch e return
    }

    method iniciarConfig(){
        menu.accion() 
        cursor.accion()
        // Tecla "P" para reiniciar el juego
        keyboard.p().onPressDo({
            if(!administradorDeJuego.usuarioEnMenu()){administradorDeJuego.resetGame()
            administradorDeJuego.usuarioEnMenu(false)
            administradorDeJuego.pausado(false)
            //administradorDeJuego.pausado(false)
            game.removeVisual(pantalla)
            self.frenarTicks()
            self.crearTicks()
            puntaje.reset()
            administradorDeOleadas.oleadaInicial().start()
            self.agregarVisuals()
            sonidoPartida.ponerMusicaNormal() 
            }})

        // Tecla "I" para detener el juego
        keyboard.i().onPressDo({ game.stop() })
        keyboard.o().onPressDo({administradorDeJuego.pausar()})
       }
    // Método para agregar elementos visuales y configurar teclas de control
    method quitarVisuals(){
        game.removeVisual(cursor)
        cursor.position(new MutablePosition(x = 7, y = 3))
        game.removeVisual(menu)
        game.removeVisual(puntaje)
        game.removeVisual(casa)
        game.removeVisual(administradorDeOleadas)
        game.removeVisual(fondo)
       
        menu.finalizarTienda()

    }
    method agregarVisuals() {  
        game.addVisual(fondo)

        game.addVisual(menu)

        game.addVisual(puntaje)

        game.addVisual(cursor)

        game.addVisual(casa)

        game.addVisual(administradorDeOleadas)

        menu.iniciarTienda()
    }   

    // Método para programar eventos de actualización periódicos (ticks)
    method crearTicks() {
       tickParaAumentarDinero.start()
        tickParaCambiarFrames.start()
        tickParaDisparar.start()
        tickParaMoverYColisionarDisparos.start()
        tickParaMoverEnemigos.start()
        tickParaCambiarFramesEnemigos.start()
    }
    
    method frenarTicks() {
            tickParaAumentarDinero.stop()
            tickParaCambiarFrames.stop()
            tickParaDisparar.stop()
            tickParaMoverYColisionarDisparos.stop()
            tickParaMoverEnemigos.stop()
            tickParaCambiarFramesEnemigos.stop()
    }
    method resetTicks(){
        tickParaAumentarDinero.reset()
        tickParaCambiarFrames.reset()
        tickParaDisparar.reset()
        tickParaMoverYColisionarDisparos.reset()
        tickParaMoverEnemigos.reset()
        tickParaCambiarFramesEnemigos.reset()
    }

}


object menuInicial{
    var property imagen="MenuInicial.png"
    method position()=new MutablePosition(x=0,y=0)
    method image() = imagen
    var botonSeleccionado = 0
    var property botones= botonesIniciales
    const property botonesIniciales = [botonDeInicio,botonNiveles,botonMutearMusica]
    method iniciarMenu(){
        botonSeleccionado=0
        self.seleccionarBoton()
        botones.forEach({boton=>game.addVisual(boton)})
        
    }
    method finalizarMenu(){
        self.quitarBotones()
        game.schedule(100, {administradorDeJuego.usuarioEnMenu(false)})
        game.removeVisual(self)
    }
    method quitarBotones(){botones.forEach({boton=>game.removeVisual(boton)
    boton.cambiarEstadoDeSeleccion(false)})}
    method moverseEntreBotones(){
        keyboard.right().onPressDo({  if(administradorDeJuego.usuarioEnMenu()  && botonSeleccionado<botones.size()-1&&!game.hasVisual(pantalla))
                                        {   self.deseleccionarBoton()
                                            botonSeleccionado+=1
                                            self.seleccionarBoton() }})
        keyboard.left().onPressDo({  if(administradorDeJuego.usuarioEnMenu()  && botonSeleccionado>0 &&!game.hasVisual(pantalla))
                                        {   self.deseleccionarBoton()
                                            botonSeleccionado-=1 
                                            self.seleccionarBoton()}})    
                
        
    }

    method seleccionarBoton(){
        botones.get(botonSeleccionado).cambiarEstadoDeSeleccion(true)
    }

    method deseleccionarBoton(){
        botones.get(botonSeleccionado).cambiarEstadoDeSeleccion(false)
    }
    method activarBoton(){
        keyboard.enter().onPressDo({  if(administradorDeJuego.usuarioEnMenu()&&!game.hasVisual(pantalla)){
                                        botones.get(botonSeleccionado).accion()}})
    }
}
object botonDeInicio{
    var imagen="botonEternoSeleccionado.png"
    method image()=imagen
    method position()= new MutablePosition(x=2,y=1)
    method accion(){
    configuracion.agregarVisuals()
    configuracion.crearTicks()
    administradorDeOleadas.modoInfinito(false)
    administradorDeOleadas.actualizarOleada()
	administradorDeOleadas.iniciarOleada()
    
    menuInicial.finalizarMenu()
    }

    method cambiarEstadoDeSeleccion(estado){
        if(estado){
            self.ponerMarcoDeSeleccion()
        }
        else{self.quitarMarcoDeSeleccion()}
    }
    method ponerMarcoDeSeleccion(){
        imagen="botonEternoSeleccionado.png"
    }
    method quitarMarcoDeSeleccion(){
        imagen="botonEterno.png"
    }

}

object botonNiveles{
    var imagen="botonHistoria.png"
    method image()=imagen
    method position()= new MutablePosition(x=7,y=1)
    const property niveles=[botonNivel1, botonNivel2, botonNivel3, botonNivel4, botonNivel5]
    method accion(){
    menuInicial.quitarBotones()
    menuInicial.imagen("MenuInicialVacio.png")
    menuInicial.botones(niveles)
    menuInicial.iniciarMenu()
    }

    method cambiarEstadoDeSeleccion(estado){
        if(estado){
            self.ponerMarcoDeSeleccion()
        }
        else{self.quitarMarcoDeSeleccion()}
    }
    method ponerMarcoDeSeleccion(){
        imagen="botonHistoriaSeleccionado.png"
    }
    method quitarMarcoDeSeleccion(){
        imagen="botonHistoria.png"
    }
}

object botonMutearMusica{
var imagen="botonMuteo.png"
    method image()=imagen
    method position()= new MutablePosition(x=13,y=1)
    var property muteada=true
    method accion(){
        if (muteada){
            administradorDeJuego.usuarioEnMenu(false)
            game.schedule(1500, {administradorDeJuego.usuarioEnMenu(true)})
            configuracion.iniciarMusica()
            imagen="botonDesmuteoSeleccionado.png"
            muteada=false
        }
        else {
            administradorDeJuego.usuarioEnMenu(false)
            game.schedule(1500, {administradorDeJuego.usuarioEnMenu(true)})
            configuracion.detenerMusica()
            imagen="botonDesmuteoSeleccionado.png"
            muteada=true
            }
    }
    method cambiarEstadoDeSeleccion(estado){
        if(estado){
            self.ponerMarcoDeSeleccion()
        }
        else{self.quitarMarcoDeSeleccion()}
    }
    method ponerMarcoDeSeleccion(){
        if(muteada){
        imagen="botonDesmuteoSeleccionado.png"
        }
        else imagen="botonMuteoSeleccionado.png"
    }
    method quitarMarcoDeSeleccion(){
        if(muteada){
        imagen="botonDesmuteo.png"
        }
        else imagen="botonMuteo.png"
        
    }
  
  
}

class BotonDeNivel{
    const imagenSinSeleccionar
    const imagenDeSeleccion
    var property imagen = imagenSinSeleccionar
    const numNivel
    const property nivel
    method image()=imagen
    const posicion
    method position()=posicion
    method accion(){
    configuracion.agregarVisuals()
	configuracion.crearTicks()
    administradorDeOleadas.numNivel(numNivel)
    administradorDeOleadas.modoInfinito(true)
    administradorDeOleadas.actualizarOleada()
    administradorDeOleadas.iniciarOleada()
    
    menuInicial.finalizarMenu()
    }

    method cambiarEstadoDeSeleccion(estado){
        if(estado){
            self.ponerMarcoDeSeleccion()
        }
        else{self.quitarMarcoDeSeleccion()}
    }
    method ponerMarcoDeSeleccion(){
        imagen=imagenDeSeleccion
    }
    method quitarMarcoDeSeleccion(){
        imagen=imagenSinSeleccionar
    }
}

const botonNivel1 = new BotonDeNivel(imagenSinSeleccionar="botonNivel1.png", imagenDeSeleccion="botonNivel1Seleccionado.png",
posicion= new MutablePosition(x=5,y=4), numNivel=1,nivel=nivel1)
const botonNivel2 = new BotonDeNivel(imagenSinSeleccionar="botonNivel2.png", imagenDeSeleccion="botonNivel2Seleccionado.png",
posicion= new MutablePosition(x=7,y=4), numNivel=2,nivel=nivel2)
const botonNivel3 = new BotonDeNivel(imagenSinSeleccionar="botonNivel3.png", imagenDeSeleccion="botonNivel3Seleccionado.png",
posicion= new MutablePosition(x=9,y=4), numNivel=3,nivel=nivel3)
const botonNivel4 = new BotonDeNivel(imagenSinSeleccionar="botonNivel4.png", imagenDeSeleccion="botonNivel4Seleccionado.png",
posicion= new MutablePosition(x=6,y=2), numNivel=4,nivel=nivel4)
const botonNivel5 = new BotonDeNivel(imagenSinSeleccionar="botonFINAL.png", imagenDeSeleccion="botonFINALSeleccionado.png",
posicion= new MutablePosition(x=8,y=2), numNivel=5,nivel=nivelFinal)