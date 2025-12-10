import protagonista.*
import objetos1.*
import configuracionTeclas.*
import musica.*

object laUltimaClave {
    const pantallaHistoria = new Pantalla(img= "historia.png")
    const pantallaControles = new Pantalla(img= "controles.png")


    method iniciar() {
        game.width(20)
        game.height(14)
        game.cellSize(75) 
        game.title("La Última Clave")
        teclado.config()
        musica.reproducirMusica()
        pantallaHistoria.iniciar()
        game.schedule(20000, {pantallaControles.iniciar()})
    }

}


