// object ambiente{
  
//   method sonar() {
//     sonido.play()
//   }
//   method pausa() {
//     sonido.pause()
//   }
//   method loop() {
//     sonido.shouldLoop(true)
//   }
//   method stop() {
//     sonido.stop()
//   }
//   method played() {
//     return sonido.played()
//   }
// }

object musica {

  const property sonido = game.sound("ambiente.mp3")

  method reproducirMusica() {
    sonido.play()
    //musicaAmbiente.shouldLoop(true)
  }

  method clear() {
    sonido.stop()
  }
  
}

