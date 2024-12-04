import slime.*
import wollok.game.*
import administradorDeEnemigos.*
import administradorDeJuego.*
import administradorDeMagos.administradorDeMagos
import puntaje.puntaje

// ===============================
// Administrador de Oleadas: Control de las oleadas de enemigos
// ===============================
object administradorDeOleadas {
    var nivelActual = nivelInfinito
    var property numeroOleada = 1
    var property modoInfinito = false
    
    const property oleadaInicial = game.tick(5000, {self.frenarTickInicial() self.iniciarOleada()},false)
   
    method frenarTickInicial()=oleadaInicial.stop()


    //cosas para funcionamiento con niveles
    var property numNivel = 1
    const niveles = botonNiveles.niveles()

    method nivel() = niveles.get(numNivel-1).nivel()
    method actualizarOleada(){
        if(modoInfinito) nivelActual = self.nivel()
        else nivelActual = nivelInfinito
        }

    // Métodos de visualización y sonido
    method position() = new MutablePosition(x = 9, y = 5)
    method text() = "Oleada: " +  numeroOleada.toString() + "     Nivel: " + nivelActual.nombre().toString()  + "     " + "Slimes Restantes: " + nivelActual.enemigosRestantes().toString()
    method textColor() = "#FA0770"
    method enemigosVivos() = nivelActual.enemigosVivos()
    
    const tickParaGenerarEnemigos=game.tick(nivelActual.tiempoSpawn(),{self.spawnearOleada()},false)
    
    method spawnearOleada(){
            if (not administradorDeJuego.pausado()){
                    if (nivelActual.ejecutando()) {
                        if(!nivelActual.seGeneraronSuficientes())administradorDeEnemigos.generarEnemigo(nivelActual.enemigos().anyOne())
                    } else if(nivelActual.finalizo()){
                        self.siguienteOleada()
                        tickParaGenerarEnemigos.stop()
                    }
                } }

    // Inicia la oleada y gestiona enemigos
    method iniciarOleada() {
        nivelActual.iniciarOleada()
        tickParaGenerarEnemigos.start()
    }

    method siguienteOleada(){
        if(nivelActual.noTerminoNivel()){
            nivelActual.siguienteOleada()
            numeroOleada += 1
            oleadaInicial.start()
        }
        else{

            numNivel+=1
            if(numNivel>niveles.size()){
                numNivel = 1
                pantalla.nuevoEstado(victoria)
                administradorDeJuego.terminarJuego() 
            }
            else{
            nivelActual.reset()

            pantalla.nuevoEstado(finDeNivel)
            game.addVisual(pantalla)
            game.schedule(2500, {
            game.removeVisual(pantalla)
            puntaje.reset()
            numeroOleada = 1
            administradorDeMagos.reset()
            nivelActual = self.nivel()
            oleadaInicial.start()
            })
          }
        }
    }
    // Gestión de contadores de enemigos
    method reducirEnemigo() { nivelActual.seMurioEnemigo()}
    method sumarEnemigo() { nivelActual.seGeneroEnemigo() }

    // Selecciona un tipo de slime aleatorio en función de la oleada
    
    // Resetea el administrador de oleadas
    method reset() {
        self.frenarTickInicial()
        oleadaInicial.interval(4000)
        tickParaGenerarEnemigos.stop()
        nivelActual.reset()
        nivelActual.resetearCantEnemigosComoAlInicio()
        niveles.forEach({botonNivel=>botonNivel.nivel().resetearOleadas()})
        numeroOleada = 1
        self.actualizarOleada()
    }
    method recibeDanioMago(danio){}
    method frenarEnemigo()= true
}


class Nivel{
    const oleadas
    var property cantidadEnemigos // var para modificar en nivel Infinito
    var property enemigosRestantes = cantidadEnemigos 
    var property enemigosGenerados = 0
    var property indiceOleada=0
    const property tiempoSpawn
    const property nombre

