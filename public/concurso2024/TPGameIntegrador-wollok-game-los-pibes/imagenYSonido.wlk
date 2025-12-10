import Boxeadores.*
import pantallas.*
import juego.*

//SONIDO

object gestorSonidos {
    // Referencias a música y efectos actuales
    var musicaActual = null

    // Diccionarios para almacenar música y efectos
    const musicas = new Dictionary()
    const efectos = new Dictionary()

    // Inicializar sonidos
    method initialize() {
        // Música
        musicas.put("menu", game.sound("mscMenu.ogg"))
        musicas.put("dificultad", game.sound("mscDificultad.ogg"))
        musicas.put("pelea", game.sound("mscPelea.ogg"))
        musicas.put("victoria", game.sound("mscVictoria.ogg"))
        musicas.put("derrota", game.sound("mscDerrota.ogg"))
        musicas.put("comienza", game.sound("mscComienza.ogg"))
        musicas.put("final", game.sound("mscFinal.ogg"))

        // Efectos de sonido
        efectos.put("golpe", "sonGolpe.ogg")
        efectos.put("golpeEspecial", "sonGolpeEspecial.ogg")
        efectos.put("bloqueo", "sonBloqueo.ogg")
        efectos.put("bloqueoEspecial", "sonBloqueoEspecial.ogg")
        efectos.put("enter", "sonEnter.ogg")
        efectos.put("campana", "sonCampana.ogg")
        efectos.put("campanaSimple", "sonCampanaSimple.ogg")
        efectos.put("tribuna", "sonTribuna.ogg")
        efectos.put("alertaEspecial", "sonAlertaEspecial.ogg")
        efectos.put("tituloRoto", "sonTituloRoto.ogg")
    }

    // Método para reproducir música
    method reproducirMusica(nombre) {
        if(musicas.get(nombre) == musicaActual) {self.error("ya se está reproduciendo")}

        self.pararMusica()
        musicaActual = musicas.get(nombre)
        musicaActual.shouldLoop(true)
        musicaActual.volume(1.0)
        musicaActual.play()
    }

    // Método para detener la música
    method pararMusica() {
        if (musicaActual != null) {
            musicaActual.stop()
        }
        musicaActual = null
    }

    // Método para reproducir efectos de sonido
    method reproducirEfecto(nombre) {
        const ruta = efectos.get(nombre)
        if (ruta == null) { self.error("Efecto de sonido no encontrado: " + nombre) }

        const efecto = game.sound(ruta)
        efecto.volume(0.8)
        efecto.play()
    }

    method musicaMenu() {self.reproducirMusica("menu")}
    method musicaDificultad() {self.reproducirMusica("dificultad")}
    method musicaComienzaNivel() {self.reproducirMusica("comienza")}
    method musicaPelea() {self.reproducirMusica("pelea")}
    method musicaVictoria() {self.reproducirMusica("victoria")}
    method musicaDerrota() {self.reproducirMusica("derrota")}
    method musicaFinal() {self.reproducirMusica("final")}


    method sonidoGolpe() {self.reproducirEfecto("golpe")}
    method sonidoGolpeEspecial() {self.reproducirEfecto("golpeEspecial")}
    method sonidoBloqueo() {self.reproducirEfecto("bloqueo")}
    method sonidoBloqueoEspecial() {self.reproducirEfecto("bloqueoEspecial")}
    method sonidoEnter() {self.pararMusica() self.reproducirEfecto("enter")}
    method sonidoCampana() {self.reproducirEfecto("campana")}
    method sonidoCampanaSimple() {self.reproducirEfecto("campanaSimple")}
    method sonidoTribuna() {self.reproducirEfecto("tribuna")}
    method sonidoAlertaEspecial() {self.reproducirEfecto("alertaEspecial")}
    method sonidoTituloRoto() {self.reproducirEfecto("tituloRoto")}
}

//IMAGEN

