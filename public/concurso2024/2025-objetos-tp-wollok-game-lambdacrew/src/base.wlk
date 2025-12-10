class Base {
    const ubicacion

    const disenio_base

    const lePerteneceA

    method image() = disenio_base

    method position() = ubicacion

    method esAtravesable(entidad) = true

    method lePerteneceA() = lePerteneceA

    method dibujarBases() {
        game.addVisual(self)
    }

    method teChocoUnTanque (tanque) {

        if (lePerteneceA == tanque) {
            tanque.banderaQueLleva().fueCapturada()
            tanque.soltar_bandera()
        }
    }

    method puedeCubrirme () = false

    
}