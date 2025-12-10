object sonidosGlobales {
    const musicaMenu = game.sound("song2.mp3")
    const musicaJuego = game.sound("introSong.mp3")
    var suenaMusicaMenu = false

    method iniciarControles() {
        keyboard.plusKey().onPressDo({ self.volumenMenu(1); self.volumenJuego(1) })//maximo vol
        keyboard.minusKey().onPressDo({ self.volumenMenu(0.1); self.volumenJuego(0.1) })//minimo vol
        keyboard.m().onPressDo({ self.volumenMenu(0); self.volumenJuego(0) })//mute
    }

    method iniciarMusicaMenu() {
        if(!suenaMusicaMenu){
        suenaMusicaMenu = true
        musicaMenu.shouldLoop(true)
        musicaMenu.volume(0.3)
        game.schedule(100,{musicaMenu.play()})}
    }

    method detenerMusicaMenu() {if(suenaMusicaMenu){musicaMenu.stop() suenaMusicaMenu=false}}
    
    method iniciarMusicaJuego() {
        musicaJuego.shouldLoop(true)
        musicaJuego.volume(0.3)
        game.schedule(100,{musicaJuego.play()})
    }

    method detenerMusicaJuego() {if(musicaJuego.played()){musicaJuego.stop()}}
    
    method volumenMenu(valor) {
    musicaMenu.volume(valor)
    }

    // Volumen de la música del juego
    method volumenJuego(valor) {
    musicaJuego.volume(valor)
    }
    
    method playError() {
        game.sound("midiMal.wav").play() //one shot para carta equivocada
    
    }
    method playCursor() {
        game.sound("cursor.wav").play() //sonido para mover el cursor
    }
    method playCorrecto() {
        game.sound("bien.wav").play() //sonido para cartas correctas
    }

    method playVictoria() {
        game.sound("victoria.mp3").play() // sonido de victoria
    }
}
