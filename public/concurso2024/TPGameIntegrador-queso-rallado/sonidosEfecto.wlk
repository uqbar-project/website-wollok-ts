object musicaFondo {
    const fondo = game.sound("musicaFondo.mp3")

    method iniciar() {
        fondo.shouldLoop(true)
        fondo.play()
        fondo.volume(0.2)
    }

    method pausar() = fondo.pause()
    method continuar() = fondo.resume()
    method detener() = fondo.stop()
}

