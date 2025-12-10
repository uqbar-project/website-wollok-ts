import juegoBase.*
import armas.*
import enemigos.*
import wollok.game.*
import niveles.*

object castillo {
    var property position =game.at(8,0) 
    method image() ="castillo.png" //Y si vemos de meterle efectos como de "deteriorado" cuando esté por debajo del 50% de vida y al llegar a 0 antes de sacarte del juego que cambie la imagen a un cúmulo de ladrillos y despues diga "Perdiste" por ejemplo
    method activarColision(){
        game.onCollideDo( self,{enemigo=> enemigo.atacar(self)})
    }
    
    //Manejo de todo el puterio de la vida
    var vida = 35 //50
    method vida() = vida
    method reiniciarVida() {
        vida = 35
    }
    method recibirDaño(cantidad){
    vida = 0.max(vida-cantidad)
    if(!self.estaVivo()){
        juegoDelCastillo.partidaFinalizada() 
    }}
    method estaVivo()=vida > 0
    
}

/// Clase Contadores ///

class Contador{
    method position()
    method text()
}
object paleta {
     const property blanco = "#ffffffff"
}   
class ContadorVida inherits Contador{
    override method position() = game.at(2, 8)
    override method text() =  castillo.vida().toString()
    method textColor() = paleta.blanco()
}

class ContadorMoneda inherits Contador{
    override method position() = game.at(5, 9) 
    override method text() =  personajePrincipal.monedas().toString()
    method textColor() = paleta.blanco()
}

class ContadorEnemigos inherits Contador{
    override method position() = game.at(2, 9) 
    override method text() =  personajePrincipal.kills().toString()
    method textColor() = paleta.blanco()
}

object personajePrincipal{
    method posicionActual() =position 
    var nivel= nivelPrueba

    //Contador de kills
    var kills = 0
    method kills() = kills 
    method aumentarKills() {
        kills += 1
    }
    method reiniciarKills(){
        kills = 0
    } 
    //const  torres = []
    const  imagen="cursorTorre.png"
    method image() = imagen
    var property position =game.at(8,3) 
    method siguienteNivel(unNivel) {
      nivel=unNivel
    }
    //method torres()=torres

    //movimientos, dejar aca para evitar confusion con los de torres
    method moverseHaciaArriba() {
        const pos=nivel.ubicacionSiguienteA([position.x(),position.y()])
        position= game.at(pos.get(0), pos.get(1))
	}
	method moverseHaciaAbajo() {
		const pos =nivel.ubicacionAnterior()
        position=game.at(pos.get(0),pos.get(1))
    }
    //Metodos encargados del manejo de la economia

    var monedas = 6 //6
    method monedas() = monedas
    method puedePagar(costo) = monedas >= costo
    method reiniciarMonedas(){
        monedas = 6
    } 
    method gastarMonedas(unCosto){
        monedas = monedas - unCosto
    }
    method recogerMonedas(cantMonedas){monedas += cantMonedas} ///Actualizar
    //Todos los metodos relacionados al poner torres
    method torreSeleccionada() =torresOpciones.torreSeleccionada(position.x(),position.y())
    method torreCosto() =self.torreSeleccionada().costo()  
    method esPosibleMejorar() =  torresOpciones.esPosibleMejorar() // Revisa si la posicion del cursor no esté en "Eliminar"
    method esPosibleEliminar() =  torresOpciones.esPosibleEliminar() // Revisa si la posicion del cursor no esté en "Eliminar"
    method sePuedeAgregarTorre() = not self.hayTorreEn(self.posicionActual()) && self.puedePagar(self.torreCosto())   && juegoDelCastillo.nivelActual().partidaSigue()
    

    method accionDelCursor(){
       if(self.esPosibleMejorar())
            self.mejorarTorrePosible()
        else{
            self.agregarOEliminarTorre()
        }
       
    }
    method agregarOEliminarTorre(){
        if (!self.esPosibleEliminar() && self.sePuedeAgregarTorre() ){
            torresOpciones.elegirTorre() //le dice a torres Opcioens (menu izquierdo) que guarde esa torre.
            self.gastarMonedas(self.torreCosto())
            self.torreSeleccionada().reporducirAudioConstruir()
        }
        else{
            self.eliminarSiEsPosible()
        }
    }
    method mejorarTorrePosible(){
        if(self.hayTorreEn(self.posicionActual())){
            torresOpciones.mejorarTorre(self.position(),self)
        }
    }
    method eliminarSiEsPosible() {
      if(self.esPosibleEliminar() and  self.hayTorreEn(self.posicionActual())){ // si está en la posicion de eliminar, y hay torre en la celda actual, eliminarla.
        torresOpciones.eliminarTorre(position) // torres opciones se encarga de hacer el trabajo de eliminar.
      }
    }
    method hayTorreEn(positionActual) = torresOpciones.torres().any({ t => t.position() == positionActual }) //Con esto se puede simplificar sin necesidad de tener una lista de torres en el jugador. No es necesario si evaluas en la acción directamente
        method partidaFinalizada() {
        monedas=6
    }


}