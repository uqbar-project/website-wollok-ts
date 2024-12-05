import interfaz.*
import otros.*
import juego.*

class Digito {
    var image = "numx.png"
    const position

    method image() = image
    method position() = position

    method mostrar(numero) {
        image = "num" + numero.toString() + "b.png"
    }

    method enCero() = image == "num0b.png"
}

class Marcador {
    const x
    const y

    const decena = new Digito(position=game.at(x, y))
    const unidad = new Digito(position=game.at(x+30, y))

    const digitos = [decena, unidad]

    method initialize() {
        digitos.forEach({c => game.addVisual(c)})
    }

    method mostrar(numero) {
        decena.mostrar((numero / 10).truncate(0))
        unidad.mostrar(numero % 10)
    }
}

class Temporizador inherits Marcador {
    var porcentajeRestante = 100

    method porcentajeRestante() = porcentajeRestante

    method descontar() {
        const tiempoInicial = if(config.tablero() == 1) 50 else 90
        self.mostrar(tiempoInicial)

        var tiempoRestante = tiempoInicial - 1

        game.onTick(1000, "temporizador", {
            self.mostrar(tiempoRestante)
            porcentajeRestante = 100 * (tiempoRestante) / tiempoInicial
            tiempoRestante -= 1

            if(digitos.all({c => c.enCero()})) {
                game.removeTickEvent("temporizador")
                interfaz.tiempoTerminado()
            }
        })
    }

    method seguimientoBonus() {
        self.mostrar(juego.calcularBonus())
        var bonusActual = 0

        game.onTick(1000, "bonus", {
            if(juego.calcularBonus() != bonusActual) {
                self.mostrar(juego.calcularBonus())
                bonusActual = juego.calcularBonus()
            }
        })
    }
}