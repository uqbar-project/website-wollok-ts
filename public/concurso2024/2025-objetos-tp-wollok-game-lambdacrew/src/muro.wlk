import src.tanque.*
import src.bala.*


class Muro {

    const position
    var durabilidad = 3

    method puedeSerDaniadoPorBala() = true

    method esAtravesable(entidad) = false

    method durabilidad() = durabilidad

    method position() {
        return position
    }

    method restablecerDurabilidad(){
        durabilidad = 3
    }

    method dibujarMuro(){
        game.addVisual(self)
    }

    method recibirImpactoDeBala(unaBala) {

        if(durabilidad > 1) {
            durabilidad = durabilidad - unaBala.fuerza()
            entidad_impacto.conMuro(unaBala)

        }
        else {
            game.removeVisual(self)
            entidad_impacto.conMuro(unaBala)
        }
    }

    
    method teChocoUnTanque(tanque) {}

    method puedeCubrirme() = false
}

class Muro_Ladrillos inherits Muro{

    method image() {
        if (durabilidad == 3){
            return "muro_health_3.png"
        }
        else if (durabilidad == 2){
            return  "muro_health_2.png"
        }
        else if (durabilidad == 1) {
            return "muro_health_1.png"
        }
        else {
            return  "muro_tumbado.png"
        }
    }

}
class Muro_Reforzado inherits Muro{

    override method recibirImpactoDeBala(unaBala){
        if (unaBala.rompeMurosReforzados()){
            super(unaBala)
        }
        borrar_balas.bala_logro_su_objetivo(unaBala.lePerteneceA(), unaBala)
    }

    method image() {
        if (durabilidad == 3){
            return "muro_reforzado.png"
        }
        else if (durabilidad == 2){
            return  "muro_health_2.png"
        }
        else if (durabilidad == 1) {
            return "muro_health_1.png"
        }
        else {
            return  "muro_tumbado.png"
        }
    }
}

class Parche_De_Agua inherits Muro {

    method image() {
        return "agua.png"
    }

    override method esAtravesable(entidad) = entidad.irPorAgua()

    override method puedeSerDaniadoPorBala() = false

    

}

class Arbustos {
    
    const position

    method image() {
        return "arbustos.png"
    }

    method position() {
        return position
    }

    method dibujarMuro(){
        game.addVisual(self)
    }

    method esAtravesable(entidad) = true

    method puedeSerDaniadoPorBala() = false

    method puedeCubrirme() = true

    method teChocoUnTanque (tanque) {}

}

object ocultarse {

    method ocultar(entidad) {

        entidad.image("invisible.png")
    }
}

object entidad_impacto {

    method conMuro (unaBala) {
      //  const muro_rompiendose = game.sound("balas_chocando.wav")

      //  muro_rompiendose.play()

      //  game.schedule(7000, {muro_rompiendose.stop()})

        borrar_balas.bala_logro_su_objetivo(unaBala.lePerteneceA(), unaBala)
        

       

    }
}
