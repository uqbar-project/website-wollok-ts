import juego.*
import objetos1.*
import protagonista.*
// import nivelUno.*
import nivelUno.*
import nivelDos.*
import nivelDosDificil.*
import nivelUnoD.*
import musica.*


object teclado {
  method config() {
    const pantallaModosJuego = new Pantalla(img = "modosJuego.png")
    keyboard.w().onPressDo({ carlitos.move(carlitos.position().up(1)) })
    keyboard.s().onPressDo({ carlitos.move(carlitos.position().down(1)) })
    keyboard.a().onPressDo({ carlitos.move(carlitos.position().left(1)) })
    keyboard.d().onPressDo({ carlitos.move(carlitos.position().right(1)) })
    
    // //boton  1 --> Modo Facil
    keyboard.num(1).onPressDo({nivel1.iniciar()})

    // //boton  2 --> Modo Dificil
    keyboard.num(2).onPressDo({nivel1D.iniciar()})

    keyboard.space().onPressDo({
      pantallaModosJuego.iniciar()
      musica.reproducirMusica()
    })

    // //k -->   Darle inicio al nivel2 Facil
    // keyboard.k().onPressDo({nivel2.iniciar()})

    // //l -->   Darle inicio al nivel2 Dificil
    keyboard.l().onPressDo({nivel2Dificil.iniciar()})

  }
}