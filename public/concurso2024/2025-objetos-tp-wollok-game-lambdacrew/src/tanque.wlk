import src.powerUps.*
import wollok.game.*
import battlecity.*
import bala.*
import halcon.*
import mapa.*
import movimiento.*
import finalizar_partida.*



class TanqueJugador {

    var direccion = sinDireccion

    var posicion = new Position()
    var spawn = new Position()

    var rondas_ganadas = 1

    var respawn = true
    var inmune = false

    var acuatico = false
    var romper_murosReforzados = false
    var controlesInvertidos = false

    var banderaQueLleva = null
    var lleva_una_bandera = false

    const balas_activas_del_tanque = []
    var cargador = 1
    var velocidad_balas = 100 

    // HABILITAR ROMPER MUROS / CONTROLES INVERTIDOS / IR POR AGUA / SER INMUNE / COLISIONES CON OTROS OBJETOS Y SI ES ATRAVESABLE O PUEDE SER DANIADO POR BALAS

    method romper_murosReforzados(valor) {
        romper_murosReforzados = valor
    }

    method controlesInvertidos(valor) {
        controlesInvertidos = valor
    }

    method habilitarIrPorAgua(valor){
        acuatico = valor
    }

    method cambiarEstadoInmunidad(estado){
        inmune = estado
    }


    method irPorAgua() = acuatico
    method banderaQueLleva() = banderaQueLleva
    method inmune() = inmune
    method bandera_que_lleva() = banderaQueLleva
    method lleva_una_bandera() = lleva_una_bandera
    method respawn() = respawn
    method cargador() = cargador
    method controlesInvertidos() = controlesInvertidos
    method romper_murosReforzados() = romper_murosReforzados
    
    
    method esAtravesable(entidad) = false
    method puedeSerDaniadoPorBala() = true
    
    method chocarConObjetos () {
        game.onCollideDo(self, {n => n.teChocoUnTanque(self)} )
    }

    // POSICIONAMIENTO Y MOVIMIENTO EN EL TABLERO

    method position(){
        return posicion
    }

    method position(nuevaPosicion){
        posicion = nuevaPosicion
    }

    method direccion(nuevaDireccion) {
        direccion = nuevaDireccion
    }

    method direccion(){
        return direccion
    }

    method setearSpawn() {
        spawn = posicion
    }

    method mover_tanque(unaOrientacion){
        direccion = unaOrientacion

        if (controlesInvertidos) {
            direccion = unaOrientacion.controlInvertido()
            
        }

        if (permitir_movimiento.puedoMovermeEnEstaDireccion(self, direccion)){

            const nuevaPosicion = direccion.siguientePosicion(posicion)
            posicion = nuevaPosicion
   
        }
        
    }

    // ATAQUE DISPARAR TANQUES

    method puedeDispararOtra() = balas_activas_del_tanque.size() < cargador

    method aumentarMunicionEn(valor){
        cargador = valor
    }

    method velocidad_balas() = velocidad_balas

    method aumentarVelocidadBala(nuevaVelocidad){
        velocidad_balas = nuevaVelocidad
    }

    method balas_que_disparo_el_tanque() {
        return balas_activas_del_tanque
    }

    method irBorrandoBalas(unaBala){
        balas_activas_del_tanque.remove(unaBala)
    } 

    method disparar_de_tanques(){

        // const tanque_disparando = game.sound("tanque_disparando.wav")

        if(self.puedeDispararOtra()) {
            const bala = new Bala(lePerteneceA = self, direccion = self.direccion(), posicion = self.position())

            if (romper_murosReforzados) {
                bala.habilitarRomperMurosReforzados(true)
            }

            balas_activas_del_tanque.add(bala)
            bala.dibujarBala()

            // tanque_disparando.play()

            // game.schedule(500, {tanque_disparando.stop()})
        }
    }

    // RESPAWN -- (IDEA SUGERIDA, QUE AL SER DESTRUIDO TENER UNA  FLAG QUE INDIQUE TE DESTRUYERON Y TE POSICIONAN EN UNA POSICION FUERA DE LA VISTA DEL TABLERA CON ESA FLAG ACTIVADA PARA EVITAR MOVERTE Y QUE DISPARES)
    
    method aRespawnear(){
        posicion = spawn
    }

    method opcion_respawn(valor){
        respawn = valor
    }

    method normalizar(){
        inmune = false
        acuatico = false
        controlesInvertidos = false
        romper_murosReforzados = false
        lleva_una_bandera = false
        respawn = true

        banderaQueLleva = null

        cargador = 1
        velocidad_balas = 100
    }
    