object gestorImagenes {
    const imagenes = new Dictionary()
    var imagenActual = "imagenPantallaCarga.png"

    method position() = game.at(0, 0)
    method image() = imagenActual

    method initialize() {
        imagenes.put("pantallaCarga", "imagenPantallaCarga.png")
        imagenes.put("menu", "imagenMenu.png")
        imagenes.put("menu2", "imagenMenu2.png")
        imagenes.put("menuDificultad", "imagenMenuDificultad.png")
        imagenes.put("versusJoe", "imagenPantallaVersusJoe.png")
        imagenes.put("versusRocky", "imagenPantallaVersusRocky.png")
        imagenes.put("versusTyson", "imagenPantallaVersusTyson.png")
        imagenes.put("pantallaDerrota", "imagenPantallaDerrota.png")
        imagenes.put("pantallaVictoria", "imagenPantallaVictoria.png")
        imagenes.put("pantallaVictoria2", "imagenPantallaVictoria2.png")
        imagenes.put("pantallaFinal", "imagenPantallaFinal.png")
        imagenes.put("ring1", "ring1.png")
        imagenes.put("ring2", "ring2.png")
        imagenes.put("ring3", "ring3.png")
    }

    method mostrarImagen(nombre) {
        imagenActual = imagenes.get(nombre)
    }

    method mostrarPantallaCarga() { self.mostrarImagen("pantallaCarga") }
    method mostrarMenu() { self.mostrarImagen("menu") }
    method mostrarMenu2() { self.mostrarImagen("menu2") }
    method mostrarMenuDificultad() { self.mostrarImagen("menuDificultad") }
    method mostrarVersusJoe() { self.mostrarImagen("versusJoe") }
    method mostrarVersusRocky() { self.mostrarImagen("versusRocky") }
    method mostrarVersusTyson() { self.mostrarImagen("versusTyson") }
    method mostrarRing1() { self.mostrarImagen("ring1") }
    method mostrarRing2() { self.mostrarImagen("ring2") }
    method mostrarRing3() { self.mostrarImagen("ring3") }
    method mostrarPantallaDerrota() { self.mostrarImagen("pantallaDerrota") }
    method mostrarPantallaVictoria() { self.mostrarImagen("pantallaVictoria") }
    method mostrarPantallaVictoria2() { self.mostrarImagen("pantallaVictoria2") }
    method mostrarPantallaFinal() { self.mostrarImagen("pantallaFinal") }
}

object tribunaLoca{
    method position() = game.at(0, 0)
    method image() = "imagenTribunaLoca.png" 

    var alocada = false
    
    method alocarse() {
        if(alocada || gestorPantallas.pantallaActual() != pantallaNivel) 
        {game.removeVisual(self) alocada = false}
        else {game.addVisual(self) alocada = true}
    }
}

object imgAtaqueEspecial{
    method position() = game.at(3, 3)
    method image() = "imgAtaqueEspecial.png"
}

//Imágenes Mario

object mario{
    var contador = 1
    var sePuedePelear = false

    method contador() = contador
    method sePuedePelear() = sePuedePelear
    method position() = game.at(13, 1)
    method image() = "mario1.png"

    method contar(){
        game.addVisual(globoDialogo)
         self.sonarCampanadas()

        game.onTick(1000, "contando", {
                if(contador < 4){
                    contador += 1
                    self.sonarCampanadas()
                }
                else{
                    contador = 4 
                    sePuedePelear = true 
                    game.removeTickEvent("contando")
                    game.removeVisual(globoDialogo)
                    game.removeVisual(self)
                }
            })
    }

    method sonarCampanadas() {if(contador <= 3) {gestorSonidos.sonidoCampanaSimple()} 
        else if(contador == 4) {gestorSonidos.sonidoCampana()}}
    method reiniciar(){
        contador = 1
        sePuedePelear = false
    }
}

object globoDialogo{
    method position() = game.at(10, 3)
    method image() = "globo" + mario.contador() + ".png"
}