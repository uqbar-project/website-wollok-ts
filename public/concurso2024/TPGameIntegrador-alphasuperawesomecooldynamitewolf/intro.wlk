import wollok.game.*
import pantalla.*
import controles.*
import menu.*
import juegoBase.*

class Intros{
    var property position =game.origin()
    const audio
    const imagen
    method image() = imagen
    method iniciar()
    method silenciarSiEsPosible() {
      audio.stop()
    }
}
//Hay que cambiar los object en class, y crear un object que instancie cada uno. Lo dijeron en clase hoy eso. El "game.addVisual(self) hay que pasarlo a la clase padre ya que se usa en todas las instancias"
/*
object instanciaIntros{
    const intro0...
    const intro1...
    const intro2...
    const intro3...
}
*/

object intro0 inherits Intros (audio=game.sound("victoria.mp3") , imagen = "intro0.png"){ //El audio es uno random de los que ya teníamos solo para poder instanciar.
    override method iniciar(){
        controles.controlesIntro()
        game.addVisual(self)
        game.schedule(1000,{audio.play()})
    }
}
object intro1 inherits Intros (audio=game.sound("audio1.mp3"), imagen = "intro1.png"){
    override method iniciar(){
        audio.play()
        //controles.controlesIntro()
        game.addVisual(self)
        //game.schedule(1000,{audio.play()})
    }
}
object intro2 inherits Intros (audio=game.sound ("audio2.mp3"),imagen = "intro2.png"){
    override method iniciar(){
        audio.play()
        game.addVisual(self)
    }
}
object intro3 inherits Intros (audio=game.sound ("audio3.mp3") ,imagen = "intro3.png"){
    override method iniciar(){
        audio.play()
        game.addVisual(self)
    }
}
//alguna razon se ejecuta primero el silencio.
object secuencia{
    var lastVisual = null
    var property position =game.origin()
    const frames = [intro0, intro1, intro2, intro3]
    method saltar(){
        self.saltarFrame()
    }
    method saltarFrame() {
        if(lastVisual != null) lastVisual.silenciarSiEsPosible() game.removeVisual(lastVisual)
        if(frames.size() > 0){
            lastVisual = frames.first()
            frames.first().iniciar()
            frames.remove(frames.first())
        }
        else{
            lastVisual = null
            self.agregarMenu()
        }
    }
    method obtenerMenu() =juego.obtenerMenuInicial()
    method agregarMenu() {
        if(!game.hasVisual(self.obtenerMenu())){ // si la  instancia menu no esta declarada y el juego del castillo todavia no inició entonces agrega el menu.
            game.addVisual(self.obtenerMenu())
            self.obtenerMenu().seleccionNivel()
        }
    }
}