import src.tanque_enemigo.*
import battlecity.*
import tanque.*
import movimiento.*
import aura_escudo.*


// const powerup_reclamado = game.sound("grabPowerUp.wav")
// const aparecio_powerup = game.sound("power_up_aparece.wav")

object hacerSonar {

    method sonido(efectoSonido) {

        efectoSonido.play()

        game.schedule(1000, {efectoSonido.stop()})


    }
}
class PowerUps {
    var posicion = new Position()

    method position(){
        return posicion
    }

    method position(nuevaPosicion){
        posicion = nuevaPosicion
    }

    method esAtravesable(entidad) = true
    method puedeSerDaniadoPorBala() = false

    method teChocoUnTanque (tanque) {

        self.efecto(tanque)
    }

    method aparecerPowerUp(){

        const posicionAlAzar = new Position(x = 0.randomUpTo(juegoBattleCity.ancho() - 1), y = 0.randomUpTo(juegoBattleCity.alto() - 1))

        const aparecio_powerup = game.sound("power_up_aparece.wav")

        self.position(posicionAlAzar)

        hacerSonar.sonido(aparecio_powerup)

        game.addVisual(self)

    }

    method powerUpTomado(){

        const powerup_reclamado = game.sound("grabPowerUp.wav")

        hacerSonar.sonido(powerup_reclamado)

        game.removeVisual(self)

    }

    method puedeCubrirme() = false

    




    method efecto(tanque) {}
}

object invertir_controles inherits PowerUps  {
    const player = [jugador1_tanque, jugador2_tanque]

    method image() {
        return "pw_marear.png"
    }

    override method efecto(tanqueQueAgarroElPower) {

        const jugadorAfectado = player.filter({jugador => jugador != tanqueQueAgarroElPower}).anyOne()

        jugadorAfectado.controlesInvertidos(true)

        game.say(jugadorAfectado, "Que mareoo")

        self.powerUpTomado()

        game.schedule(7000, {jugadorAfectado.controlesInvertidos(false) game.say(jugadorAfectado, "Ya estoy bien")})

    }
}

object aumentar_balas inherits PowerUps {

    method image() {
        return "pw_aumentar_balas.png"
    }

    override method efecto(tanqueQueAgarroElPower) {

        tanqueQueAgarroElPower.aumentarMunicionEn(2)
        self.powerUpTomado()

    }
}


object escudo inherits PowerUps {

    method image() {
        return "pw_escudo.png"
    }

    override method efecto(tanqueQueAgarroElPower) {

        const aura_del_tanque = new Aura_escudo (tanque = tanqueQueAgarroElPower)

        tanqueQueAgarroElPower.cambiarEstadoInmunidad(true)

        self.powerUpTomado()

        aura_del_tanque.dibujarEscudo()

        game.schedule(5000, {tanqueQueAgarroElPower.cambiarEstadoInmunidad(false) game.removeVisual(aura_del_tanque)})

    }
}
 
object pasarPorAgua inherits PowerUps {

    method image() {
        return "pw_bote.png"
    }

    override method efecto(tanqueQueAgarroElPower) {

        tanqueQueAgarroElPower.habilitarIrPorAgua(true)
        self.powerUpTomado()

    }
}

object aumentar_velocidad_balas inherits PowerUps {

    method image() {
        return "pw_aumentar_velocidad_balas.png"
    }

    override method efecto (tanqueQueAgarroElPower) {

        tanqueQueAgarroElPower.aumentarVelocidadBala(1.max(tanqueQueAgarroElPower.velocidad_balas() - 20))

        tanqueQueAgarroElPower.hacerNuevoTickDisparo()

        self.powerUpTomado()

    }
}

object romper_muros_irrompibles inherits PowerUps {

    method image() {
        return "pw_romper_muros_reforzados.png"
    }

    override method efecto (tanqueQueAgarroElPower) {

        tanqueQueAgarroElPower.romper_murosReforzados(true)

        self.powerUpTomado()
    }
}

object spawnearPowerUps{

    const powerUpsDisponibles = [romper_muros_irrompibles, aumentar_velocidad_balas, invertir_controles, pasarPorAgua, escudo, aumentar_balas]

    method elegirUnPowerAlAzar() {
        
        const aparecio = powerUpsDisponibles.anyOne()

        aparecio.aparecerPowerUp()

        game.schedule(3000, {game.removeVisual(aparecio)})
    }
}
