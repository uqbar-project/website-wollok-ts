import wollok.game.*

object musicaDeFondo{

    var property volumen = 0.5 
    
    method tema(){
        return game.sound("echo-in-the-night.mp3")
    }

    method volumeUp(num){
        volumen += num
    }

    method volumeDown(num){
        volumen += num 
    }
}

object enemigos{
    method zombieSonido(){
        return game.sound("zombie-1.mp3")
    }
}

object musicaMenu {
    const property file = game.sound("sonido-menu.mp3")

    method play() {
        file.play()
    }

    method stop() {
        file.stop()
    }
}