    method enemigos()=oleadas.get(indiceOleada)
    
    method oleadaActual()= oleadas.get(indiceOleada)
    method noTerminoNivel()= indiceOleada < oleadas.size()-1
    method siguienteOleada(){indiceOleada +=1 
    self.reset()}
    method resetearOleadas(){
        indiceOleada=0
    }
    
    method inicioOleada() = game.sound("m.iOleada.mp3")
    method finOleada() = game.sound("m.fOleada.mp3")

    // Verifica si la oleada final está en ejecución
    method ejecutando() = cantidadEnemigos >= enemigosGenerados && enemigosRestantes > 0

    method seGeneroEnemigo() {enemigosGenerados+=1}

    method seMurioEnemigo() {enemigosRestantes-=1}

    method enemigosVivos() =  enemigosGenerados - (cantidadEnemigos - enemigosRestantes) 

    // Termina la oleada final y concluye el juego
    method terminarOleada() {
        self.finOleada().volume(0.1)
        self.finOleada().play()
    }

        method iniciarOleada(){
        self.inicioOleada().volume(0)
        enemigosRestantes = cantidadEnemigos
    }

    method cargarSlimesRestantes () {enemigosRestantes = cantidadEnemigos }
    // Verifica si la oleada final ha finalizado
    method finalizo() = enemigosRestantes <= 0 || enemigosGenerados >= cantidadEnemigos
    
    method seGeneraronSuficientes() = cantidadEnemigos == self.enemigosVivos() || self.enemigosVivos() == enemigosRestantes
    // Resetea la oleada final
    method reset() {
        enemigosGenerados = 0
        enemigosRestantes = cantidadEnemigos
    }
    method resetearCantEnemigosComoAlInicio(){}
} 

object nivelFinal inherits Nivel(oleadas=[[slimeBasico,slimeBasico,slimeGuerrero,slimeDorado],
                                          [slimeBasico,slimeGuerrero, slimeBomba,slimeGuerrero],
                                          [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja],
                                          [slimeBomba, slimeBomba, slimeBomba, slimeBomba, slimeBomba, slimeDorado],
                                          [slimeBomba, slimeBomba, slimeNinja, slimeLadron],
                                          [slimeBomba, slimeBomba, slimeNinja, slimeNinja, slimeNinja, slimeNinja, slimeNinja, slimeLadron],
                                          [slimeBomba, slimeBomba, slimeNinja,slimeNinja, slimeLadron, slimeBlessed],
                                          [slimeNinja, slimeNinja, slimeNinja, slimeBlessed,slimeBlessed, slimeBomba],
                                          [slimeBasico, slimeDorado],[slimeBlessed,slimeNinja,slimeBomba]],tiempoSpawn=1000, cantidadEnemigos=10,nombre="Final"){
override method siguienteOleada(){
    indiceOleada +=1
    
    if(indiceOleada == oleadas.size()-2){
    sonidoPartida.switchearMusica()
    }
    if (indiceOleada == oleadas.size()-1){
        fondo.cambiarFondo("fondo3.jpg")
        cantidadEnemigos += 5
    }
    self.reset()
    }
    override method reset() {
      super()
      cantidadEnemigos = 10
    }

}

const nivel1 = new Nivel(oleadas=[[slimeBasico],[slimeBasico,slimeBasico,slimeGuerrero,slimeDorado],[slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBasico]],tiempoSpawn=4000, cantidadEnemigos=5,nombre="1")
const nivel2 = new Nivel(oleadas=[[slimeBasico,slimeBasico,slimeGuerrero,slimeDorado],
                                  [slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBasico],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeBasico],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeBasico],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja]],tiempoSpawn=4000, cantidadEnemigos=6,nombre="2")
