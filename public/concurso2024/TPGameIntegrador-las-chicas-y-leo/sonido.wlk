import wollok.game.*
object musica {
  const property cancion = game.sound("musicaGhost.mp3")

  method iniciarCancion(){
    cancion.play()
    cancion.shouldLoop(true)
    cancion.volume(0.3)
  }
}