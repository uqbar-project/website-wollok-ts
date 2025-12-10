class Aura_escudo {
    const tanque

    method position(){
        return tanque.position()
    }

    method image(){
        return "escudo.png"
    }

    method dibujarEscudo(){
        game.addVisual(self)
    }

    method puedeSerDaniadoPorBala() = false

    method puedeCubrirme() = false

    method esAtravesable(entidad) = true

    method teChocoUnTanque(unTanque) {} 
} 