const nivel3 = new Nivel(oleadas=[[slimeBasico, slimeBasico, slimeGuerrero,slimeLadron],
                                  [slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBasico],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja,slimeBomba],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja,slimeBomba],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja,slimeBomba]],
                                  tiempoSpawn=3000, cantidadEnemigos=7,nombre="3")
const nivel4 = new Nivel(oleadas=[[slimeBasico, slimeBasico, slimeGuerrero,slimeLadron],
                                  [slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBasico],
                                  [slimeAgil,slimeGuerrero,slimeLadron,slimeNinja],
                                  [slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBomba],
                                  [slimeBomba, slimeNinja,slimeLadron,slimeGuerrero],
                                  [slimeBomba, slimeNinja,slimeLadron,slimeAgil],
                                  [slimeGuerrero,slimeLadron,slimeGuerrero,slimeLadron,slimeBlessed],
                                  [slimeBlessed, slimeNinja, slimeBomba]],
                                  tiempoSpawn=4000, cantidadEnemigos=8,nombre="4")

//algo asi deberia ser nivefinal
object nivelInfinito inherits Nivel(oleadas = [slimeBasico],tiempoSpawn=4000,cantidadEnemigos=3,nombre="infinito"){
    
    
    const enemigosEZ = [slimeBasico, slimeBasico, slimeBasico, slimeGuerrero, slimeGuerrero, slimeDorado] // 20%
    const enemigosMolestos = [slimeNinja, slimeAgil, slimeLadron,slimeGuerrero,slimeNinja, slimeAgil, slimeLadron,slimeGuerrero,slimeDorado] // 1/6
    const enemigosJodidos = [slimeNinja, slimeAgil, slimeLadron,slimeGuerrero,slimeBomba,slimeNinja, slimeAgil, slimeLadron,slimeGuerrero,slimeBomba,slimeDorado] // 9%
    const enemigosAyuda = [slimeBomba, slimeNinja, slimeBlessed,slimeLadron,slimeBomba, slimeNinja, slimeBlessed,slimeLadron,slimeDorado] // 11,1%
   
    var posiblesEnemigos = enemigosEZ
    
    const cantidadEnemigosInicial = cantidadEnemigos

    var cantidadAgregarALaLista = 7

    const oleadaAleatoria = [slimeBasico]
     method cambiarEnemigosOleada(){
        oleadaAleatoria.clear()
        cantidadAgregarALaLista.times({i=> oleadaAleatoria.add(posiblesEnemigos.get(0.randomUpTo(posiblesEnemigos.size()-1).round()))})
       
  
    cantidadEnemigos += 1.randomUpTo(1.8).round() // aumentar la cantidad de enemigos entre 1 y 3
    }

    method cambiarTipoOleada(nuevoTipo){ posiblesEnemigos = nuevoTipo }

    override method siguienteOleada(){
        if (administradorDeOleadas.numeroOleada() == 3) self.cambiarTipoOleada(enemigosMolestos) {cantidadAgregarALaLista += 1}
        if (administradorDeOleadas.numeroOleada() == 9){
            self.cambiarTipoOleada(enemigosJodidos)
            cantidadAgregarALaLista += 1
            fondo.cambiarFondo("fondo2.jpg")
            }
        if (administradorDeOleadas.numeroOleada() == 19){
            self.cambiarTipoOleada(enemigosAyuda)
            cantidadAgregarALaLista += 1
            fondo.cambiarFondo("fondo3.jpg")
            }
        
        self.cambiarEnemigosOleada()  
        self.reset()
        }

    override method enemigos()=oleadaAleatoria
    override method oleadaActual()= oleadaAleatoria
    override method noTerminoNivel()=true
    override method resetearCantEnemigosComoAlInicio(){

        cantidadEnemigos = cantidadEnemigosInicial
        enemigosRestantes = cantidadEnemigos // agregue esto porque no se actualizaba, cambiarlo a metodo
        oleadaAleatoria.clear()
        oleadaAleatoria.add(slimeBasico)
    }

}