    // ROBAR, RECUPERAR Y SOLTAR BANDERA (HALCON)

    method llevaLaBanderaDeAlguien(){
        lleva_una_bandera = true
    }

    method noLlevarUnaBandera(){
        banderaQueLleva = null
        lleva_una_bandera = false
    }

    method agarrarBandera(unaBandera){
        banderaQueLleva = unaBandera
        self.llevaLaBanderaDeAlguien()
    }

    method soltar_bandera() {
        banderaQueLleva.bandera_cae_al_suelo_desde_la_ubicacion_de(self)
        self.noLlevarUnaBandera()
    }

    // GANAR RONDA

    method rondas_ganadas() = rondas_ganadas

    method ganar_ronda() {
        rondas_ganadas = rondas_ganadas + 1
    }

    method resetearRondasGanadas() {
        rondas_ganadas = 1
    }

    // EXPLOTAR TANQUE

    method explotar_tanque(unTanque){

        const bala_impactando = game.sound("balas_chocando.wav")

        unTanque.position(new Position(x = 12 , y = 12))

        bala_impactando.play()

    }

    // COLISION DE BALA CON UN TANQUE - SI DEBE RESPAWNEAR y SOLTAR BANDERA o DESTRUIRSE
    method recibirImpactoDeBala(unaBala) {
        
        

        borrar_balas.bala_logro_su_objetivo(unaBala.lePerteneceA(), unaBala) 

        if (self != unaBala.lePerteneceA() && !inmune){
            
            
            

            if (respawn) {

                if (lleva_una_bandera){
                    self.soltar_bandera()

                }

                game.schedule(1500, {self.aRespawnear()})
                
                
            }

            
                        
            else {  
                
                if (!verificar_finalizacion_partida.gano_alguien()){
        
                    resetear.ronda()
                    game.say(unaBala.lePerteneceA(), unaBala.lePerteneceA().rondas_ganadas().toString())
                    unaBala.lePerteneceA().ganar_ronda()
                    self.opcion_respawn(true)

                }

                else {
                    verificar_finalizacion_partida.mensaje_victoria()

                    musica_victoria.play()

                    game.removeTickEvent("APARECE POWER UPS")
                    game.removeTickEvent("DesplazarBalasTanque2")
                    game.removeTickEvent("DesplazarBalasTanque1")
                    

                    game.schedule(1000, {

                        game.clear()
                        
                        game.addVisual(gameOver)

                        gameOver.darle_su_nueva_posicion_tanques (unaBala.lePerteneceA())

                        gameOver.mostrar_mensaje("El ganador es : " + unaBala.lePerteneceA())

                        gameOver.volverAlMenu()

                    })
                }       
            }
            self.explotar_tanque(self)
            self.normalizar()
        }            
    }

    method puedeCubrirme() = false
}
       
object jugador2_tanque inherits TanqueJugador () {
        
    method image() {

        return direccion.imagenTanque2()
    }


    method actividad(){
            keyboard.p().onPressDo {
            self.disparar_de_tanques()
            }

            keyboard.right().onPressDo {
            self.mover_tanque(derecha)

            }

            keyboard.left().onPressDo {
            self.mover_tanque(izquierda)

            }

            keyboard.down().onPressDo {
            self.mover_tanque(abajo)

            }

            keyboard.up().onPressDo {
            self.mover_tanque(arriba)

            }

            self.chocarConObjetos()

    }



    method hacerNuevoTickDisparo() {
        game.removeTickEvent("DesplazarBalasTanque2") 

        game.onTick(self.velocidad_balas(), "DesplazarBalasTanque2", {
            self.balas_que_disparo_el_tanque().forEach({n => n.moverBalas() })
            })
    }
}

object jugador1_tanque inherits TanqueJugador () {

    method image() {

        return direccion.imagenTanque1()
    }


    method actividad(){
            keyboard.f().onPressDo {
            self.disparar_de_tanques()
            }

            keyboard.d().onPressDo {
            self.mover_tanque(derecha)

            }

            keyboard.a().onPressDo {
            self.mover_tanque(izquierda)

            }

            keyboard.s().onPressDo {
            self.mover_tanque(abajo)

            }

            keyboard.w().onPressDo {
            self.mover_tanque(arriba)

            }

            self.chocarConObjetos()
    }


    method hacerNuevoTickDisparo() {
        game.removeTickEvent("DesplazarBalasTanque1") 

        game.onTick(self.velocidad_balas(), "DesplazarBalasTanque1", {
            self.balas_que_disparo_el_tanque().forEach({n => n.moverBalas() })
            })
    }
}