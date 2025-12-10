import oleadas.*
import trucos.*

object images {
    method peonNegro() = "PNegro.png"
    method peonBlanco() = "PBlanco.png"
    method caballoNegro() = "CNegro.png"
    method caballoBlanco() = "CBlanco.png"
    method alfilNegro() = "ANegro.png"
    method alfilBlanco() = "ABlanco.png"
    method torreNegro() = "TNegro.png"
    method torreBlanco() = "TBlanco.png"
    method piezaMuerta() = if (trucos.sangre()) "Blood.gif" else "PBlancoMuerto.gif"
    method transicionOleada() = "OleadaGanada.gif"
    method rey() = "RBlanco.png"
    method rey1() = "RBlanco1Hit.png"
    method rey2() = "RBlanco2Hit.png"
    method rey3() = "RBlanco3Hit.png"
    method reyDios() = "RBlancoGOD.png"
    method damaNegro() = "DNegro.png"
}

class JaqueMate {
    const piezaDueña
    var property image = "CheckMate.gif"

    method position() = piezaDueña.position()
}

class Coronación {
    const piezaDueña
    var property image = "Coronar.gif"

    method position() = piezaDueña.position()
}

object tutorial {
    var property image = "Tutorial.gif"

    method position() = game.at(1, 2)
}