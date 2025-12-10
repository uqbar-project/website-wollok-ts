import pantallas.*
import wollok.game.*
import juego.*
import imagenYSonido.*

class Boxeador{
    var property vida = 100
    var property estado = quieto
    var property rival
    var property poder
    var property yBase
    var idCubrir = 0 //Identifica cada acción de «Cubrir» con un número incremental

    var property position = game.at(6,yBase)

    method yDeAtaque() = if(yBase < 2) {1} else {3}
    method image() =  self.tipo() + estado.nombre() + ".png"
    method probabilidadDeFallar() = 0

    method recibirGolpe() {
        vida = 0.max(vida-rival.poder())
        self.estado(golpeado)
        position = game.at(6,yBase)
        game.schedule(1500, { self.descansar() })
    }

    method recibirGolpeEspecial() {
        vida = 0.max(vida - (rival.poder() + 15))
        self.estado(golpeadoEspecial)
        position = game.at(6,yBase)
        game.schedule(1500, { self.descansar() })
    }

    method estaProtegido() = estado.protege()
    method yaNoPelea() = estado.nombre() == "Derrota" || estado.nombre() == "Victoria"
    method estaQuieto() = estado.nombre() == "Quieto"

    method prepararGolpe(tipoDeGolpe){ //tipo 1: golpe normal, tipo 2: golpe especial
        self.estado(preparandoGolpe)
        game.schedule(600, {
            if(tipoDeGolpe == 1 && estado.nombre() == "PreparandoGolpe"){self.atacar()}
            else if (estado.nombre() == "PreparandoGolpe"){self.atacarEspecial()}
        })
    }

    method atacar() {
        if(!mario.sePuedePelear() || rival.yaNoPelea()) {self.error("")}

        const fallaElGolpe = (0.randomUpTo(self.probabilidadDeFallar())).round() > 1

        if(fallaElGolpe) {
            self.estado(fallando) 
            game.schedule(500, { self.descansar() })
        } 
        else {self.concretarAtaqueNormal()}
    }

    method concretarAtaqueNormal(){
        self.estado(atacando)
        position = game.at(6,self.yDeAtaque())

        if (!rival.estaProtegido()){
           rival.recibirGolpe()
           pantallaNivel.verificarVida()
           gestorSonidos.sonidoGolpe()
        } else {gestorSonidos.sonidoBloqueo()}

        game.schedule(600, { self.descansar() position = game.at(6,yBase) })
    }

    method atacarEspecial() {
        if(!mario.sePuedePelear() || rival.yaNoPelea()) {self.error("")}

        self.estado(atacandoEspecial)
        position = game.at(6,self.yDeAtaque())

        if (!rival.estaProtegido()){
            rival.recibirGolpeEspecial() 
            pantallaNivel.verificarVida()
            gestorSonidos.sonidoGolpeEspecial()
        } else {gestorSonidos.sonidoBloqueoEspecial()}

        game.schedule(2000, { self.descansar() position = game.at(6,yBase) })
    }

    method cubrirse() {
        self.estado(cubriendo)
        idCubrir += 1
        const idCubrirActual = idCubrir 
        game.schedule(1000, 
            { if(idCubrirActual == idCubrir) {self.descansar() idCubrir=0} }
        ) //Solo deja de cubrirse si no se ejecutó la acción nuevamente
    }

    method descansar() {
        if(self.yaNoPelea()) {self.error("")}
        estado = quieto
        position = game.at(6,yBase)
    }

    method reiniciar(){
        vida = 100
        estado = quieto
        position = game.at(6,yBase)
    }

    method tipo()
}

object boxeadorJugador inherits Boxeador{
    method initialize(){
        rival = ""
        poder = 0
        yBase = 0
    }

    override method tipo() = "boxeadorJugador"
    override method probabilidadDeFallar() = 2
}

class Oponente inherits Boxeador{
    method initialize(){
        rival = boxeadorJugador
        yBase = 4
    } 
}
object joe inherits Oponente{
    override method initialize(){super() poder = 10}
    override method tipo() = "joe"
    override method probabilidadDeFallar() = 3
}
object rocky inherits Oponente{
    override method initialize(){super() poder = 20}
    override method tipo() = "rocky"
    override method probabilidadDeFallar() = 2
}

object tyson inherits Oponente{
    override method initialize(){super() poder = 30}
    override method tipo() = "tyson"
    //nunca falla los golpes
}

//Estados

object quieto {
  method nombre() = "Quieto"
  method protege() = false
}

object preparandoGolpe{
    method nombre() = "PreparandoGolpe"
    method protege() = false
}
object atacando {
  method nombre() = "Atacando"
  method protege() = false
}

object atacandoEspecial {
  method nombre() = "AtacandoEspecial"
  method protege() = false
}

object fallando {
  method nombre() = "Fallando"
  method protege() = false
}

object cubriendo {
  method nombre() = "Cubriendo"
  method protege() = true
}

object golpeado {
  method nombre() = "Golpeado"
  method protege() = true
}

object golpeadoEspecial {
  method nombre() = "GolpeadoEspecial"
  method protege() = true
}
object victoria {
  method nombre() = "Victoria"
  method protege() = true
}

object derrota{
    method nombre() = "Derrota"
    method protege() = true
}