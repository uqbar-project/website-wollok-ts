import wollok.game.*

object sonidos {
    //esto solo reproduce el sonido que haya, empieza y termina
    const property sonidoDeFondo = game.sound("sonidoDeFondo.mp3")
    var property isPlaying = false
    var volume = 0.5

  method playFondo(){
    // con shoul se loopee (repita)
    if(not self.isPlaying()){
      sonidoDeFondo.shouldLoop(true) 

        sonidoDeFondo.play()
    }
    self.isPlaying(true)

  }
  method toggle() {
    //si o si iba en variable por que sino era uno nuevo
    if(!isPlaying){
      sonidoDeFondo.resume()
      isPlaying = true
    }else{
      sonidoDeFondo.pause()
      isPlaying = false
    }
  }
  method stopSonidoDeFondo() {
    if(self.isPlaying()){
      sonidoDeFondo.stop()
    }
    self.isPlaying(false)
  }
  method playGameOver(){
    const sonidoGameOver = game.sound("game_over.mp3")
    sonidoGameOver.play()
  }

  method subirVolumen(){
      volume = 1.min(volume + 0.1)
      sonidoDeFondo.volume(volume)
  }

  method bajarVolumen() {
      volume = 0.max(volume - 0.1)
      sonidoDeFondo.volume(volume)
    
  }
}